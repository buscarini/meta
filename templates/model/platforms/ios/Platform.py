import sys
import os
import json
import meta
from meta.MetaProcessor import MetaProcessor

class Platform(MetaProcessor):
    """docstring for Platform"""
    # def __init__(self,stringUtils):
 #        super(Platform, self).__init__()
 #        self.stringUtils = stringUtils
        
    def preprocess_relationship(self,property,hash,hashes):
        """docstring for preprocess_relationship"""
                
        if 'destination' in property:
            hashFileName = property['destination'] + ".json"
            matching = [s for s in hashes if hashFileName==os.path.basename(s)]
            if len(matching)>0:
                with open (matching[0], "r") as f:
                    hashString = f.read()
                hashObject = json.loads(hashString)
                
                entityName = hashObject['entityName']
                finalEntityName = '_' + hash['_globals_']['prefix'] + entityName                
                if not 'forward_classes' in hash:
                    hash['forward_classes'] = []
                hash['forward_classes'].append({ "class" : finalEntityName })
                                
                storage = 'strong'
                if property['weak']:
                    storage = 'weak'
                    
                if property['relationshipType']=='toOne':
                    property['type'] = finalEntityName
                    property['object'] = True
                    property['storage'] = storage
                elif property['relationshipType']=='toMany':
                    property['type'] = 'NSMutableSet'
                    property['object'] = True
                    property['storage'] = storage
                else:
                    print("Error: relationshipType unknown (toOne, toMany): " + property['relationshipType'])
                    sys.exit()
            else:
               print("Error: destination hash not found: " + hashFileName + " in " + str(hashes))
               sys.exit()
        else:
            print("Error: destination missing in relationship property: " + property)
            sys.exit()
            
        
    def preprocess_property(self,property,hash,hashes):
        """docstring for preprocess_property"""
        
        self.globalPlatform.processProperty(property,hash,hashes)
        
        if type=='relationship':
            self.preprocess_relationship(property,hash,hashes)
            
        property['_storage_' + property['storage']] = True
                
    def preprocess(self,hash,hashes):
        if hash!=None and 'properties' in hash:
            for property in hash['properties']:
                self.preprocess_property(property,hash,hashes)
            
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