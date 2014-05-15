import sys
import os
import json
import meta
from meta.MetaProcessor import MetaProcessor

class Platform(MetaProcessor):
    """docstring for Platform"""
    def entityName(self,entityName,hash):
        """docstring for entityName"""
        return '_' + hash['_globals_']['prefix'] + entityName                
        
    # def preprocess_relationship(self,property,hash,hashes):
 #        """docstring for preprocess_relationship"""
 #                
 #        if 'destination' in property:
 #            hashFileName = property['destination'] + ".json"
 #            matching = [s for s in hashes if hashFileName==os.path.basename(s)]
 #            if len(matching)>0:
 #                with open (matching[0], "r") as f:
 #                    hashString = f.read()
 #                hashObject = json.loads(hashString)
 #                
 #                entityName = hashObject['entityName']
 #                finalEntityName = self.entityName(entityName,hash)
 #                if not 'forward_classes' in hash:
 #                    hash['forward_classes'] = []
 #                hash['forward_classes'].append({ "class" : finalEntityName })
 #                                
 #                storage = 'strong'
 #                if property['weak']:
 #                    storage = 'weak'
 #                    
 #                if property['relationshipType']=='toOne':
 #                    property['type'] = finalEntityName
 #                    property['object'] = True
 #                    property['storage'] = storage
 #                elif property['relationshipType']=='toMany':
 #                    property['type'] = 'NSMutableSet'
 #                    property['object'] = True
 #                    property['storage'] = storage
 #                else:
 #                    print("Error: relationshipType unknown (toOne, toMany): " + property['relationshipType'])
 #                    sys.exit()
 #            else:
 #               print("Error: destination hash not found: " + hashFileName + " in " + str(hashes))
 #               sys.exit()
 #        else:
 #            print("Error: destination missing in relationship property: " + property)
 #            sys.exit()
 #            
        
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
            
    def preprocess(self,hash,hashes):
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