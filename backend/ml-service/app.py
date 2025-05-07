from flask import Flask, request, jsonify
import joblib
import pandas as pd

app = Flask(__name__)
model = joblib.load('model_training/model.pkl')

@app.route('/predict', methods=['POST'])
def predict():
    data = request.json['historial']
    df = pd.DataFrame(data, columns=['dia', 'nivel_llenado'])
    prediction = model.predict(df)
    return jsonify({'prediccion': prediction.tolist()})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)