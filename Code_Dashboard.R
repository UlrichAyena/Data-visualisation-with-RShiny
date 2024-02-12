library(tidyverse)
library(hrbrthemes)
library(kableExtra)
library(viridis)
library(shinydashboard)
library(shinyWidgets)
library(shiny)
library(DT)
library(dplyr)

# Lecture des données à partir du fichier CSV
data=read.csv('mars2015.csv',header=T,sep=';',na.strings = T)
str(data)
# Définition de l'interface utilisateur (UI)
ui <- fluidPage(
  titlePanel("Analyse des émissions de CO2 des véhicules"),
  sidebarLayout(
    sidebarPanel(
      selectInput("energie", "Sélectionner le type d'énergie :", choices = c("--Sélectionner--", "ESSENCE", "GAZOLE", "HYBRIDE")),
      selectInput("constructeur", "Sélectionner un constructeur :", choices = c("--Sélectionner--", unique(data$marque))),
      selectInput("carrosserie", "Sélectionner une carrosserie :", choices = c("--Sélectionner--", unique(data$carrosserie)))
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Emissions moyennes par constructeur", tableOutput("plot1")),
        tabPanel("Emissions moyennes par carrosserie", tableOutput("plot2")),
        tabPanel("Emissions moyennes par modèle", tableOutput("plot3"))
      )
    )
  )
)

# Définition du serveur
server <- function(input, output, session) {
  output$plot1 <- renderTable({
    if (input$energie != "--Sélectionner--" & input$constructeur != "--Sélectionner--") {
      tab <- data %>%
        filter(energie == input$energie & marque == input$constructeur) %>%
        summarise(Emissions = mean(co2_mixte, na.rm = TRUE))
      tab <- data.frame('Constructeur' = input$constructeur, 'Emissions' = tab$Emissions)
    } else {
      tab <- data %>%
        group_by(marque) %>%
        summarise(Emissions = mean(co2_mixte, na.rm = TRUE))
    }
    tab
  })
  
  output$plot2 <- renderTable({
    if (input$energie != "--Sélectionner--" & input$carrosserie != "--Sélectionner--") {
      tab <- data %>%
        filter(energie == input$energie & carrosserie == input$carrosserie) %>%
        summarise(Emissions = mean(co2_mixte, na.rm = TRUE))
      tab <- data.frame('Carrosserie' = input$carrosserie, 'Emissions' = tab$Emissions)
    } else {
      tab <- data %>%
        group_by(carrosserie) %>%
        summarise(Emissions = mean(co2_mixte, na.rm = TRUE))
    }
    tab
  })
  
  output$plot3 <- renderTable({
    if (input$energie != "--Sélectionner--") {
      tab <- data %>%
        filter(energie == input$energie) %>%
        group_by(marque, modele) %>%
        summarise(Emissions = mean(co2_mixte, na.rm = TRUE))
    } else {
      tab <- data %>%
        group_by(marque, modele) %>%
        summarise(Emissions = mean(co2_mixte, na.rm = TRUE))
    }
    tab
  })
}

# Lancement de l'application Shiny
shinyApp(ui, server)
