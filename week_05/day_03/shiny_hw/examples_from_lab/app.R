library(shiny)
library(tidyverse)
library(CodeClanData)
library(shinythemes)
all_teams <- unique(olympics_overall_medals$team)
ui <- fluidPage(
    
    theme = shinytheme("flatly"),
    
    titlePanel(tags$h1("Olympic Medals")),
    sidebarLayout(
        sidebarPanel(
            radioButtons("season",
                         tags$i("Summer or Winter Olympics?"),
                         choices = c("Summer", "Winter")
            ),
            selectInput("team",
                        "Which Team?",
                        choices = all_teams
            )
        ),
        mainPanel(
            plotOutput("medal_plot"),
            
            tags$a("The Olymnpics webiste", href = "https://www.olympic.org")
        )
    )
)
server <- function(input, output) {
    output$medal_plot <- renderPlot({
        olympics_overall_medals %>%
            filter(team == input$team) %>%
            filter(season == input$season) %>%
            ggplot() +
            aes(x = medal, y = count, fill = medal) +
            geom_col()
    })
}
shinyApp(ui = ui, server = server)
