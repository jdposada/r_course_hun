library(shiny)
library(gapminder)

# Interfaz Grafica
ui <- fluidPage(
  
  # Agregamos un titulo al APP
  titlePanel("GDP per capita"),
  
  sidebarLayout(
    
    sidebarPanel(
      # Agregamos un slider que arroja una variable "particiones" para que pueda ser 
      # usada dentro del server
      sliderInput(inputId = "particiones",
                  label = "Numero de bins",
                  min = 5,
                  max = 20,
                  step = 5,
                  value = 10)
    ),
    
    mainPanel(
      
      # Displot es el nombre de la variable que contiene al grafico
      plotOutput(outputId = "grafica1"),
      
      # Visualizacion de dataframes
      DT::dataTableOutput(outputId = "tabla1")
    )
    
  )
  

  

  
)

# Servidor que corre las funcionalidades
server <- function(input, output) {
  
  # La variable de salida debe coincidir con lo declarado en la funcion en ui
  # en este caso el nombre es grafica1
  
  # las variables que vienen desde el UI vienen en la variable input
  output$grafica1 <- renderPlot({
                                  x    <- gapminder$gdpPercap
                                  hist(x, 
                                       breaks=input$particiones,
                                       col = 'darkgray',
                                       border = 'white')
                                })
  
  # guardamos el render del dataframe en la variable que se esta esperando que es
  # tabla1
  output$tabla1 <- DT::renderDataTable(expr = gapminder[, c(1,6)])
  
}

shinyApp(ui = ui, server = server)