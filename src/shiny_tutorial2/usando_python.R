setwd("/home/rstudio/src/shiny_tutorial2")

# Le decimos al paquete donde esta Python
reticulate::use_python("/opt/conda/bin/python")

reticulate::source_python("python_code.py")