import os
import json
import sys

class MetaConfiguration(object):
    """docstring for MetaConfiguration"""
    def __init__(self):
        super(MetaConfiguration, self).__init__()
    	self.projectPath = "project"
    	self.templatesPath = "templates"
    	self.outputPath = "output"
    	self.hashesPath = "hashes"
    	self.preprocessorFile = "Preprocessor"
        self.platformsPath = "platforms"
        self.productsPath = "products"
    	self.platformFile = "Platform"
    	self.partialsPath = "partials"
    	self.platforms = None
        self.verbose = False
        
    def readConfigObject(self,filePath):
        with open (filePath, "r") as f:
            fileString = f.read()
        try:
            configObject = json.loads(fileString)
        except:
            print("Error reading json file: " + filePath)
            sys.exit()

        return configObject
        
    def readConfig(self,filePath):
        """docstring for readConfig"""
        configObject = self.readConfigObject(filePath)
        
        for key,value in configObject.items():
            setattr(self,key,value)
            
    def shouldRenderPlatform(self,platform):
        """docstring for shouldRenderPlatform"""
        if self.platforms==None or platform in self.platforms:
            return True
        else:
            return False
        
        