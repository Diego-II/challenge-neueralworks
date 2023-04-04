import os
from locust import HttpUser, TaskSet, task
from dotenv import load_dotenv

load_dotenv()
class MyTaskSet(TaskSet):
    @task
    def test_inference_delay(self):
        headers = {'x-api-key': os.environ.get('API_KEY')}
        data = {
            "DIA-I": 3,
            "MES-I": 2,
            "HORA-I": 9,
            "OPERA": "Grupo LATAM",
            "TIPOVUELO": "N",
            "SIGLADES": "LaSerena",
            "DIANOM": "Viernes"
        }
        self.client.post('/inference/delay', headers=headers, json=data)

class MyUser(HttpUser):
    tasks = [MyTaskSet]
    min_wait = 1000
    max_wait = 5000
