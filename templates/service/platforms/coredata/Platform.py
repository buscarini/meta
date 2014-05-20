import sys
import json
from meta.MetaProcessor import MetaProcessor
from meta.utils import Utils

class Platform(MetaProcessor):
    """docstring for Platform"""
        
    def preprocessType(self,dic):
        """docstring for preprocessType"""
        if dic!=None and 'type' in dic:
            typeValue = dic['type']
            dic['type_' + typeValue] = True
            
    def preprocessRelationship(self,property,hash,hashes):
        return self.preprocessModel(property,hash,hashes)
        
    def preprocessProperty(self,property,hash,hashes):
        """docstring for preprocessProperty"""
        
        type = property['type']
        property['type_relationship'] = False
        property['type_' + type] = True
        
        if type=='string':
            property['type'] = 'NSString'
            property['object'] = True
        elif type=='integer':
            property['type'] = 'NSInteger'
            property['object'] = False
        elif type=='float':
            property['type'] = 'CGFloat'
            property['object'] = False
        elif type=='double':
            property['type'] = 'double'
            property['object'] = False
        elif type=='bool':
            property['type'] = 'BOOL'
            property['object'] = False
        elif type=='date':
            property['type'] = 'NSDate'
            property['object'] = True
        elif type=='relationship':
            if property['relationshipType']=='toMany':
                property['toMany'] = True
            else:
                property['toMany'] = False
                
            property.update(self.preprocessRelationship(property,hash,hashes))
        else:
            Utils.printError("Error: unknown property type: " + type)
            sys.exit()
            
    def preprocessHash(self,key,hashName,hash,hashes):
        """Preprocess entity defined in a different hash"""
        hashFileName = hashName + ".json"
        matching = [s for s in hashes if hashFileName==os.path.basename(s)]
        if len(matching)>0:
            with open (matching[0], "r") as f:
                hashString = f.read()
            hashObject = json.loads(hashString)
            
            return self.preprocessModel(hashObject,hash,hashes)
        else:
            Utils.printError("Error: hash: " + hashName + " not found in " + str(hashes))
            sys.exit()
            
    def preprocessDateFormats(self,key):
        """docstring for preprocessDateFormats"""
        
        formats = []
        for property in key['properties']:
            if 'format' in property:
                format = property['format']
                formatIsUnique = True
                for f in formats:
                    if f['format']==format:
                        property['_format_name_'] = f['name']
                        formatIsUnique = False
                        break

                if formatIsUnique:
                    formatObject = { "name" : property['name'], "format" : format }
                    property['_format_name_'] = property['name']
                    formats.append(formatObject)
              
        key['_formats_'] = formats
        
    def preprocessModel(self,key,hash,hashes):
        """Preprocess entity"""
        
        if 'hash' in key:
            key = self.preprocessHash(key,key['hash'],hash,hashes)
        else:
            key['_entity_imports_'].append({ "name" : self.finalEntityFileName(key['entityName'],hash) + '.h' })
            for property in key['properties']:
                self.preprocessProperty(property,hash,hashes)

            self.preprocessDateFormats(key)
                
        return key
        
    def preprocessResultValue(self,resultValue):
        """docstring for preprocessResultValue"""
        if 'type' in resultValue:
            type = resultValue['type']
            if type=='string':
                resultValue['okValue'] = '@"' + resultValue['okValue'] + '"'
                resultValue['errorValue'] = '@"' + resultValue['errorValue'] + '"'
            elif type=='integer':
                resultValue['okValue'] = "@" + resultValue['okValue']
                resultValue['errorValue'] = "@" + resultValue['errorValue']
            else:
                print("Error: unknown result value type: " + type)
                sys.exit()
            
        self.preprocessType(resultValue)
        
    def preprocess(self,hash,hashes):
        
        # hash['_entity_imports_'] = []

        if hash!=None and 'resultValue' in hash:
            resultValue = hash['resultValue']
            self.preprocessResultValue(resultValue)
        
        if hash!=None and 'content' in hash:
            contents = hash['content']
            for content in contents:
                if 'model' in content:
                    model = content['model']
                    model['_entity_imports_'] = []
                    newKey = self.preprocessModel(model,hash,hashes)
                    model.update(newKey)
                    
    def finalEntityFileName(self,fileName,hash):
        """docstring for finalFileName"""
        prefix = ""
        if hash!=None and '_globals_' in hash:
           globals = hash['_globals_']
           if 'prefix' in globals:
               prefix = globals['prefix']

        fileName = prefix + fileName

        return fileName
                
    def finalFileName(self,fileName,hash):
        """docstring for finalFileName"""
        prefix = ""
        if hash!=None and '_globals_' in hash:
           globals = hash['_globals_']
           if 'prefix' in globals:
               prefix = globals['prefix']

        serviceName = ""
        if hash!=None and 'serviceName' in hash:
            serviceName = self.stringUtils.capitalize(hash['serviceName'])

        fileName = prefix + serviceName + fileName

        return fileName