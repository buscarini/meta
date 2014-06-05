import sys
from meta.MetaProcessor import MetaProcessor

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
            if 'type' in relationship:
                type = relationship['type']
                relationship['_toMany_'] = False
                if type=='toMany':
                    relationship['_toMany_'] = True
                    
            
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
        
        if hash!=None and 'content' in hash:
            contents = hash['content']
            for content in contents:
                if content!=None and 'model' in content:
                    model = content['model']
                    if 'primaryKeys' in model:
                        self.preprocessPrimaryKeys(model['primaryKeys'],model['properties'])
                    if 'filters' in model:
                        filters = model['filters']
                        self.preprocessFilters(filters,hash)
                        if (len(filters)>0):
                            model['_has_filters_'] = True
                    if 'sortBy' in model:
                        self.preprocessSort(model['sortBy'],hash)
                    if 'properties' in model:
                        self.preprocessProperties(model['properties'],hash)
                    if 'relationships' in model:
                        relationships = model['relationships']
                        self.preprocessRelationships(relationships)

                
    def finalFileName(self,fileName,hash):
        """docstring for finalFileName"""
        serviceName = None
        if hash!=None and 'serviceName' in hash:
            serviceName = hash['serviceName']
        if (serviceName):
            fileName = fileName.replace("entity",serviceName)
            
        return fileName
            