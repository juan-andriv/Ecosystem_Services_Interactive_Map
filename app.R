### ECOSYSTEM SERVICES INTERACTIVE MAP ### ----
### Juan Andrade Rivera
### 24.03.2024
### linkedin: linkedin.com/in/juan-andriv

### The input data is formatted as the output of the free software iTreeEco.
### developed by the US-FS to calculate ecosystem services based on dasometric data. 
### Download: https://www.itreetools.org/i-tree-tools-download

# Load libraries ----
library(shiny)
library(leaflet)
library(dplyr)
library(leaflet.extras)
library(ggplot2)

# Import data ----
data <- read.csv("Data/Ecosystem_Services_latlong.csv", header = TRUE)

# ui.R ----
ui <- fluidPage(
  titlePanel("Ecosystem services provided per tree"), # application title
  mainPanel(
    leafletOutput(outputId = "map", height = 600), # space to display the map
    absolutePanel(top = 0, right = 15, width = 200, # Add a panel to select services
                  style = "background-color: white; border: 1px solid #999999;", # make the panel white with gray border
                  selectInput("services", "Select ecosystem services",
                            choices = c("Avoided runoff" = "Avoided.Runoff..m3.year.",
                                        "Oxygen production" = "O2.Produced..kg.year.",
                                        "Total pollution removed" = "Total.Pollution.Removed..g.year.",
                                        "VOC production" = "VOC.Produced..g.year.",
                                        "Water interception" = "Water.Intercepted..m3.year."),
                            selected = NULL),
               ),
             
      absolutePanel(bottom = 25, right = 15, width = 200, height = "80%",
                    style = "background-color: white; border: 1px solid #999999;",
                    plotOutput("graph", height = "100%")
      )  
     )
)

# server.R ----
server <- function(input, output) {

# Create the leaflet map
output$map <- renderLeaflet({

# Filter data based on selected service
filtered_data <- data %>%
  filter(!is.na(.data[[input$services]]) & .data[[input$services]] != 0) %>%
  select(Longitude, Latitude, input$services)

# Create 5 equal intervals to categorize data based on max value
# calculate max values of selected service
max_value <- max(filtered_data[[input$services]], na.rm = TRUE)

# Calculate interval size
interval_size <- max_value / 10

# Create equal intervals categories  
categories <- cut(filtered_data[[input$services]],
                  breaks = seq(0, max_value, by = interval_size),
                  include.lowest = TRUE,
                  labels = FALSE)

# create color palette
pal <- colorBin(palette = c("palegreen", "lightseagreen", "mediumseagreen", "firebrick"), domain = c(0, max_value), bins = 10, na.color = rgb(0, 0, 0, alpha = 0))

# save them as reactiveValues object
colors <- reactiveValues(palette = pal(filtered_data[[input$services]]))

# create the leaflet map
map <- leaflet(data = filtered_data) %>%
      setView(lng = -101.015261, lat = 22.144573, zoom = 16) %>%
      addTiles() %>%
# Add custom background map, 
      addProviderTiles(providers$Esri.WorldTopoMap) %>% # by typing "providers$" the options appear
# Add fullscreen button
  addFullscreenControl() %>%
# Add the markers  
  addCircleMarkers(data = filtered_data, # add circle markers for each coordinate set
                       lng = ~Longitude,
                       lat = ~Latitude, 
                       radius = 1,
                       color = ~pal(filtered_data[[input$services]]),
                       fillColor = ~pal(filtered_data[[input$services]]),
                       fillOpacity = 0.8,
                       popup = paste0( # add a little popup with some data
                         "<strong>Species: </strong>", data$Species, "<br>",
                         "<strong>Height (m): </strong>", data$Height..m., "<br>",
                         "<strong>Cover (m2): </strong>", data$Canopy.cover..m2., "<br>")
                     ) %>%
                    # Create a legend
                    addLegend(position = "bottomleft",
                       pal = pal,
                       values = categories, 
                       title = input$services,
                       labels = as.characters(categories))
      })

# Create an graph to show distribution of data
output$graph <- renderPlot({
  filtered_data <- data %>%
    filter(!is.na(.data[[input$services]]) & .data[[input$services]] != 0)

# Boxplot specifications  
  ggplot(filtered_data, aes
         (x = "", y = .data[[input$services]])) +
    
    geom_violin(fill = "skyblue", color = "blue", alpha = 0.6) +
    geom_boxplot(width = 0.1, fill = "white", color = "black") +
    labs(title = "Data distribution",
         x = "Density") +
    theme_minimal() +
    theme(plot.title = element_text(hjust = 0.5),
            axis.ticks.margin = unit(0,'cm'))
})
}

# Run the app ----
shinyApp(ui = ui, server = server)
