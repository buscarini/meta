import sys
import json
from meta.MetaProcessor import MetaProcessor
from meta.utils import Utils
import re
import copy

import traceback

class Platform(MetaProcessor):
    """docstring for Platform"""

    def __init__(self,config,stringUtils):
        super(Platform, self).__init__(config, stringUtils)
        
        self.entityPattern = re.compile("entity", re.IGNORECASE)
        self.servicePattern = re.compile("service", re.IGNORECASE)

    def findEntities(self,hash):
        """docstring for findEntities"""
        return self.findDictsWithKey(hash,"entityName")

    def preprocessType(self,dic):
        """docstring for preprocessType"""
        if dic!=None and 'type' in dic:
            typeValue = dic['type']
            dic['type_' + typeValue] = True
        
    def preprocessProperty(self,property,hash,hashes):
        """docstring for preprocessProperty"""
        
        print("preprocess property " + str(property))
        return self.globalPlatform.processProperty(property,hash,hashes)
        
        # print("preprocess property " + str(property))
        # 
        # type = property['type']
        # property['type_relationship'] = False
        # property['type_' + type] = True
        # 
        # if type=='string' or type=='url':
        #     property['type'] = 'NSString'
        #     property['object'] = True
        # elif type=='integer':
        #     property['type'] = 'NSInteger'
        #     property['object'] = False
        # elif type=='float':
        #     property['type'] = 'CGFloat'
        #     property['object'] = False
        # elif type=='double':
        #     property['type'] = 'double'
        #     property['object'] = False
        # elif type=='bool':
        #     property['type'] = 'BOOL'
        #     property['object'] = False
        # elif type=='date':
        #     property['type'] = 'NSDate'
        #     property['object'] = True
        # elif type=='relationship':
        #     if property['relationshipType']=='toMany':
        #         property['_toMany_'] = True
        #     else:
        #         property['_toMany_'] = False
        #         
        #     property.update(self.preprocessRelationship(property,hashes))
        # else:
        #     Utils.printError("Error: unknown property type: " + type)
        #     sys.exit()
            
    def preprocessHash(self,key,hashName,hash,hashes):
        """Preprocess entity defined in a different hash"""
        hashFileName = hashName + ".json"
        matching = [s for s in hashes if hashFileName==os.path.basename(s)]
        if len(matching)>0:
            with open (matching[0], "r") as f:
                hashString = f.read()
            hashObject = json.loads(hashString)
            
            return self.preprocessModel(hashObject,hashes)
        else:
            Utils.printError("Error: hash: " + hashName + " not found in " + str(hashes))
            sys.exit()
            
    def preprocessPrimaryKeys(self,primaryKeys,model,hashes):
        """docstring for preprocessPrimaryKeys"""
        self.preprocessList(primaryKeys)
        if 'properties' in model:
            properties = model['properties']
            for primaryKey in primaryKeys:
                for property in properties:
                    if primaryKey['name']==property['name']:
                        primaryKey['type'] = property['type']
                        self.preprocessType(primaryKey)
                        break
            
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
        
    def preprocessModel(self,model,hashes):
        """Preprocess entity"""
        # print("preprocess model " + str(model))
        print("processing " + model['entityName'])
        
        if 'primaryKeys' in model:
            self.preprocessPrimaryKeys(model['primaryKeys'],model,hashes)
        
        if not '_entity_imports_' in model:
            model['_entity_imports_'] = []
        model['_entity_imports_'].append({ "name" : model['entityName'] })# self.finalEntityFileName(model['entityName'],model) + '.h' })
        
        for property in model['properties']:
            self.preprocessProperty(property,model,hashes)

        self.preprocessDateFormats(model)
        
        self.preprocessRelationships(model,hashes)
            
        return model
        
    def preprocessRelationships(self,model,hashes):
        """docstring for preprocessRelationships"""
        if 'relationships' in model:
            relationships = model['relationships']
            self.preprocessList(relationships)
            for relationship in relationships:
                relationship['entityName'] = self.finalEntityFileName(relationship['entityName'],model)
                if (relationship['type']=='toMany'):
                    relationship['_toMany_'] = True
                else:
                    relationship['_toMany_'] = False

                self.preprocessModel(relationship,hashes)
        
        
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
            
        entity = hash
        if hash!=None and 'content' in hash:
            contents = hash['content']
            self.preprocessList(contents)
            for content in contents:
                if content!=None and 'model' in content:
                    entity = content['model']
        
        self.preprocessModel(entity,hashes)
            
    def process(self,hashes,templates,product,platform,platformDir):
        assert hashes
        assert templates
        assert product
        assert platform
        assert platformDir
            
        self.globalPlatform = self.globalProcessor(platform)
        
        hashes = self.sortHashes(hashes)
            
        for hashFile in hashes:
            hash = self.readHash(hashFile)
            
            entities = self.findEntities(hash)

            for templateFile in templates:
                if re.search('entity', templateFile, re.IGNORECASE):
                    for entity in entities:
                        entityCopy = copy.deepcopy(entity)
                        self.continueProcess(entityCopy,entity['entityName'],hashes,templateFile,product,platform,platformDir)
                else:
                    hashCopy = copy.deepcopy(hash)
                    self.continueProcess(hashCopy,hashFile,hashes,templateFile,product,platform,platformDir)
                    
                        
    def continueProcess(self,hash,hashFile,hashes,templateFile,product,platform,platformDir):
        
            # Global Platform preprocess
            if self.globalPlatform!=None:
                if self.config.verbose:
                    print('Global Preprocessing')
                
                self.globalPlatform.preprocess(hash,hashes)

            if self.config.verbose:
                print("Hash after global preprocess: " + str(hash))


            self.preprocess(hash,hashes)
            
            if self.config.verbose:
                print("Hash after product preprocess: " + str(hash))

            if self.config.verbose:
                with open("/tmp/final_hash" + os.path.basename(hashFile) + "_" + product + "_" + platform, "w") as f:
                    f.write(str(hash))
    
            renderer = self.renderer(platformDir)
        
            self.renderTemplate(renderer,templateFile,hash,hashes,product,platform,platformDir)
                    
    # def renderTemplate(self,renderer,templateFile,hash,hashes,product,platform,platformDir):
#         """docstring for renderTemplate"""
#         assert renderer
#         assert templateFile
#         assert hash
#         assert hashes
#         assert product
#         assert platform
#         assert platformDir
#         
#         
#         entities = self.findEntities(hash)
# 
#         if re.search('entity', templateFile, re.IGNORECASE):
#             print("entity in template name")
#             
#             for entity in entities:
#                 entity['_globals_'] = hash['_globals_']
#                 
#                 newKey = self.preprocessModel(entity,hashes)
#                 entity.update(newKey)
#                 
#                 fileName = self.finalFileName(os.path.basename(templateFile),entity['entityName'],entity)
#                 print("final file name: " + fileName)
#                 # hash['_current_model_'] = entity
#                 self.performRenderTemplate(renderer,templateFile,fileName,entity,hashes,product,platform,platformDir)
#         else:
#             fileName = self.finalFileName(os.path.basename(templateFile),None,hash)
#             self.performRenderTemplate(renderer,templateFile,fileName,hash,hashes,product,platform,platformDir)
                
    # def performRenderTemplate(self,renderer,templateFile,fileName,hash,hashes,product,platform,platformDir):
 #        """docstring for renderTemplate"""
 #        assert renderer
 #        assert templateFile
 #        assert hash
 #        assert hashes
 #        assert product
 #        assert platform
 #        assert platformDir
 # 
 #        template = self.readTemplate(templateFile)
 # 
 #        if hash!=None and '_globals_' in hash:
 #            # Remove .template
 #            realFileName, extension = os.path.splitext(fileName)
 #        
 #            # Split final file name into components
 #            baseName, extension = os.path.splitext(realFileName)
 #            
 #            hash['_globals_']['fileName'] = realFileName
 #            hash['_globals_']['fileBaseName'] = baseName
 #            hash['_globals_']['fileExtension'] = extension  
 #                    
 #        if self.config.verbose:
 #            print('Hash: ' + str(hash))            
 #        
 #        rendered = renderer.render_path(templateFile,hash)
 #        
 #        outputPath = self.outputDir(product,platform,fileName)
 #        
 #        Utils.printOutput("Rendering to file: " + outputPath)
 #        
 #        with open(outputPath, "w") as f:
 #            f.write(rendered)
 #            
            
                    
                    
    def finalEntityFileName(self,fileName,hash):
        """docstring for finalFileName"""
        
        # print("Hash " + str(hash))
        
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
               
        if self.config.verbose:
            print("PREFIX " + prefix)
        # print("Hash " + str(hash))

        serviceName = ""
        if hash!=None and 'serviceName' in hash:
            serviceName = self.stringUtils.capitalize(hash['serviceName'])

        print("filename " + fileName)
                
        if 'entityName' in hash:
            entityName = hash['entityName']
            print("entityname " + entityName)
            fileName = self.entityPattern.sub(entityName, fileName)

        print("filename " + fileName)

        fileName = self.servicePattern.sub(serviceName, fileName)
        
        fileName = prefix + fileName

        return fileName