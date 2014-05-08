import os
import imp
from termcolor import colored

class Utils(object):
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
    def printSection(message):
        """docstring for printEnphasis"""
        print(colored(message,'blue'))
        
    @staticmethod
    def printWarning(message):
        print(colored(message,'magenta'))
        
    @staticmethod
    def printError(error):
         print(colored(error,'red'))