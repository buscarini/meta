import os
import os.path
import sys
import pystache
from utils import Utils

class MetaProcessor(object):
    """docstring for MetaProcessor"""
    def __init__(self, config,stringUtils):
        super(MetaProcessor, self).__init__()
        self.config = config
        self.stringUtils = stringUtils
        
    def platformPartials(self,platformDir):
        """docstring for platformPartials"""

        partials = {}
    
        partialsDir = os.path.join(platformDir,self.config.partialsPath)
        for f in Utils.listDir(partialsDir):
            name = os.path.basename(f)
        
            with open (f, "r") as file:
                partialString = file.read()
            
            partials[name] = partialString
        
        return partials
        
    def outputDir(self,product,platform,template):
        """returns the final output directory"""
        assert product
        assert platform
        assert template
        
        if not os.path.exists(self.config.outputPath):
            os.mkdir(self.config.outputPath)
    
        platformDir = os.path.join(self.config.outputPath,platform)
        if not os.path.exists(platformDir):
            os.mkdir(platformDir)
    
        productDir = os.path.join(platformDir,product)
        if not os.path.exists(productDir):
            os.mkdir(productDir)

        templateName = os.path.splitext(template)[0]

        result = os.path.join(productDir,templateName)
    
        return result
            
    def preprocess(self,hash,hashes):
        pass
        
    def renderer(self,platformDir):
        partials = self.platformPartials(platformDir)
        return pystache.Renderer(partials=partials)
    
    def process(self,hash,hashes,templates,product,platform,platformDir):
        
        assert hash
        assert templates
        assert platformDir
        
        self.preprocess(hash,hashes)
        
        if self.config.verbose:
            print("Hash after product preprocess: " + str(hash))
    
        renderer = self.renderer(platformDir)
        
        for templateFile in templates:
           self.renderTemplate(renderer,templateFile,hash,hashes,product,platform,platformDir) 

    def finalFileName(self,fileName,hash):
        """docstring for finalFileName"""
        return fileName
        
    def readTemplate(self,templatePath):
        assert templatePath
    
        with open (templatePath, "r") as f:
            templateString = f.read()

        return templateString
                
    def renderTemplate(self,renderer,templateFile,hash,hashes,product,platform,platformDir):
        """docstring for renderTemplate"""
        assert renderer
        assert templateFile
        assert hash
        assert hashes
        assert product
        assert platform
        assert platformDir

        template = self.readTemplate(templateFile)
        
        fileName = os.path.basename(templateFile)
        fileName = self.finalFileName(fileName,hash)

        if hash!=None and '_globals_' in hash:
            # Remove .template
            realFileName, extension = os.path.splitext(fileName)
        
            # Split final file name into components
            baseName, extension = os.path.splitext(realFileName)
            
            hash['_globals_']['fileName'] = realFileName
            hash['_globals_']['fileBaseName'] = baseName
            hash['_globals_']['fileExtension'] = extension  
                    
        if self.config.verbose:
            print('Hash: ' + str(hash))            
        
        rendered = renderer.render_path(templateFile,hash)
        
        outputPath = self.outputDir(product,platform,fileName)
        
        Utils.printOutput("Rendering to file: " + outputPath)
        
        with open(outputPath, "w") as f:
            f.write(rendered)
        
