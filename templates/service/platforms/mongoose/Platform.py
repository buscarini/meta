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
        properties[len(properties)-1]['_last_'] = True
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
            content = hash['content']
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
                    self.preprocessList(relationships)


                
    def finalFileName(self,fileName,hash):
        """docstring for finalFileName"""
        entityName = None
        if hash!=None and 'content' in hash:
            content = hash['content']
            if 'model' in content:
                model = content['model']
                if 'entityName' in model:
                    entityName = model['entityName']
        if (entityName):
            fileName = fileName.replace("entity",entityName)
            
        return fileName
            