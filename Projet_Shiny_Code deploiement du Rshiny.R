
---------------------------------------------------------------------------------------
##Installation des packages
---------------------------------------------------------------------------------------
#install.packages("rsconnect")
install.packages("rsconnect", lib = "C:/Users/ayena/OneDrive/Documents/R/win-library/4.0")
#install.packages(c("tidyverse", "hrbrthemes", "kableExtra", "viridis"))
install.packages("colorspace")
install.packages("ggplot2")
install.packages("tidyverse")
install.packages("hrbrthemes")
install.packages("kableExtra")
install.packages("viridis")
install.packages("shinydashboard")
install.packages("shinyWidgets")
install.packages("DT")
install.packages("labeling")
#install.packages("tidyverse", lib = "C:/Users/ayena/OneDrive/Documents/R/win-library/4.0")
--------------------------------------------------------------------------------------------
#### Code de déploiement  
--------------------------------------------------------------------------------------------

install.packages("shiny")
library(shiny)
#install.packages("rsconnect") 
install.packages("rsconnect", lib = "C:/Users/ayena/OneDrive/Documents/R/win-library/4.0")
library(rsconnect)

rsconnect::setAccountInfo(name='', token='', secret='')
rsconnect::deployApp("C:/Users/ayena/OneDrive/Documents/Projet_Shiny")
rsconnect::deployApp(appDir = "C:/Users/ayena/OneDrive/Documents/Projet_Shiny", appPrimaryDoc = "CodeDataViz.R")

