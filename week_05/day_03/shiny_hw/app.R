library(shiny)
library(tidyverse)
library(shinythemes)
library(CodeClanData)
all_teams <- unique(olympics_overall_medals$team)
ui <- fluidPage(
    tags$head(
        tags$style(
            HTML(".tabbable > .nav > li[class=active] > a {text-decoration: underline}")
        )
    ),
    
    theme = shinytheme("darkly"),
    
    titlePanel("Olympic Medals"),
        tabsetPanel(
            tabPanel("Plot",
                     sidebarLayout(
                         sidebarPanel(textInput("team",
                                                  label = tags$i("Which Team?"),
                                                  value = "Great Britain"
                                                ),
                                        radioButtons("season",
                                            tags$i("Summer or Winter Olympics?"),
                                            choices = c("Summer", "Winter")
                         )),
                        mainPanel(
                        plotOutput("medal_plot")
                    )
                )
            ), 
 
            tabPanel("Website",
                 tags$a(tags$u("The Olymnpics webiste"), href = "https://www.olympic.org")
            ),
            tabPanel("Flag",
                 img(src = "olympic_flag.png"))
    )
    
)



server <- function(input, output) {
    output$medal_plot <- renderPlot({
    
        
        olympics_overall_medals %>%
            filter(team == input$team) %>%
            filter(season == input$season) %>%
            ggplot() +
            aes(x = medal, y = count, fill = medal) +
            geom_col(width = 0.25) +
            scale_fill_manual(
                values = c("Gold" = "gold",
                           "Silver" = "slategray3",
                           "Bronze" = "orange4")
            ) +
            theme(axis.text = element_text(size = 14),
                  axis.title = element_text(size = 16),
                  plot.title = element_text(size = 20, face = "bold")) +
            labs(
                title = "Total number of Medals\n ",
                x = "Medal\n",
                y = "Number Won\n"
                )
    })
}
shinyApp(ui = ui, server = server)
