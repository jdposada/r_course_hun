# Establecemos el source directory
setwd("/home/rstudio/src/shiny_tutorial2")

# Le decimos al paquete donde esta Python
reticulate::use_python("/opt/conda/bin/python")

# Importar el modulo en R
xgb <- reticulate::import("xgboost")
sk_ms <- reticulate::import("sklearn.model_selection")
pd <- reticulate::import("pandas")

# Importamos los datos desde R
url <- 'https://media.githubusercontent.com/media/PacktPublishing/Hands-On-Gradient-Boosting-with-XGBoost-and-Scikit-learn/master/Chapter02/heart_disease.csv'
py_df = pd$read_csv(url)
X = py_df[ , c(1,2,3,4,5,6,7,8,9,10,11,12,13)]
y = py_df[, 14]

# Funcion para particionar los datos
output_split = sk_ms$train_test_split(X, y, test_size=0.25)
X_train =  output_split[[1]]
X_test = output_split[[2]]
y_train = output_split[[3]]
y_test = output_split[[4]]

# Cargamos el modelo
model2 = xgb$XGBRegressor()
model2$load_model("~/src/shiny_tutorial2/model_sklearn.json")

# predecimos usando el modelo
threshold <- 0.5
predictions <- as.numeric(model2$predict(X_test) >= threshold)
plot(y_test, predictions)

plot(X_test$sex, predictions)
