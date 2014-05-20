import sys
import os
import json
import meta

import inflect
pluralEngine = inflect.engine()

from meta.MetaProcessor import MetaProcessor

class Platform(MetaProcessor):
    """docstring for Platform"""
    def entityName(self,entityName,hash):
        """docstring for entityName"""
        return '_' + hash['_globals_']['prefix'] + entityName                
 
    def preprocess_property(self,property,hash,hashes):
        
        self.globalPlatform.processProperty(property,hash,hashes)
        if type=='relationship':
                    self.preprocess_relationship(property,hash,hashes)
                    
    def preprocessRelationships(self,relationships,hash,hashes):
        self.preprocessList(relationships)
        for relationship in relationships:
            relationship['entityName'] = self.entityName(relationship['entityName'],hash)
            type = relationship['type']
            relationship['type_' + type] = True
            if type=='toOne':
                type = relationship['entityName']
            else:
                type = 'NSSet'

            relationship['type'] = type
            
            relationship['name_capitalized'] = self.stringUtils.capitalize(relationship['name'])
            
    def preprocess(self,hash,hashes):
        if hash!=None and 'entityName' in hash:
            if '_globals_' in hash:
                globals = hash['_globals_']
                if 'prefix' in globals:
                    hash['_finalEntityName_'] = globals['prefix'] + hash['entityName']
                    hash['_lowercaseEntityName_'] = self.stringUtils.lowercase(hash['entityName'])
                    hash['_pluralEntityName_'] = pluralEngine.plural(hash['entityName'])
                    
        if hash!=None and 'primaryKeys' in hash:
            primaryKeys = hash['primaryKeys']
            self.preprocessList(primaryKeys)
        
        if hash!=None and 'properties' in hash:
            for property in hash['properties']:
                self.preprocess_property(property,hash,hashes)

        if hash!=None and 'relationships' in hash:
            relationships = hash['relationships']
            self.preprocessRelationships(relationships,hash,hashes)
            
    def finalFileName(self,fileName,hash):
        """docstring for finalFileName"""

        prefix = ""
        if hash!=None and '_globals_' in hash:
            globals = hash['_globals_']
            if 'prefix' in globals:
                prefix = globals['prefix']

        entityName = None
        if hash!=None and 'entityName' in hash:
            entityName = hash['entityName']
        if (entityName):
            fileName = fileName.replace("entity",prefix + entityName)
        
        return fileName