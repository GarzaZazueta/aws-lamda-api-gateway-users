import json
from database.databasetools import DataBase
from datetime import datetime


def obtiene_persona(event,context):
    try:
        print("[Log]--[Funcion]--[obtiene_persona]--["+str(datetime.now())+"]")
       # arg = json.loads(event["body"]) 
        bd = DataBase()
        response = bd.call_function("get_usuarios_persona",event)
        return json.dumps({"response": response })

    except Exception as e:
            return json.dumps({"Error" : "obtiene_persona", "Exception": "Erro {}".format(e), "statusCode": 404, "event": event })

def alta_persona(event,context):
    try:
        print("[Log]--[Funcion]--[alta_persona]--["+str(datetime.now())+"]")
        #arg = json.loads(event["body"]) 
        bd = DataBase()
        response = bd.call_function("crear_usuarios_persona",event)
        return json.dumps({"response": response })

    except Exception as e:
            return json.dumps({"Error" : "alta_persona", "Exception": "Erro {}".format(e), "statusCode": 404, "event": event })

def baja_persona(event,conte):
    try:
        print("[Log]--[Funcion]--[baja_persona]--["+str(datetime.now())+"]")
        arg = json.loads(event["body"]) 
        bd = DataBase()
        response = bd.call_function("delete_persona",arg)
        return json.dumps({"response": response })

    except Exception as e:
            return json.dumps({"Error" : "baja_persona", "Exception": "Erro {}".format(e), "statusCode": 404, "event": event })

def actualiza_persona(event,context):
    try:
        print("[Log]--[Funcion]--[actualiza_persona]--["+str(datetime.now())+"]")
        #arg = json.loads(event["body"]) 
        bd = DataBase()
        response = bd.call_function("actualizar_usuarios_persona",event)
        return json.dumps({"response": response })

    except Exception as e:
            return json.dumps({"Error" : "actualiza_persona", "Exception": "Erro {}".format(e), "statusCode": 404, "event": event })