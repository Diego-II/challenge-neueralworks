import dill as pickle
import glob
import os
from pathlib import Path

class Model:
    def __init__(self, model_name) -> None:
        self.model_name = model_name
        self.model_base_path = Path("/models")
        self.model_path = self.__get_model_path__()
        
    def __get_model_path__(self):
        list_of_models = glob.glob(f"{str(self.model_base_path)}/{self.model_name}/*.pkl") # * means all if need specific format then *.csv
        return max(list_of_models, key=os.path.getctime)
    
    def get_model_name(self):
        return self.model_name
    
    def get_model_path(self):
        return self.model_path
    
    def get_pipeline(self):
        pipeline = pickle.load(open(self.model_path, 'rb'))
        return pipeline