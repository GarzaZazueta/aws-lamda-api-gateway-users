import json
import sqlalchemy 
from datetime import datetime

db_user = "postgres"
db_pass = "Admin123456"
db_host = "usuarios-db.czrjrjfko82t.us-east-1.rds.amazonaws.com"
db_port = "5432"
db_database = "usuarios-db"

db = sqlalchemy.create_engine("postgresql+psycopg2://postgres:Admin123456@usuarios-db.czrjrjfko82t.us-east-1.rds.amazonaws.com:5432/usuarios-db")

class DataBase():
    def raw_connection(self):
        return db.raw_connection()
        
    def call_function(self,sqlfunction,args):
        try:
            connection = db.raw_connection()
            cursor = connection.cursor()
            if (args=='null'):
                sqlquery = "select "+sqlfunction+"();"
            else:
                
                data = json.dumps(args)
                sqlquery = "select "+sqlfunction+"('"+data+"'::jsonb);"
            
            print("[Log]--[Funcion]--[call_function]--["+str(datetime.now())+"]--["+sqlquery+"]")
            cursor.execute(sqlquery)
            records = cursor.fetchall()
            cursor.close()
            connection.commit()
            connection.close()

            return records
        except Exception as e:
            connection.close()
            return json.dumps({"Error" : "call_function", "Exception": "Erro {}".format(e), "statusCode": 404 })