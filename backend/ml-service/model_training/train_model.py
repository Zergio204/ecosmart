import pandas as pd
from sklearn.ensemble import RandomForestRegressor
import joblib

# Datos históricos simulados
data = {
    'dia': [1, 2, 3, 4, 5],
    'nivel_llenado': [30, 45, 60, 75, 90]
}
df = pd.DataFrame(data)

# Entrenar modelo
model = RandomForestRegressor()
model.fit(df[['dia']], df['nivel_llenado'])

# Guardar modelo
joblib.dump(model, 'model.pkl')