library(shiny)

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

# Servidor que corre las funcionalidades
server <- function(input, output) {
  
  # La variable de salida debe coincidir con lo declarado en la funcion en ui
  # en este caso el nombre es grafica1
  
  # las variables que vienen desde el UI vienen en la variable input
  output$grafica1 <- renderPlot({
    Variable    <- input$Variable
    data_sample <- X_test[1, ]
    data_sample[1] <- Variable
    y_hat <- model2$predict(data_sample)
    plot(Variable, y_hat)
    
  })
  
  # guardamos el render del dataframe en la variable que se esta esperando que es
  # tabla1
  output$tabla1 <- DT::renderDataTable(expr = X_test)
  
}


# Interfaz Grafica
ui <- fluidPage(
  
  # Agregamos un titulo al APP
  titlePanel("Predicciones de un modelo con XgBoost"),
  
  sidebarLayout(
    
    sidebarPanel(

      sliderInput(inputId = "Variable",
                  label = "Variable Escogida: trestbps",
                  min = min(X$trestbps),
                  max = max(X$trestbps),
                  step = 1,
                  value = min(X$trestbps))
    ),
    
    mainPanel(
      
      # Displot es el nombre de la variable que contiene al grafico
      plotOutput(outputId = "grafica1"),
      
      # Visualizacion de dataframes
      DT::dataTableOutput(outputId = "tabla1")
    )
    
  )
  
)

shinyApp(ui = ui, server = server)