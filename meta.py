import pystache
import os
import os.path
import json
import glob
from os.path import isfile, join
import shutil
import argparse
import sys

import meta
from meta import *
from meta.utils import Utils

config = configuration.MetaConfiguration()
stringUtils = stringutils.MetaStringUtils()
    
def hashesInDir(dir):
    """docstring for hashesInDir"""
    assert dir
    
    result = []
    for f in Utils.listDir(dir):
        filePath = f
        if os.path.isfile(filePath) and os.path.splitext(os.path.basename(f))[1]=='.json':
            result.append(filePath)

    return result
    
def templatesInDir(dir):
    """docstring for templatesInDir"""
    assert dir
    
    # print("templates in dir: " + dir)
        
    result = []
    for f in Utils.listDir(dir):
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
    
def renderPlatform(product,platform,platformDir,hashes):
    """docstring for renderPlatform"""
    assert platformDir
    assert hashes
    
    templates = platformTemplates(platformDir)

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
                
            preprocessor = globalPreprocessorClass(config,stringUtils)
            preprocessor.preprocess(hash,hashes)

        if config.verbose:
            print("Hash after global preprocess: " + str(hash))
                
        # Preprocess product
        platformClass = utils.Utils.importClass(os.path.join(platformDir,config.platformFile))
        if platformClass!=None:
            platformProcessor = platformClass(config,stringUtils)

        else:
            platformProcessor = MetaProcessor(config,stringUtils)

        platformProcessor.process(hash,hashes,templates,product,platform,platformDir)        
                
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
    
    if config.verbose:
        print("product platforms path: " + productPlatformsPath)
    
    for platformDir in Utils.listDir(productPlatformsPath):
        
        platform = os.path.basename(platformDir)
        
        if config.shouldRenderPlatform(platform):        
            utils.Utils.printSection("Rendering platform: " + platform)
            utils.Utils.printBold("Path: " + platformDir)
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

    print("")        
    print("Clear output")
    if os.path.exists(config.outputPath):
        shutil.rmtree(config.outputPath)
        
    config.globalPlatformsPath = os.path.join(config.projectPath,config.platformsPath)
    
    # utils.Utils.printSection("Render products")
    for productDir in Utils.listDir(os.path.join(config.projectPath,config.productsPath)):
        productName = os.path.basename(productDir)
        utils.Utils.printSection("Rendering product: " + productName)
        utils.Utils.printBold("Path: " + productDir)
        renderProduct(productName,productDir)

    print("")
    if not utils.Utils.hasErrors:
        utils.Utils.printBold("Done. No errors")
    else:
        utils.Utils.printError("Finished with some errors")
    print("")

if __name__ == '__main__':
    main()
    