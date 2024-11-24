# Contents of main.py
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field
import joblib
import numpy as np
import os

# Create FastAPI instance
app = FastAPI()

try:
    # Load the model package
    model_package = joblib.load('african_conflict_peace_models.joblib')

    # Extract components
    conflict_model = model_package['conflict_model']
    peace_model = model_package['peace_model']
    scaler = model_package['scaler']
    feature_columns = model_package['feature_columns']
except Exception as e:
    print(f"Error loading model: {str(e)}")
    # Initialize empty variables to allow app to start
    conflict_model = None
    peace_model = None
    scaler = None
    feature_columns = None

# Add CORS Middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class PredictionInput(BaseModel):
    Poverty_Rate: float = Field(..., ge=0, le=100)
    Unemployment_Rate: float = Field(..., ge=0, le=100)
    Education_Index: float = Field(..., ge=0, le=1)
    Political_Stability_Index: float
    Corruption_Perception_Index: float = Field(..., ge=0, le=100)
    Ethnic_Diversity_Index: float = Field(..., ge=0, le=1)
    Religious_Diversity_Index: float = Field(..., ge=0, le=1)
    Population_Density: float = Field(..., ge=0)

@app.get('/')
def index():
    return {'message': 'Hello, World'}

@app.get('/{name}')
def get_name(name: str):
    return {'Welcome To Ngums world Nypthoria': f'{name}'}

@app.post("/predict")
async def predict(input_data: PredictionInput):
    if not all([conflict_model, peace_model, scaler, feature_columns]):
        raise HTTPException(status_code=500, detail="Model not properly loaded")
    
    try:
        input_dict = input_data.dict()
        input_array = np.array([input_dict[feature] for feature in feature_columns]).reshape(1, -1)
        input_scaled = scaler.transform(input_array)
        
        conflict_prediction = conflict_model.predict(input_scaled)[0]
        peace_prediction = peace_model.predict(input_scaled)[0]
        
        return {
            "conflict_risk_prediction": conflict_prediction,
            "peacebuilding_success_rate": peace_prediction
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

if __name__ == "__main__":
    import uvicorn
    port = int(os.getenv("PORT", 10000))
    uvicorn.run("main:app", host="0.0.0.0", port=port, reload=True)