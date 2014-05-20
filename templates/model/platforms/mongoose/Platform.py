import sys
import os
import json
from meta.MetaProcessor import MetaProcessor

class Platform(MetaProcessor):
    """docstring for Platform"""
    
    def preprocessType(self,type):
        """docstring for preprocessType"""
        if type=='string':
            return 'String'
        elif type=='integer':
            return 'Number'
        elif type=='float':
            return 'Number'
        elif type=='double':
            return 'Number'
        elif type=='bool':
            return 'Boolean'
        elif type=='date':
            return 'Date'
        else:
            print("Error: unknown property type: " + type)
            sys.exit()
        
    def preprocessPrimaryKeys(self,primaryKeys,properties):
        """docstring for preprocessPrimaryKeys"""
        assert len(primaryKeys)<2

        self.preprocessList(primaryKeys)
        keyName = primaryKeys[0]['name']
        for property in properties:
            if property['name']==keyName:
                property['name'] = '_id'
                break
        
        primaryKeys[0]['name'] = '_id'
        
    def preprocessProperty(self,property,hash,hashes):
        """docstring for preprocessProperty"""
        property['_camelcase_'] = self.stringUtils.camelcase(str(property['name']))
        property['_capitalized_'] = self.stringUtils.capitalize(str(property['name']))
        
        type = property['type']
        property['type_' + type] = True
        
        if 'default' in property:
            property['_has_default_'] = True
     
        property['type'] = self.preprocessType(type)
                        
        return True
   
    def preprocessRelationships(self,relationships,hash,hashes):
        """docstring for preprocessRelationships"""
        for relationship in relationships:
            entityName = relationship['entityName']
            
            type = relationship['type']
            relationship['type_' + type] = True
            if 'required' in relationship and relationship['required']==True:
                relationship['_optional_'] = "NO"
            else:
                relationship['_optional_'] = "YES"
            if relationship['type']=='toMany':
                relationship['_toMany_'] = True
            else:
                relationship['min'] = "1"
                relationship['max'] = "1"
            
            for relationshipHashFile in hashes:
                relationshipHash = self.readHash(relationshipHashFile)
                if relationshipHash['entityName']==entityName:
                    relationship['primaryKeys'] = relationshipHash['primaryKeys']
                    primaryKeys = relationship['primaryKeys']
                    if len(primaryKeys)>1:
                        print("Error: Sorry, mongoose doesn't support multiple primary keys for reference population")
                        sys.exit();
                    for key in primaryKeys:
                        for property in relationshipHash['properties']:
                            if property['name']==key['name']:
                                key['type'] = self.preprocessType(property['type'])
                    break
    
    def preprocess(self,hash,hashes):
        if hash!=None and 'primaryKeys' in hash and 'properties' in hash:
            self.globalPlatform.preprocessPrimaryKeys(hash['primaryKeys'],hash['properties'])
        
        if hash!=None and 'properties' in hash:
            i=0
            properties = hash['properties']
            propertiesToDelete = []
            for property in properties:
                keepProperty = self.preprocessProperty(property,hash,hashes)
                if not keepProperty:
                    propertiesToDelete.append(property)
            
            for property in propertiesToDelete:
                properties.remove(property)        
            
            properties[len(properties)-1]['_last_'] = True
            
        if hash!=None and 'relationships' in hash:
            relationships = hash['relationships']
            self.preprocessList(relationships)
            self.preprocessRelationships(relationships,hash,hashes)
        
                        
    def finalFileName(self,fileName,hash):
        """docstring for finalFileName"""

        entityName = None
        if hash!=None and 'entityName' in hash:
            entityName = hash['entityName']
        if (entityName):
            fileName = fileName.replace("entity",entityName)
        
        return fileName