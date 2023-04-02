from sklearn.base import BaseEstimator, TransformerMixin
import numpy as np

class CyclicalEncoder(BaseEstimator, TransformerMixin):
    def __init__(self, column_names):
        self.column_names = column_names
        
    def fit(self, X, y=None):
        return self
        
    def transform(self, X, y=None):
        for col in self.column_names:
            radians = 2*np.pi*X[col]/X[col].max()
            X[col+"_sin"] = np.sin(radians)
            X[col+"_cos"] = np.cos(radians)
            X.drop(columns=[col], inplace=True)
        return X