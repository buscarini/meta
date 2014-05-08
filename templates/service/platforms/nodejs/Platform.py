class Platform(object):
    """docstring for Platform"""
    def __init__(self,stringUtils):
        super(Platform, self).__init__()
        self.stringUtils = stringUtils
        
    def preprocess(self,hash,hashes):
        
        if hash!=None and 'keys' in hash:
            keys = hash['keys']
            
            for key in keys:
                if 'primaryKeys' in key:
                    primary = key['primaryKeys']
                    lastKey = primary[len(primary)-1]
                
                    lastKey['_last_key_'] = True

                
    def finalFileName(self,fileName,hash):
        """docstring for finalFileName"""
        return fileName