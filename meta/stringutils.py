import re

class MetaStringUtils(object):
    """docstring for MetaStringUtils"""
    def __init__(self):
        super(MetaStringUtils, self).__init__()

    def underscore(self,word):
        """switch format to underscore a_simple_string"""
        return re.sub('(?!^)([A-Z]+)', r'_\1',word).lower()
        
    def capitalize(self,word):
        """docstring for capitalize"""
        regex = re.compile("[A-Za-z]") # find a alpha
        result = regex.search(word)
        s = word
        if result!=None:
            s = result.group() # find the first alpha
        return word.replace(s, s.upper(), 1) # replace only 1 instance
        
        # return word.capitalize()

    def camelcase(self,word):
        
        return ' '.join(word[0].upper() + word[1:] for word in word.split())
        
        return word.title()
        
        word = word.title()
        return ''.join(x.capitalize() or '_' for x in word.split('_'))
        
        # print("applying camelcase")
        # def ccase(): 
        #     yield str.lower
        #     while True:
        #         yield str.capitalize
        # 
        # c = ccase()
        # return "".join(c.next()(x) if x else '_' for x in word.split("_"))
        
    def uppercase(self,word):
        """uppercase filter"""
        return word.upper()
    
    def lowercase(self,word):
        """lowercase filter"""
        return word.lower()