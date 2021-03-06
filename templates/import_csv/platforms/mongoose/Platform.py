import sys
import os
import json
from meta.MetaProcessor import MetaProcessor

class Platform(MetaProcessor):
    """docstring for Platform"""
        
    def preprocess_property(self,property,index,hash,hashes):
        """docstring for preprocess_property"""
        property['_camelcase_'] = self.stringUtils.camelcase(str(property['name']))
        property['_capitalized_'] = self.stringUtils.capitalize(str(property['name']))
        
        type = property['type']
        property['type_' + type] = True
        property['index'] = index
        if 'default' in property:
            property['_has_default_'] = True
        if 'format' in property:
            format = property['format']
            format = format.replace("d","D")
            format = format.replace('y','Y')
            property['format'] = format
     
    def preprocess(self,hash,hashes):
        
        if hash!=None and 'primaryKeys' in hash:
            primaryKeys = hash['primaryKeys']
            self.preprocessList(primaryKeys)
            if 'properties' in hash:
                properties = hash['properties']
                self.globalPlatform.preprocessPrimaryKeys(primaryKeys,properties)
                
                self.preprocessList(properties)
                for key in primaryKeys:
                    for property in properties:
                        if key['name']==property['name']:
                            key['type_' + property['type']] = True
                
        
        if hash!=None and 'properties' in hash:
            
            i=0
            properties = hash['properties']
            for property in properties:
                self.preprocess_property(property,i,hash,hashes)
                i=i+1
            
            properties[len(properties)-1]['_last_'] = True

            
            
    def finalFileName(self,fileName,hash):
        """docstring for finalFileName"""

        entityName = None
        if hash!=None and 'entityName' in hash:
            entityName = hash['entityName']
        if (entityName):
            fileName = fileName.replace("entity",entityName)
        
        return fileName