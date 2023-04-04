import os
from locust import FastHttpUser,HttpUser, task, between
import json, random, math
import requests

# Host is local
host = 'https://fx5e3htbyl.execute-api.us-east-1.amazonaws.com'

headers = {
    'x-api-key' : 'JVKYsIVNnc9ka9g2Z97Ab90GrylnuaDv4xrDK0rn',
    'Content-Type': 'application/json'
}


data = {
    "DIA-I": 3,
    "MES-I": 2,
    "HORA-I": 9,
    "OPERA": "Grupo LATAM",
    "MES": 2,
    "TIPOVUELO": "N",
    "SIGLADES": "LaSerena",
    "DIANOM": "Viernes"
}

class WebsiteUser(HttpUser):

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

    def on_start(self):
        pass
    
    @task(3)
    def get_sessions(self):
        self.client.post(host + '/prd/get-prediction', headers=headers, json=json.dumps(data))