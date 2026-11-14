library(shiny)
library(ggplot2)
library(gapminder)

# UI
ui <- fluidPage(
  titlePanel("Gapminder Bubble Plot over Time"),
  verticalLayout(
    mainPanel( width=100,
      plotOutput("bubblePlot")
    ),    
    sliderInput(
      width=100,
      inputId = "year",
      label = "Select Year:",
      min = min(gapminder$year),
      max = max(gapminder$year),
      value = min(gapminder$year),
      step = 5,
      animate = animationOptions(interval = 100, loop = FALSE)
    )
  )
)

# Server
server <- function(input, output) {
  filteredData <- reactive({
    subset(gapminder, year == input$year)
  })
  
  output$bubblePlot <- renderPlot({
    ggplot(filteredData(), aes(x = gdpPercap, y = lifeExp, size = pop, color = continent)) +
      geom_point(alpha = 0.7) +
      scale_x_log10(limits = c(250, 120000)) +
      scale_y_continuous(limits = c(20, 90)) +
      scale_size_area(max_size = 20, guide = "none") +
      labs(
        title = paste("Year:", input$year),
        x = "GDP per capita (log scale)",
        y = "Life Expectancy (years)",
        color = "Continent"
      ) +
      theme_minimal()
  })
}

# Run App
shinyApp(ui = ui, server = server)
