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
     
        if type=='string' or type=='url':
            property['type'] = 'NSString'
            property['object'] = True
            property['storage'] = 'copy'
        elif type=='integer':
            property['type'] = 'NSInteger'
            property['object'] = False
            property['storage'] = 'assign'
        elif type=='float':
            property['type'] = 'CGFloat'
            property['object'] = False
            property['storage'] = 'assign'
        elif type=='double':
            property['type'] = 'double'
            property['object'] = False
            property['storage'] = 'assign'            
        elif type=='bool':
            property['type'] = 'BOOL'
            property['object'] = False
            property['storage'] = 'assign'
        elif type=='date':
            property['type'] = 'NSDate'
            property['object'] = True
            property['storage'] = 'strong'
        elif type=='url':
            property['type'] = 'NSURL'
            property['object'] = True
            property['storage'] = 'strong'
        elif type=='image':
            property['type'] = 'NSData'
            property['object'] = True
            property['storage'] = 'strong'
        else:
            raise SyntaxError("Unknown property type: " + type)
    
            