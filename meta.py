import pystache
import os
import os.path
import json
import glob
from os.path import isfile, join
import shutil
import argparse
import sys

from meta import *

config = configuration.MetaConfiguration()
stringUtils = stringutils.MetaStringUtils()

renderer = pystache.Renderer()
    
def listDir(path):
    return glob.glob(os.path.join(path, '*'))
    
def hashesInDir(dir):
    """docstring for hashesInDir"""
    assert dir
    
    result = []
    for f in listDir(dir):
        filePath = f
        if os.path.isfile(filePath) and os.path.splitext(os.path.basename(f))[1]=='.json':
            result.append(filePath)

    return result
    
def templatesInDir(dir):
    """docstring for templatesInDir"""
    assert dir
    
    # print("templates in dir: " + dir)
        
    result = []
    for f in listDir(dir):
        filePath = f
        if os.path.isfile(filePath) and os.path.splitext(os.path.basename(f))[1]=='.template':
            result.append(filePath)
    return result
    
def platformTemplates(platformDir):
    path, platform = os.path.split(platformDir)
    path, platformsDir = os.path.split(path)
    path, product = os.path.split(path)
    
    templatesDir = os.path.join(config.templatesPath,product,platformsDir,platform)
    return templatesInDir(templatesDir)
    
    
def platformPartials(platformDir):
    """docstring for platformPartials"""

    partials = {}
    
    partialsDir = os.path.join(platformDir,config.partialsPath)
    for f in listDir(partialsDir):
        name = os.path.basename(f)
        
        with open (f, "r") as file:
            partialString = file.read()
            
        partials[name] = partialString
        
    return partials
    
    
def outputDir(product,platform,template,entityName):
    """docstring for outputDir"""
    assert product
    assert platform
    assert template
        
    if not os.path.exists(config.outputPath):
        os.mkdir(config.outputPath)
    
    platformDir = os.path.join(config.outputPath,platform)
    if not os.path.exists(platformDir):
        os.mkdir(platformDir)
    
    productDir = os.path.join(platformDir,product)
    if not os.path.exists(productDir):
        os.mkdir(productDir)

    templateName = os.path.splitext(template)[0]

    result = os.path.join(productDir,templateName)
    
    return result
    
def readHash(hashPath):
    assert hashPath
    
    with open (hashPath, "r") as f:
        hashString = f.read()
    try:
        hashObject = json.loads(hashString)
    except:
        print("Error reading json file: " + hashPath)
        sys.exit()
    
    return hashObject
    
def readTemplate(templatePath):
    assert templatePath
    
    with open (templatePath, "r") as f:
        templateString = f.read()

    return templateString
    
def renderPlatform(product,platform,platformDir,hashes):
    """docstring for renderPlatform"""
    assert platformDir
    assert hashes
    
    templates = platformTemplates(platformDir)
    # templates = templatesInDir(platformDir)
    log = "Templates: " + str(templates)
    if len(templates)==0:
        utils.Utils.printError(log)
    else:
        utils.Utils.printBold(log)
    
    globalPlatformDir = os.path.join(config.globalPlatformsPath,platform)

    if config.verbose:
        print("Global platform dir: " + globalPlatformDir)

    # Platform preprocess
    globalPreprocessorClass = utils.Utils.importClass(os.path.join(globalPlatformDir,config.preprocessorFile))
    
    for hashFile in hashes:
        hash = readHash(hashFile)
        
        # Global Platform preprocess
        if globalPreprocessorClass!=None:

            if config.verbose:
                print('Global Preprocessing')
                
            preprocessor = globalPreprocessorClass(stringUtils)
            preprocessor.preprocess(hash,hashes)

        if config.verbose:
            print("Hash after global preprocess: " + str(hash))
                
        # Preprocess product
        platformClass = utils.Utils.importClass(os.path.join(platformDir,config.platformFile))
        if platformClass!=None:
            platformProcessor = platformClass(stringUtils)
            platformProcessor.preprocess(hash,hashes)
        
        if config.verbose:
            print("Hash after product preprocess: " + str(hash))
        
        partials = platformPartials(platformDir)
        renderer = pystache.Renderer(partials=partials)
        
        for templateFile in templates:
            # template = readTemplate(templateFile)
            
            fileName = os.path.basename(templateFile)
            if (platformProcessor):
                fileName = platformProcessor.finalFileName(fileName,hash)

            if hash!=None and '_globals_' in hash:
                # Remove .template
                realFileName, extension = os.path.splitext(fileName)
            
                # Split final file name into components
                baseName, extension = os.path.splitext(realFileName)
                
                hash['_globals_']['fileName'] = realFileName
                hash['_globals_']['fileBaseName'] = baseName
                hash['_globals_']['fileExtension'] = extension  
                        
            if config.verbose:
                print('Hash: ' + str(hash))            
            
            rendered = renderer.render_path(templateFile,hash)
            entityName = None
            if hash!=None and 'entityName' in hash:
                entityName = hash['entityName']
            
            
            outputPath = outputDir(product,platform,fileName,entityName)
            
            utils.Utils.printOutput("Rendering to file: " + outputPath)
            
            with open(outputPath, "w") as f:
                f.write(rendered)
                
def renderProduct(product,productPath):
    """docstring for renderProduct"""
    assert productPath
        
    hashes = hashesInDir(productPath)
    if len(hashes)==0:
        utils.Utils.printError("No hashes for product: " + product)
        return
    
    utils.Utils.printSubSection("Hashes:" + str(hashes))

    productPlatformsPath = os.path.join(config.templatesPath,product,config.platformsPath)
    
    # productPlatformsPath = os.path.join(productPath,config.platformsPath)
    
    print("product platforms path: " + productPlatformsPath)
    
    for platformDir in listDir(productPlatformsPath):
        
        platform = os.path.basename(platformDir)
        
        if config.shouldRenderPlatform(platform):        
            utils.Utils.printSection("Rendering platform: "+platformDir)
            renderPlatform(product,platform,platformDir,hashes)
        elif config.verbose:
            utils.Utils.printSection("Skipping platform: " + platform)
                
def main():
    global config
    
    parser = argparse.ArgumentParser(description='Meta project command line utility. Renders files from hashes and templates.')
    parser.add_argument('config_file', help='the path of a meta configuration file in json format')
    parser.add_argument('-v', dest='verbose', help='verbose (show more info about execution)',action="store_true")
    args = parser.parse_args()

    config.readConfig(args.config_file)
    config.verbose = args.verbose
    
    if config.verbose:
        print("")
        print("Verbose mode on")
        
    utils.Utils.printSection("Clear output")
    if os.path.exists(config.outputPath):
        shutil.rmtree(config.outputPath)
        
    config.globalPlatformsPath = os.path.join(config.projectPath,config.platformsPath)
    
    utils.Utils.printSection("Render products")
    for productDir in listDir(os.path.join(config.projectPath,config.productsPath)):
        utils.Utils.printSection("Rendering product: " + productDir)
        renderProduct(os.path.basename(productDir),productDir)

    print("")
    if not utils.Utils.hasErrors:
        utils.Utils.printBold("Done. No errors")
    else:
        utils.Utils.printError("Finished with some errors")
    print("")

if __name__ == '__main__':
    main()