# Linear Regression Model with FastAPI

This project demonstrates a simple linear regression model served using FastAPI.

## Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/yourusername/linear_regression_model.git
    cd linear_regression_model/Fast_API
    ```

2. Create and activate a virtual environment:
    ```bash
    python -m venv venv
    source venv/bin/activate  # On Windows use `venv\Scripts\activate`
    ```

3. Install the dependencies:
    ```bash
    pip install -r requirements.txt
    ```

## Usage

1. Start the FastAPI server:
    ```bash
    uvicorn main:app --reload
    ```

2. Open your browser and navigate to `http://127.0.0.1:8000/docs` to access the interactive API documentation.

## Endpoints

- `POST /predict`: Predict the output using the linear regression model.

## License

This project is licensed under the MIT License.