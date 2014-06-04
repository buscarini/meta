import os
import json
import sys
import meta
from meta.MetaProcessor import MetaProcessor
        
class GlobalPlatform(MetaProcessor):
    """docstring for Preprocessor"""
    def __init__(self,config,stringUtils):
        super(GlobalPlatform, self).__init__(config, stringUtils)
    
        thisPath = os.path.realpath(__file__)
        
        self.globalsPath = os.path.join(os.path.dirname(thisPath),'globals.json')

    def preprocess(self,hash,hashes):
        """Make any preprocessing necessary for the platform"""
        return self.addHashGlobals(hash)

    def addHashGlobals(self,hashDic):
        """docstring for addHashGlobals"""

        with open (self.globalsPath, "r") as file:
            globalsString = file.read()
            globalsDic = json.loads(globalsString)

        hashDic['_globals_'] = globalsDic

        return hashDic
        
    def processProperty(self,property,hash,hashes):
        property['_camelcase_'] = self.stringUtils.camelcase(str(property['name']))
        property['_capitalized_'] = self.stringUtils.capitalize(str(property['name']))
        
        type = property['type']
        property['type_' + type] = True
     
        if type=='string':
            property['type'] = 'String'
            property['object'] = True
        elif type=='integer':
            property['type'] = 'Int'
            property['object'] = False
        elif type=='float':
            property['type'] = 'Float'
            property['object'] = False
        elif type=='double':
            property['type'] = 'Double'
            property['object'] = False
        elif type=='bool':
            property['type'] = 'Bool'
            property['object'] = False
        elif type=='date':
            property['type'] = 'NSDate'
            property['object'] = True
        elif type=='url':
            property['type'] = 'NSURL'
            property['object'] = True
        elif type=='image':
            property['type'] = 'BMFIXImage'
            property['object'] = True
        else:
            raise SyntaxError("Unknown property type: " + type)
    
            