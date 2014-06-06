import os
import os.path
import sys
import pystache
from utils import Utils

class MetaProcessor(object):
    """docstring for MetaProcessor"""
    def __init__(self, config,stringUtils):
        assert config
        assert stringUtils
        
        super(MetaProcessor, self).__init__()
        self.config = config
        self.stringUtils = stringUtils
        
    def preprocessList(self,list):
        if len(list)==0:
            return

        i = 0
        for item in list:
            item['_index_'] = i
            item['_first_'] = False
            item['_last_'] = False
            i = i+1
            
        list[0]["_first_"] = True
        list[0]["_count_"] = len(list)
        list[len(list)-1]['_last_'] = True

            
    def sortHashes(self,hashes):
        """docstring for sortHashes"""
        return hashes
        
    def platformPartials(self,platformDir):
        """docstring for platformPartials"""
        assert platformDir

        partials = {}
    
        partialsDir = os.path.join(platformDir,self.config.partialsPath)
        for f in Utils.listDir(partialsDir):
            name = os.path.basename(f)
        
            with open (f, "r") as file:
                partialString = file.read()
            
            partials[name] = partialString
        
        return partials
        
    def findValuesForKey(self,hash,key):
        """docstring for findValuesForKey"""
        values = []
        
        if isinstance(hash,dict):
            values += self.findValuesForKeyInDic(hash,key)
        elif isinstance(hash, list):
            values += self.findValuesForKeyInArray(hash,key)
                    
        return values
        
    def findValuesForKeyInArray(self,array,key):
        """docstring for findValuesForKeyInArray"""
        values = []
        for item in array:
            values += self.findValuesForKey(hash,key)
        return values
        
    def findValuesForKeyInDic(self,dic,key):
        """docstring for findValuesForKeyInDic"""
        values = []
        for dicKey,value in dic.iteritems():
            if key==dicKey:
                values.append(value)
            else:
                values += self.findValuesForKey(hash,key)
        return values
        
    def findDictsWithKey(self,hash,key):
        """docstring for findDictsWithKey"""
        values = []
    
        if isinstance(hash,dict):
            values += self.findDictsWithKeyInDic(hash,key)
        elif isinstance(hash, list):
            values += self.findDictsWithKeyInArray(hash,key)
                
        return values
        
    def findDictsWithKeyInArray(self,array,key):
        """docstring for findValuesForKeyInArray"""                
        values = []
        for item in array:
            values += self.findDictsWithKey(item,key)
        return values
    
    def findDictsWithKeyInDic(self,dic,key):
        """docstring for findValuesForKeyInDic"""
        values = []
        for dicKey,value in dic.iteritems():
            if key==dicKey:
                values.append(dic)
            else:
                values += self.findDictsWithKey(value,key)
        return values
        
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
        assert hash
        assert hashes
        pass
        
    def renderer(self,platformDir):
        assert platformDir
        
        partials = self.platformPartials(platformDir)
        return pystache.Renderer(partials=partials)
        
    def readHash(self,hashPath):
        assert hashPath
        
        hashObject = Utils.readJSONFile(hashPath)
        assert hashObject!=None
        
        return hashObject
        
    def globalProcessor(self,platform):
        globalPlatformDir = os.path.join(self.config.globalPlatformsPath,platform)

        globalPreprocessor = None
        classFilePath = os.path.join(globalPlatformDir,self.config.preprocessorFile)
        globalPreprocessorClass = Utils.importClass(classFilePath)
        if globalPreprocessorClass!=None:
            globalPreprocessor = globalPreprocessorClass(self.config,self.stringUtils)
        else:
            print("No global processor for platform: " + platform + " in path: " + classFilePath)
        
        return globalPreprocessor
    
    def process(self,hashes,templates,product,platform,platformDir):
        assert hashes
        assert templates
        assert product
        assert platform
        assert platformDir
            
        self.globalPlatform = self.globalProcessor(platform)
        
        hashes = self.sortHashes(hashes)
            
        for hashFile in hashes:
            hash = self.readHash(hashFile)
        
            # Global Platform preprocess
            if self.globalPlatform!=None:
                if self.config.verbose:
                    print('Global Preprocessing')
                
                self.globalPlatform.preprocess(hash,hashes)

            if self.config.verbose:
                print("Hash after global preprocess: " + str(hash))


            self.preprocess(hash,hashes)
            
            if self.config.verbose:
                print("Hash after product preprocess: " + str(hash))

            if self.config.verbose:
                with open("/tmp/final_hash" + os.path.basename(hashFile) + "_" + product + "_" + platform, "w") as f:
                    f.write(str(hash))
    
            renderer = self.renderer(platformDir)
        
            for templateFile in templates:
               self.renderTemplate(renderer,templateFile,hash,hashes,product,platform,platformDir)


    def finalFileName(self,fileName,hash):
        assert fileName
        assert hash
        
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
        
