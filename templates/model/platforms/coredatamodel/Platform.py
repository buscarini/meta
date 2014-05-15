import sys
import os
import os.path
import json
from meta.MetaProcessor import MetaProcessor

class Platform(MetaProcessor):
    """docstring for Platform"""
        
    def preprocessProperty(self,property,hash,hashes):
        """docstring for preprocessProperty"""
        property['_camelcase_'] = self.stringUtils.camelcase(str(property['name']))
        property['_capitalized_'] = self.stringUtils.capitalize(str(property['name']))
        
        if 'default' in property:
            property['default'] = self.globalPlatform.platformValueForValue(property['default'])
        
        if 'required' in property:
            property['optional'] = 'NO'
        else:
            property['optional'] = 'YES'
        
        type = property['type']
        property['type_' + type] = True
        
        platformType = self.globalPlatform.platformTypeForType(type)
        if platformType!=None:
            property['type'] = platformType
        else:
            print("Error: unknown property type: " + type)
            sys.exit()
            
            
    def preprocessRelationships(self,relationships,hash,hashes):
        """docstring for preprocessRelationships"""
        for relationship in relationships:
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
        
            
    def outputDir(self,product,platform,template):
        """returns the final output directory"""
        
        outputDir = super(Platform, self).outputDir(product,platform,template)
        
        path, template = os.path.split(outputDir)

        cdatamodeldPath = os.path.join(path,os.path.basename(self.config.projectPath) + ".xcdatamodeld")
        cdatamodelPath = os.path.join(cdatamodeldPath,os.path.basename(self.config.projectPath) + ".xcdatamodel")
        
        os.makedirs(cdatamodelPath)
        
        return os.path.join(cdatamodelPath,template)
            
    def preprocess(self,hash,hashes):
        if hash!=None and 'properties' in hash:
            i=0
            properties = hash['properties']
            for property in properties:
                self.preprocessProperty(property,hash,hashes)
                i=i+1
                
            self.preprocessList(properties)
        
        if hash!=None and 'primaryKeys' in hash:
            primaryKeys = hash['primaryKeys']
            self.preprocessList(primaryKeys)
        
        if hash!=None and 'relationships' in hash:
            relationships = hash['relationships']
            self.preprocessList(relationships)
            self.preprocessRelationships(relationships,hash,hashes)
        
            
    def process(self,hashes,templates,product,platform,platformDir):
        assert hashes
        assert templates
        assert product
        assert platform
        assert platformDir


        finalHash = {}
        finalHash['_entities_'] = []
            
        self.globalPlatform = self.globalProcessor(platform)
            
        for hashFile in hashes:
            hash = self.readHash(hashFile)
            
            # Global Platform preprocess
            if self.globalPlatform!=None:
                if self.config.verbose:
                    print('Global Preprocessing')
                self.globalPlatform.preprocess(hash,hashes)
                        
            if self.config.verbose:
                print("Hash after global preprocess: " + str(hash))

            self.preprocess(hash,hashes)
            
            finalHash['_entities_'].append(hash)
            
        if self.config.verbose:
            print("Hash after product preprocess: " + str(finalHash))

        renderer = self.renderer(platformDir)
    
        for templateFile in templates:
           self.renderTemplate(renderer,templateFile,finalHash,hashes,product,platform,platformDir)
        