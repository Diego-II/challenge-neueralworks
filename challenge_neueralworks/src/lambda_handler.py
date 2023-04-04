import json
import logging
import pandas as pd
from glob import glob
# from .models.delay.inference import get_pipeline
from .models.delay.delay import DelayModel

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

def lambda_handler(
    event,
    _
):
    logger.info('Received event: %s', event)
    
    # List models in models directory
    models = [
        model.split('/')[-1] for model in glob('/models/*')
    ]
    logger.info('Models: %s', str(models))
    
    model_name = event['pathParameters'].get('model')
    if model_name not in models:
        return {
            'statusCode': 404,
            'body': json.dumps('Model {model} not found.')
        }
    
    if model_name == 'delay':
        model = DelayModel()
        
        
        if isinstance(event["body"], str):
            data = json.loads(event["body"])
        else:
            data = event["body"]
            
        flag, data = model.prepare_data(
            data
        )
        
        if not flag:
            return {
                'statusCode': 400,
                'body': json.dumps(f'Bad request: missing or additional keys {str(data)}.')
            }
        
        response = model.get_prediction(data)
        
        return {
            'statusCode': 200,
            'body': json.dumps(response)
        }
    return {
        'statusCode': 404,
        'body': json.dumps('Not found')
    }