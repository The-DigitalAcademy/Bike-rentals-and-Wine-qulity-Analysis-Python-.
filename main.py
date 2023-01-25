from flask import Flask, request, render_template
import joblib as jb 
import numpy as np

model = jb.load('white_wine_classifier.joblib')

app = Flask(__name__)

# load your trained model

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/predict', methods=['POST'])

def predict():
    # extract input features from the request data
    
    data =  np.array([
                      float(request.form['ph']),
                      float(request.form['residual sugar']),
                      float(request.form['volatile acidity']),
                      float(request.form['citric acid']),
                      float(request.form['free sulfur dioxide']),
                      float(request.form['sulphates']),
                      float(request.form['alcohol'])])
    #Reshape data
    data = data.reshape(1, -1)

    # Make prediction
    prediction = model.predict(data)[0]

    if prediction == 1:
        msg = 'Good wine'

    else:
        msg = 'Bad wine'

    # return the prediction as a json object
    return render_template('predict.html',prediction=prediction,message = msg)

if __name__ == '__main__':
    app.run(debug=True,port=8080)
