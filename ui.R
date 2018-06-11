# Load libraries
library(shiny)
library(leaflet)

# Make data with several positions
data_red=data.frame(LONG=-64.6111+rnorm(3), LAT=18.318+rnorm(3), PLACE=paste("Red_place_",seq(1,3)))
data_blue=data.frame(LONG=-64.6111+rnorm(3), LAT=18.318+rnorm(3), PLACE=paste("Blue_place_",seq(1,3)))

# Initialize the leaflet map:
leaflet() %>% 
  setView(lng=-64.6111174, lat=18.318449, zoom=5 ) %>%
  addMarkers(lng=-64.6111174, lat=18.318449, popup = "Treasure Island aka Norman Island") %>%
  # Add two tiles
  addProviderTiles("Esri.WorldImagery", group="Satellite View") %>%
  addTiles(options = providerTileOptions(noWrap = TRUE), group="Map View") %>%
  
  # Add 2 marker groups
  addCircleMarkers(data=data_red, lng=~LONG , lat=~LAT, radius=8 , color="black",  fillColor="red", stroke = TRUE, fillOpacity = 0.8, group="No Success") %>%
  addCircleMarkers(data=data_blue, lng=~LONG , lat=~LAT, radius=8 , color="black",  fillColor="blue", stroke = TRUE, fillOpacity = 0.8, group="To Search") %>%
  
  # Add the control widget
  addLayersControl(overlayGroups = c("No Success","To Search") , baseGroups = c("Satellite View","Map View"), options = layersControlOptions(collapsed = FALSE))