import os
import json
from meta.MetaProcessor import MetaProcessor

class GlobalPlatform(MetaProcessor):
    """docstring for Preprocessor"""
    def __init__(self,config,stringUtils):
        super(GlobalPlatform, self).__init__(config,stringUtils)

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
        
    def platformTypeForType(self,type):
        if type=='string':
            return 'String'
        elif type=='integer':
            return 'Integer 32'
        elif type=='float':
            return 'Float'
        elif type=='double':
            return 'Double'
        elif type=='bool':
            return 'Boolean'
        elif type=='date':
            return 'Date'
        else:
            return None
            
    def platformValueForValue(self,value):
        """docstring for platformValueForValue"""
        if value=='true':
            return 'YES'
        elif value=='false':
            return 'NO'
        else:
            return value
            