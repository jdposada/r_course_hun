library(stringr)

# Instalacion de Python usando Miniconda
MINICONDA_URL = "https://repo.anaconda.com/miniconda/Miniconda3-py39_4.11.0-Linux-x86_64.sh"
command_string <- str_glue("
wget '{MINICONDA_URL}' -O miniconda.sh -q && \\
    sudo mkdir -p /opt && \\
    sudo sh miniconda.sh -b -p /opt/conda && \\
    sudo ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \\
    sudo echo '. /opt/conda/etc/profile.d/conda.sh' >> ~/.bashrc && \\
    sudo echo 'conda activate base' >> ~/.bashrc && \\
    sudo find /opt/conda/ -follow -type f -name '*.a' -delete && \\
    sudo find /opt/conda/ -follow -type f -name '*.js.map' -delete && \\
    sudo /opt/conda/bin/conda clean -afy")
system(command_string)

# Si fuimos exitosos deberiamos ver la version de conda en vez de un error
command_string = "conda --version"
system(command_string)

# Instalamos scikit learn y xgboost
command_string = "sudo /opt/conda/bin/conda install -y -c conda-forge scikit-learn xgboost pandas"
system(command_string)

# Instalamos gapminder y el paquete reticulate para usar python desde R
install.packages("gapminder")
install.packages("reticulate")
install.packages("DT")
