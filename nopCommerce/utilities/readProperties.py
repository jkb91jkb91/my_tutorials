import configparser

config=configparser.RawConfigParser()
config.read("./Configurations/config.ini")


class Configurations():

    @staticmethod
    def readURL():
        url = config.get('common info', 'baseURL')
        return str(url)
    
    @staticmethod
    def readUsername():
        return config.get('common info', 'username')
    
    @staticmethod
    def readPassword():
        return config.get('common info', 'password')