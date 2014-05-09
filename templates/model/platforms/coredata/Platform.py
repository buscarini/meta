import sys
import os
import json
from meta.MetaProcessor import MetaProcessor

class Platform(MetaProcessor):
    """docstring for Platform"""
        
    def preprocess_property(self,property,hash,hashes):
        """docstring for preprocess_property"""
        property['_camelcase_'] = self.stringUtils.camelcase(str(property['name']))
        property['_capitalized_'] = self.stringUtils.capitalize(str(property['name']))
        
        type = property['type']
        property['type_' + type] = True
     
        if type=='string':
            property['type'] = 'String'
        elif type=='integer':
            property['type'] = 'Integer 32'
        elif type=='float':
            property['type'] = 'float'
        elif type=='double':
            property['type'] = 'double'
        elif type=='bool':
            property['type'] = 'Boolean'
        elif type=='date':
            property['type'] = 'Date'
        elif type=='relationship':
            pass
        else:
            print("Error: unknown property type: " + type)
            sys.exit()
            
    def preprocess(self,hash,hashes):
        if hash!=None and 'properties' in hash:
            i=0
            properties = hash['properties']
            for property in properties:
                self.preprocess_property(property,hash,hashes)
                i=i+1
                
            properties[len(properties)-1]['_last_'] = True
            
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
        
        globalPlatformDir = os.path.join(config.globalPlatformsPath,platform)
        globalPreprocessorClass = Utils.importClass(os.path.join(globalPlatformDir,config.preprocessorFile))
        
        for hashFile in hashes:
            hash = Utils.readJSONFile(hashFile)
            
            
        
        