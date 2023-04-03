from sklearn.pipeline import Pipeline
from .preprocesing import CyclicalEncoder
from sklearn.compose import ColumnTransformer
from sklearn.preprocessing import OneHotEncoder
from sklearn.linear_model import LogisticRegression
import dill as pickle


def get_pipeline():
    
    pipeline = pickle.load(open('/models/delay/model_v0.pkl', 'rb'))
    
    return pipeline