import json
import logging
import joblib
import pickle
import numpy as np
from glob import glob
from sklearn.pipeline import Pipeline
from .src.pipeline.preprocesing import CyclicalEncoder
from sklearn.compose import ColumnTransformer
from sklearn.preprocessing import OneHotEncoder
from sklearn.linear_model import LogisticRegression

import sys

sys.path.append("/src/pipeline/preprocesing")

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

def lambda_handler(
    event,
    _
):
    logger.info('Received event: %s', event)
    
    # List models in models directory
    models = glob('/models/*')
    logger.info('Models: %s', str(models))
    # load the dumped pipeline
    pipeline = pickle.load(open('/models/delay/model_v0.pkl', 'rb'))
    logger.info('Loaded model')
    logger.info('Model: %s', str(pipeline.__dict__))
    
    # extract input data from the event
    input_data = event['data']
    
    # convert input data to a numpy array
    input_array = np.array(input_data).reshape(1, -1)
    
    # generate predictions using the predict_proba method
    prediction = pipeline.predict_proba(input_array)
    
    # return prediction as JSON response
    response = {
        'prediction': prediction.tolist()[0]
    }
    return {
        'statusCode': 200,
        'body': json.dumps(response)
    }
