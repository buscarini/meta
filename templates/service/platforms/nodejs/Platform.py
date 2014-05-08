from meta.MetaPlatform import MetaPlatform

class Platform(MetaPlatform):
    """docstring for Platform"""
        
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