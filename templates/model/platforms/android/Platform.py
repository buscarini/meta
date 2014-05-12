import sys
import os
import json

from meta.MetaProcessor import MetaProcessor

class Platform(MetaProcessor):
    """docstring for Platform"""
        
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
                finalEntityName = '_' + entityName
                if not 'forward_classes' in hash:
                    hash['forward_classes'] = []
                hash['forward_classes'].append({ "class" : finalEntityName })
                                    
                if property['relationshipType']=='toOne':
                    property['type'] = finalEntityName
                elif property['relationshipType']=='toMany':
                    property['type'] = finalEntityName + '[]'
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
        property['_camelcase_'] = self.stringUtils.camelcase(str(property['name']))
        property['_capitalized_'] = self.stringUtils.capitalize(str(property['name']))
        
        type = property['type']
        property['type_' + type] = True
        
        platformType = self.globalPlatform.platformTypeForType(type)
        if platformType!=None:
            property['type'] = platformType
        elif type=='relationship':
            self.preprocess_relationship(property,hash,hashes)            
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
            # properties[len(properties)-1]['_last_'] = True            
            
    def finalFileName(self,fileName,hash):
        """docstring for finalFileName"""

        entityName = None
        if hash!=None and 'entityName' in hash:
            entityName = hash['entityName']
        if (entityName):
            fileName = fileName.replace("entity",entityName)
        
        return fileName