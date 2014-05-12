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
        
        if 'default' in property:
            property['default'] = self.globalPlatform.platformValueForValue(property['default'])
        
        type = property['type']
        property['type_' + type] = True
        
        platformType = self.globalPlatform.platformTypeForType(type)
        if platformType!=None:
            property['type'] = platformType
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
            
            self.preprocessList(properties)
            
        if hash!=None and 'primaryKeys' in hash:
            self.preprocessList(hash['primaryKeys'])
            
    def finalFileName(self,fileName,hash):
        """docstring for finalFileName"""

        entityName = None
        if hash!=None and 'entityName' in hash:
            entityName = hash['entityName']
        if (entityName):
            fileName = fileName.replace("entity",entityName)
        
        return fileName