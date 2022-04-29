import xgboost as xgb
from sklearn.datasets import make_classification
from sklearn.model_selection import train_test_split
import pandas as pd

url = 'https://media.githubusercontent.com/media/PacktPublishing/Hands-On-Gradient-Boosting-with-XGBoost-and-Scikit-learn/master/Chapter02/heart_disease.csv'
df = pd.read_csv(url)
X = df.iloc[:, :-1]
y = df.iloc[:, -1]

df.head()

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.25)

model = xgb.XGBRegressor(n_estimators=100, 
                         max_depth=3, 
                         learning_rate=0.01)

model.fit(X_train, y_train, 
          eval_set=[(X_train, y_train), (X_test, y_test)], 
          early_stopping_rounds=20)

model.predict(X_test)

model.save_model("/home/rstudio/src/shiny_tutorial2/model_sklearn.json")

model2 = xgb.XGBRegressor()
model2.load_model("/home/rstudio/src/shiny_tutorial2/model_sklearn.json")

model2.predict(X_test)
