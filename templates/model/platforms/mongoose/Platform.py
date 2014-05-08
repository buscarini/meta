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
        
        if 'default' in property:
            property['_has_default_'] = True
     
        if type=='string':
            property['type'] = 'String'
        elif type=='integer':
            property['type'] = 'Number'
        elif type=='float':
            property['type'] = 'Number'
        elif type=='double':
            property['type'] = 'Number'
        elif type=='bool':
            property['type'] = 'Boolean'
        elif type=='date':
            property['type'] = 'Date'
        elif type=='relationship':
            return False            
        else:
            print("Error: unknown property type: " + type)
            sys.exit()
                        
        return True
            
    def preprocess(self,hash,hashes):
        if hash!=None and 'properties' in hash:
            i=0
            properties = hash['properties']
            propertiesToDelete = []
            for property in properties:
                keepProperty = self.preprocess_property(property,hash,hashes)
                if not keepProperty:
                    propertiesToDelete.append(property)
            
            for property in propertiesToDelete:
                properties.remove(property)        
            
            properties[len(properties)-1]['_last_'] = True
                        
    def finalFileName(self,fileName,hash):
        """docstring for finalFileName"""

        entityName = None
        if hash!=None and 'entityName' in hash:
            entityName = hash['entityName']
        if (entityName):
            fileName = fileName.replace("entity",entityName)
        
        return fileName