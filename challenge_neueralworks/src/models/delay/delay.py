import logging
from ..model import Model
import pandas as pd
from sklearn.pipeline import Pipeline
from .preprocesing import CyclicalEncoder
from sklearn.compose import ColumnTransformer
from sklearn.preprocessing import OneHotEncoder
from sklearn.linear_model import LogisticRegression

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

class DelayModel(Model):
    def __init__(self) -> None:
        super().__init__("delay")
        self.required_fiels = [
            "DIA-I",
            "MES-I",
            "HORA-I",
            "OPERA",
            "TIPOVUELO",
            "SIGLADES",
            "DIANOM"
        ]

    def prepare_data(
        self,
        data: dict
    ):
        logger.info("Checking required fields")
        
        missing_keys = list(
            set(self.required_fiels) - set(data.keys())
        )
        additional_keys = list(
            set(data.keys()) - set(self.required_fiels)
        )
        
        if missing_keys:
            logger.error(
                "Missing required fields: %s",
                str(missing_keys)
            )
            return False, missing_keys
        
        if additional_keys:
            logger.error(
                "Additional fields: %s",
                str(additional_keys)
            )
            return False, additional_keys

        return True, \
            sorted(
                data.items(),
                key=lambda pair: self.required_fiels.index(pair[0])
            )
            
    def get_prediction(
        self,
        data: dict
    ):
        logger.info("Getting prediction")
        pipeline = self.get_pipeline()
        prediction = pipeline.predict_proba(
            pd.DataFrame([data])
        )
        return prediction.tolist()[0]