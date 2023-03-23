import json
from database.databasetools import DataBase
from datetime import datetime

def obtiene_usuario(event,context):
    try:
        print("[Log]--[Funcion]--[obtiene_usuario]--["+str(datetime.now())+"]") 
        bd = DataBase()
        args = 'null'
        response = bd.call_function("get_usuarios",args)
        return json.dumps({"response": response })

    except Exception as e:
        return json.dumps({"Error" : "obtiene_usuario", "Exception": "Erro {}".format(e), "statusCode": 404, "event": event })

def get_info_exportar(event,context):
    try:
        print("[Log]--[Funcion]--[get_info_exportar]--["+str(datetime.now())+"]")
        args = "null"
        bd = DataBase()
        response = bd.call_function("get_info_exportar",args)
        return json.dumps({"response": response })

    except Exception as e:
            return json.dumps({"Error" : "alta_usuarios", "Exception": "Erro {}".format(e), "statusCode": 404, "event": event })

def baja_usuarios(event,context):
    try:
        print("[Log]--[Funcion]--[baja_usuarios]--["+str(datetime.now())+"]")
        #args = json.loads(event["body"]) 
        bd = DataBase()
        response = bd.call_function("baja_usuario",event)
        return json.dumps({"response": response })

    except Exception as e:
            return json.dumps({"Error" : "baja_usuarios", "Exception": "Erro {}".format(e), "statusCode": 404, "event": event })

def actualiza_usuarios(event,context):
    try:
        print("[Log]--[Funcion]--[actualiza_usuarios]--["+str(datetime.now())+"]")
        args = json.loads(event["body"]) 
        bd = DataBase()
        response = bd.call_function("update_usuario",args)
        return json.dumps({"response": response })

    except Exception as e:
            return json.dumps({"Error" : "actualiza_usuarios", "Exception": "Erro {}".format(e), "statusCode": 404, "event": event })

def valida_credenciales(event,context):
    try:
        print("[Log]--[Funcion]--[valida_credenciales]--["+str(datetime.now())+"]") 
        bd = DataBase()
        #args = json.loads(event["body"]) 
        response = bd.call_function("get_valida_credenciales",event)
        return json.dumps({"response": response })

    except Exception as e:
            return json.dumps({"Error" : "valida_credenciales", "Exception": "Erro {}".format(e), "statusCode": 404, "event": event })