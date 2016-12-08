library(dplyr)
library(plotly)

BuildMap_shiwen <- function(d,year){
  l <- list(color = toRGB("grey"), width = 0.5)
  year <- paste0("X",year)
  data <- mutate_(data,population = year)
  n <- as.character(data$population)
  n <- as.numeric(n)
  n <- is.na(n)
  
  g <- list(
    showframe = FALSE,
    showcoastlines = FALSE,
    projection = list(type = 'Mercator')
  )     
  data$hover <- with(data,paste(OdName,'<br>',"Population",population))
  
  p <- data %>%
      plot_geo() %>%
    add_trace(
      z = ~population, 
      zmin = 0,
      zmax = 10000,
      text = ~hover, 
      locations = ~Country_Code,
      color = n,
      colorscale = "YlOrRd",
      reversescale = TRUE,
      colorbar = list(
      ticklen = 5,
      len = 1,
      title = "Population"),
      marker = list(line = l)
    )  %>%
    layout(
      title = 'Where they come from<br>(Hover for breakdown)',
      geo = g
    )
  return(p)
}