import sys
import re
from meta.MetaProcessor import MetaProcessor
from meta.utils import Utils

class Platform(MetaProcessor):
    """docstring for Platform"""
        
    def preprocessFilters(self,filters,hash):
        self.preprocessList(filters)
        """docstring for preprocessFilters"""
        for filter in filters:
            relation = filter['relation']
            if relation=='equal':
                relation = 'eq'
            elif relation=='greater':
                relation = 'gt'
            elif relation=='greater_equal':
                relation = 'gte'
            elif relation=='lesser':
                relation = 'lt'
            elif relation=='lesser_equal':
                relation = 'lte'
            elif relation=='not_equal':
                relation = 'ne'
            else:
                print("Unknown relation: " + relation)
                sys.exit()
            filter['relation'] = relation

    def preprocessSort(self,sorts,hash):
        """docstring for preprocessSort"""
        self.preprocessList(sorts)
        for sort in sorts:
            if sort['ascending']==True:
                sort['ascending'] = '1'
            else:
                sort['ascending'] = '-1'


    def preprocessProperties(self,properties,hash):
        """docstring for preprocessProperties"""
        self.preprocessList(properties)
        for property in properties:
            if 'type' in property:
                property['type_' + property['type']] = True
            if 'format' in property:
                format = property['format']
                format = format.replace("d","D")
                format = format.replace('y','Y')
                property['format'] = format
        
    def preprocessPrimaryKeys(self,keys,properties):
        """docstring for preprocessPrimaryKeys"""
        self.globalPlatform.preprocessPrimaryKeys(keys,properties)

    def preprocessRelationships(self,relationships):
        """docstring for preprocessRelationships"""
        self.preprocessList(relationships)
        for relationship in relationships:
            print("process relationship")
            if 'type' in relationship:
                type = relationship['type']
                print("type " + type)
                relationship['_toMany_'] = False
                if type=='toMany':
                    print("is to many")
                    relationship['_toMany_'] = True
            else:
                print("no type")
            
            if 'relationships' in relationship:    
                self.preprocessRelationships(relationship['relationships'])

            self.preprocessPrimaryKeys(relationship['primaryKeys'],relationship['properties'])
            
        
        
    def preprocessResultValue(self,resultValue,hash,hashes):
        """docstring for preprocessResultValue"""
        if 'type' in resultValue:
            type = resultValue['type']
            if type=='string':
                resultValue['okValue'] = '"' + resultValue['okValue'] + '"'
                resultValue['errorValue'] = '"' + resultValue['errorValue'] + '"'
            elif type=='integer':
                return
            else:
                print("Unknown result value type: " + type)
                sys.exit()
        
    def preprocess(self,hash,hashes):
        
        if 'resultValue' in hash:
            resultValue = hash['resultValue']
            self.preprocessResultValue(resultValue,hash,hashes)
        
        entity = hash
        if hash!=None and 'content' in hash:
            contents = hash['content']
            for content in contents:
                if content!=None and 'model' in content:
                    entity = content['model']
                    
        self.preprocessEntity(entity,hashes)


    def preprocessEntity(self,hash,hashes):
        """docstring for preprocessEntity"""
        if 'primaryKeys' in hash:
            self.preprocessPrimaryKeys(hash['primaryKeys'],hash['properties'])
        if 'filters' in hash:
            filters = hash['filters']
            self.preprocessFilters(filters,hash)
            if (len(filters)>0):
                hash['_has_filters_'] = True
        if 'sortBy' in hash:
            self.preprocessSort(hash['sortBy'],hash)
        if 'properties' in hash:
            self.preprocessProperties(hash['properties'],hash)
        if 'relationships' in hash:
            relationships = hash['relationships']
            self.preprocessRelationships(relationships)
    
    def finalFileName(self,fileName,hash):
        """docstring for finalFileName"""
        serviceName = None
        if hash!=None and 'serviceName' in hash:
            serviceName = hash['serviceName']
        if (serviceName):
            fileName = fileName.replace("service",serviceName)
        
        if 'entityName' in hash:
            entityName = hash['entityName']
            fileName = fileName.replace("entity",entityName)
            
        return fileName
            
    def findEntities(self,hash):
        """docstring for findEntities"""
        return self.findDictsWithKey(hash,"entityName")
            
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
                        self.continueProcess(entity,entity['entityName'],hashes,templateFile,product,platform,platformDir)
                else:
                    self.continueProcess(hash,hashFile,hashes,templateFile,product,platform,platformDir)
                    
                        
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
               