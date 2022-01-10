# ##################################################################
# #
# # SCRIPT:
# #
# # BUS FLEET OF PORTO ALEGRE CITY - BRAZIL
# #
# ##################################################################

# ------------------------------------------------------------------
# - 
# - BUSINESS QUESTIONS:                       
# - 
# - + How old is the bus fleet in avarage?
# - + What bus operator has the oldest fleet?
# - + 
# - 
# ------------------------------------------------------------------

# ------------------------------------------------------------------
# Directory Defition
# ------------------------------------------------------------------

#setwd("C:/Users/rafael/Documents/R-Scritps/01-BUS_POA")
getwd()

# ------------------------------------------------------------------
# Data Collection
# ------------------------------------------------------------------

# Site: http://datapoa.com.br/group/mobilidade
# Search: http://datapoa.com.br/dataset/stpoa-sistema-de-transporte-publico-de-porto-alegre
# Dataset: http://datapoa.com.br/dataset/stpoa-sistema-de-transporte-publico-de-porto-alegre/resource/2fc8158f-5c80-415e-aeca-4c2d189ca7fc

data <- read.csv2("data/frota_onibus.csv")

# ------------------------------------------------------------------
# Raw Data - General View
# ------------------------------------------------------------------

View(data)
head(data)

# ------------------------------------------------------------------
# Data Cleaning and Transformation
# ------------------------------------------------------------------

# Remove white spaces from column 'Marca'
data$marca <- trimws(data$marca, c("both"))

# Remove white spaces from column 'Modelo'
data$modelo <- trimws(data$modelo, c("both"))

# Remove 'Data_extracao' column
data$data_extracao <- NULL

# Transform column 'placa' in char
data$placa <- as.character(data$placa)

# Transform column 'prefixo' in char
data$prefixo <- as.character(data$prefixo)

# Transform column 'data_primeiro_emplac' in date
data$data_primeiro_emplac <- as.Date(data$data_primeiro_emplac)

# Transform column 'marca' in factor
data$marca <- as.factor(data$marca)

# Fix wrong values: 

# (1) Replace "Ã\201LCOOL-GASOLINA" to "Álcool-Gasolina"
levels(data$combustivel) <- sub("Ã\201LCOOL-GASOLINA", "Álcool-Gasolina", levels(data$combustivel))

# (2) Replace "" (empty value) to "N/A"
levels(data$combustivel)[1] <- "N/A"

# (3) Replace "Ã\201LCOOL-GASOLINA" to "Álcool-Gasolina"
levels(data$operador) <- sub("EMPRESA DE TRANSPORTES GASÃ”METRO S.A.", "EMPRESA DE TRANSPORTES GASOMETRO S.A.", levels(data$operador))

# ------------------------------------------------------------------
# Data Analytics
# ------------------------------------------------------------------

#ncol(data)
#nrow(data)

str(data)

levels(data$operador)
levels(data$marca)
levels(data$combustivel)

summary(data, maxsum = 20)

# ------------------------------------------------------------------
# Insights
# ------------------------------------------------------------------

summary(data$ano_fabricacao)

average_age_all <- as.integer(mean(data$ano_fabricacao))

average_age_all

average_age_each <- tapply(data$ano_fabricacao, data$operador, mean)

average_age_each

# ------------------------------------------------------------------
# Data Visualization
# ------------------------------------------------------------------

hist(data$ano_fabricacao)
