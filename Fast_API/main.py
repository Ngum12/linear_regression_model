from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field
import joblib
import numpy as np

# Load the model package
model_package = joblib.load('african_conflict_peace_models.joblib')

# Extract components
conflict_model = model_package['conflict_model']
peace_model = model_package['peace_model']
scaler = model_package['scaler']
feature_columns = model_package['feature_columns']

# Create FastAPI instance
app = FastAPI()

# Add CORS Middleware to allow cross-origin requests
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allows all origins, replace "*" with specific domains if needed
    allow_credentials=True,
    allow_methods=["*"],  # Allow all HTTP methods (GET, POST, etc.)
    allow_headers=["*"],  # Allow all headers
)

# Define input schema using Pydantic
class PredictionInput(BaseModel):
    Poverty_Rate: float = Field(..., ge=0, le=100, description="Poverty rate (%)")
    Unemployment_Rate: float = Field(..., ge=0, le=100, description="Unemployment rate (%)")
    Education_Index: float = Field(..., ge=0, le=1, description="Education Index (0-1)")
    Political_Stability_Index: float = Field(..., description="Political Stability Index")
    Corruption_Perception_Index: float = Field(..., ge=0, le=100, description="Corruption Perception Index")
    Ethnic_Diversity_Index: float = Field(..., ge=0, le=1, description="Ethnic Diversity Index (0-1)")
    Religious_Diversity_Index: float = Field(..., ge=0, le=1, description="Religious Diversity Index (0-1)")
    Population_Density: float = Field(..., ge=0, description="Population density (people per sq. km)")

# Define prediction endpoint
@app.post("/predict")
async def predict(input_data: PredictionInput):
    try:
        # Convert input data to dictionary
        input_dict = input_data.dict()
        
        # Prepare input for model
        input_array = np.array([input_dict[feature] for feature in feature_columns]).reshape(1, -1)
        input_scaled = scaler.transform(input_array)
        
        # Make predictions
        conflict_prediction = conflict_model.predict(input_scaled)[0]
        peace_prediction = peace_model.predict(input_scaled)[0]
        
        return {
            "conflict_risk_prediction": conflict_prediction,
            "peacebuilding_success_rate": peace_prediction
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

# Run the app
if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="10.110.13.13", port=8000, reload=True)
