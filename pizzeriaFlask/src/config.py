class DevelopmentConfig():
    DEBUG = True
    MYSQL_HOST = 'localhost'
    MYSQL_USER = 'angel'
    MYSQL_PASSWORD = '23002280'
    MYSQL_DB = 'examen'
    MYSQL_CURSORCLASS = 'Cursor'  
    MYSQL_AUTOCOMMIT = True 

config = {
    'development': DevelopmentConfig
}