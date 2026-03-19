from flask import Flask,render_template,request
import mlflow
from preprocessing_utility import normalize_text
import dagshub
import pickle

mlflow.set_tracking_uri('https://dagshub.com/akashsingh79036/mlops-mini-project.mlflow')
dagshub.init(repo_owner='akashsingh79036', repo_name='mlops-mini-project', mlflow=True)

app = Flask(__name__)



#load model from model registry
model_name= "my_model"
model_version=1
    

model_uri = f"models:/{model_name}/{model_version}"
model=mlflow.pyfunc.load_model(model_uri)

vectorizer=pickle.load(open('models/vectorizer.pkl','rb'))

@app.route('/')
def home():
    return render_template('index.html',result=None)

@app.route('/predict',methods=['POST','GET'])
def predict():
    if request.method == 'POST':
        text = request.form['text']
        # preprocessing and prediction here
        result = model.predict(vectorizer.transform([normalize_text(text)]))
        return render_template('index.html', result=result[0])
    else:
        # For GET just redirect to home or show form
        return render_template('index.html', result=None)

if __name__=="__main__":
    app.run(debug=True)