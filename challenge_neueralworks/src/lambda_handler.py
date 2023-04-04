import json
import logging
import dill as pickle
import pandas as pd
import numpy as np
from glob import glob
from .models.delay.inference import get_pipeline

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
    if event["resource"] == '/get-prediction':
        # load the dumped pipeline
        pipeline = get_pipeline()
        logger.info('Loaded model')
        
        logger.info('Model: %s', str(pipeline.__dict__))
    
        # extract input data from the event
        input_data = json.loads(event["body"])
        
        # convert input data to a numpy array
        # input_array = np.array(list(input_data.values())).reshape(1, -1)
        
        input_df = pd.DataFrame([input_data])
        # generate predictions using the predict_proba method
        prediction = pipeline.predict_proba(input_df)
        
        # return prediction as JSON response
        response = {
            'prediction': prediction.tolist()[0]
        }
        return {
            'statusCode': 200,
            'body': json.dumps(response)
        }
    
    return {
        'statusCode': 404,
        'body': json.dumps('Not found')
    }