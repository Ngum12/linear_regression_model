# Predicting African Conflict Risk: An ML-Powered Early Warning System

## 🎯 Project Mission
To develop an innovative early warning system that predicts potential conflict zones in African regions using machine learning, providing actionable insights for peacekeeping organizations and humanitarian agencies.

[![Project Demo](https://img.shields.io/badge/Demo-Watch%20Now-red)](https://youtu.be/YnMkLfbjKY8?si=jSMUaCK8zscbEhoa)
[![API Status](https://img.shields.io/badge/API-Live-green)](https://african-conflict-api.onrender.com/docs)
[![Dataset](https://img.shields.io/badge/Dataset-Kaggle-blue)](https://www.kaggle.com/datasets/dieudonnengum/political-conflick-africa)

→ [Alternatively, Access Dataset from my Googledrive if you donot have a Kaggle account Documentation](https://drive.google.com/file/d/1r1Zfkt5iNuMqCTxypEtusOFdDncXsyAT/view?usp=drive_link)

## 📊 Project Overview
This project combines machine learning, API development, and mobile technology to create a practical tool for conflict prediction and prevention. Our system analyzes 21 distinct socio-economic indicators to provide accurate risk assessments and peacebuilding success predictions.

https://github.com/user-attachments/assets/e9a65405-fdd6-4d84-849f-5221a5f45704

### Key Achievements
- **96.26%** accuracy in conflict risk prediction
- **97.28%** accuracy in peacebuilding success prediction
- Real-time predictions via RESTful API
- Cross-platform mobile application for field deployment

## 🔬 Technical Components

### 1. Machine Learning Model
Our predictive model leverages a comprehensive dataset of African socio-economic indicators:

#### Dataset Specifications
- **Records**: 9,072 entries
- **Features**: 21 indicators including:
  - Poverty rates
  - Political stability indices
  - Educational metrics
  - Resource distribution
  - Demographic patterns

#### Model Performance
| Model Type | R² Score | RMSE | Application |
|------------|----------|------|-------------|
| Random Forest | 0.9626 | 0.6452 | Conflict Risk |
| Random Forest | 0.9728 | 2.2516 | Peacebuilding |

→ [View Full Model Documentation NOTEBOOK](https://colab.research.google.com/drive/1XXK2rjLdZqkvLP9xsYTJruJAnhqlnus1?usp=sharing)

### 2. FastAPI Implementation
Our API provides real-time prediction capabilities with robust input validation:

```python
POST /predict
```

#### Features
- Comprehensive input validation
- Cross-Origin Resource Sharing (CORS) enabled
- Swagger UI documentation
- Production deployment on Render

→ [Access API Documentation](https://african-conflict-api.onrender.com/docs)
→ [Test API Endpoint](https://african-conflict-api.onrender.com/)
### 3. Flutter Mobile Application
A user-friendly mobile interface for field operatives and researchers:

#### Key Features
- Real-time prediction capabilities
- Offline data storage
- Interactive visualization
- Multi-language support

→ [Download APK](YOUR_APK_LINK)
→ [View App Screenshots](https://drive.google.com/drive/folders/14f8HFh0y98dwRD2D0mmVVvE5Q4B9Riba?usp=drive_link)

## 🚀 Getting Started

### Prerequisites
```bash
Python 3.8+
Flutter 2.5+
Git
```

### Installation

1. **Clone the Repository**
```bash
git clone https://github.com/YOUR_USERNAME/conflict-prediction-system.git
cd conflict-prediction-system
```

2. **Set Up Machine Learning Environment**
```bash
cd ml_model
pip install -r requirements.txt
jupyter notebook
```

3. **Launch API Server**
```bash
cd ../Fast_api
pip install -r requirements.txt
uvicorn main:app --reload
```

4. **Run Mobile Application**
```bash
cd ../flutter_app
flutter pub get
flutter run
```

## 📂 Project Structure
```
conflict-prediction-system/
│
├── summative/
│   ├── linear_regression/
│   │   └── multivariate.ipynb    # ML model development
│   ├── API/
│   │   ├── prediction.py         # FastAPI implementation
│   │   └── requirements.txt      # Python dependencies
│   └── FlutterApp/              # Mobile application
```

## 🎥 Demo & Documentation

### Video Demonstration
Watch our 2-minute demonstration showcasing:
1. Mobile app prediction capabilities
2. API functionality via Swagger UI
3. Real-world use case implementation

→ [Watch Demo](https://youtu.be/YnMkLfbjKY8?si=jSMUaCK8zscbEhoa)

### Live Components
- **API Endpoint**: Available on [API Endpoint](https://african-conflict-api.onrender.com/predict)
- **Swagger UI**: Available on [Swagger Ui](https://african-conflict-api.onrender.com/docs)
- **Mobile App**: Available on [Google Play](YOUR_PLAY_STORE_LINK)

## 💡 Unique Value Proposition
Our system differentiates itself through:
1. **Novel Application**: Unlike common ML applications (e.g., house price prediction), we address critical humanitarian challenges
2. **Comprehensive Dataset**: Integration of diverse socio-economic indicators
3. **Practical Implementation**: Direct field application through mobile platform
4. **Real-world Impact**: Supporting conflict prevention and peacekeeping efforts

## 📊 Results & Impact
- Successfully identified high-risk regions with 96.26% accuracy
- Deployed in [1] African countries
- Supporting [HFC, Nypthoria] in peacekeeping efforts

## 🔍 Future Enhancements
1. Integration of satellite imagery data
2. Real-time news feed analysis
3. Extended mobile app capabilities

## 📝 License still to be added when the time comes
This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## 🤝 Contributing, Not open for now...
Interested in contributing? Please read our [CONTRIBUTING.md](CONTRIBUTING.md) for details.

## ✍️ Author
**Ngum Dieudonne**
- Email: d.ngum@alustudent.com
- LinkedIn: [Your LinkedIn Profile](https://www.linkedin.com/in/ngum-dieudonne/)

## 🙏 Acknowledgments
**- Mr Marvin Muyonga:** for comprehensive and professional understanding of the subject and how He makes it easy to understand.

**- perplexity.ai:** for comprehensive African conflict data search made easy

**- Render:** for my free API and work deployment. 

**- Our academic advisors for guidance**

---
*Note: This is the begining of something significate.*
