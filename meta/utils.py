import os
import imp
import glob
from termcolor import colored

class Utils(object):
    
    hasErrors = False
    
    """docstring for Utils"""
    @staticmethod
    def importClass(path):
        assert path

        if not os.path.exists(path + '.py'):
            return None

        name = os.path.basename(path)

        module = imp.load_source(name,path + '.py')

        return getattr(module,name)
        
    @staticmethod
    def printBold(message):
        """docstring for printEnphasis"""
        print(colored(message,'green'))

    @staticmethod
    def printOutput(message):
        """docstring for printEnphasis"""
        print(colored(message,'cyan'))

    @staticmethod
    def printSection(message):
        """docstring for printEnphasis"""
        print('')
        print(colored(message,'white',attrs=['bold']))
        print('-'*len(message))
        print('')

        
    @staticmethod
    def printSubSection(message):
        """docstring for printEnphasis"""
        print(colored("> ",'green') + message)
        print('')
        
    @staticmethod
    def printWarning(message):
        print(colored(message,'magenta'))
        
    @classmethod
    def printError(cls,error):
         print(colored(error,'red'))
         cls.hasErrors = True
         
    @staticmethod
    def listDir(path):
        return glob.glob(os.path.join(path, '*'))
