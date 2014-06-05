import os
import json
from meta.MetaProcessor import MetaProcessor

class GlobalPlatform(MetaProcessor):
    """docstring for Preprocessor"""
    def __init__(self,config,stringUtils):
        super(GlobalPlatform, self).__init__(config,stringUtils)

        thisPath = os.path.realpath(__file__)
        
        self.globalsPath = os.path.join(os.path.dirname(thisPath),'globals.json')

    def preprocessPrimaryKeys(self,primaryKeys,properties):
        """docstring for preprocessPrimaryKeys"""
        assert len(primaryKeys)<2

        self.preprocessList(primaryKeys)
        keyName = primaryKeys[0]['name']
        # for property in properties:
 #            if property['name']==keyName:
 #                property['name'] = '_id'
 #                break
 #        
 #        primaryKeys[0]['name'] = '_id'

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
        
   