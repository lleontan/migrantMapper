# Library for required packages
library(dplyr)
library(shiny)
library(plotly)

# Source for required documents
source("./scripts/BuildMap_shiwen.R")
source("./scripts/drawGraph.r")
source("./scripts/SearchByCountry.R")

shinyServer(function(input, output, session) {
  # for hoverinfo of countries https://gallery.shinyapps.io/093-plot-interaction-basic/
  # for now renders a plotly, change to whatever whenever the map is done

  # renders the world immigration map
  output$map <- renderPlotly({
    return(BuildMap_shiwen(birthplaces,input$mapYear))
  })
  # renders the immigration % pie chart
  output$total.pie.chart<-renderPlotly({
    largestContributorsGraph(input$pie.country.count, birthplaces)
  })
  # renders the stacked bar chart
  output$countrySumChart<-renderPlotly({
    getCountrySumGraph(regions, input$countrySumSelectedCountry)
  })
  # renders the bubble chart
  output$searchCountry<-renderPlotly({
    SearchByCountry(birthplaces,input$text)
  })
  # Information for a specific country
  output$countryInfo <- renderText({
    getCountryInformation(input$text)
  })
})