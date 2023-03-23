import json
from database.databasetools import DataBase
from datetime import datetime

def obtiene_beneficiario(event,context):
    try:
        print("[Log]--[Funcion]--[obtiene_beneficiario]--["+str(datetime.now())+"]")
        #arg = json.loads(event["body"]) 
        bd = DataBase()
        response = bd.call_function("get_beneficiarios_persona",event)
        return json.dumps({"response": response })

    except Exception as e:
            return json.dumps({"Error" : "obtiene_beneficiario", "Exception": "Erro {}".format(e), "statusCode": 404, "event": event })


def alta_beneficiario(event,context):
    try:
        print("[Log]--[Funcion]--[alta_beneficiario]--["+str(datetime.now())+"]")
        #arg = json.loads(event["body"]) 
        bd = DataBase()
        response = bd.call_function("alta_beneficiarios_persona",event)
        return json.dumps({"response": response })

    except Exception as e:
            return json.dumps({"Error" : "alta_beneficiario", "Exception": "Erro {}".format(e), "statusCode": 404, "event": event })


def elimina_beneficiario(event,context):
    try:
        print("[Log]--[Funcion]--[elimina_beneficiario]--["+str(datetime.now())+"]")
        #arg = json.loads(event["body"]) 
        bd = DataBase()
        response = bd.call_function("baja_beneficiario",event)
        return json.dumps({"response": response })

    except Exception as e:
            return json.dumps({"Error" : "elimina_beneficiario", "Exception": "Erro {}".format(e), "statusCode": 404, "event": event })


def actualiza_beneficiario(event,context):
    try:
        print("[Log]--[Funcion]--[actualiza_beneficiario]--["+str(datetime.now())+"]")
        #arg = json.loads(event["body"]) 
        bd = DataBase()
        response = bd.call_function("actualiza_beneficiarios_persona",event)
        return json.dumps({"response": response })

    except Exception as e:
            return json.dumps({"Error" : "actualiza_beneficiario", "Exception": "Erro {}".format(e), "statusCode": 404, "event": event })