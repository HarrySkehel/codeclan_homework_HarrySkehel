

library(shiny)
library(shinythemes)



# I have chosen these plots as they give a good overall representation of how the overall reception of 
# games has decreased since games first starting appearing. The also show the variation between the critics ratings
# and the game players ratings. Splitting it be consol also shows that the newer consoles don't always getting better rated games.

ui <- fluidPage(theme = shinytheme("sandstone"),
    titlePanel("Have games improved over time?"),

    mainPanel(
        tabsetPanel(
            tabPanel("By Publisher",
                     sidebarPanel(
                         fluidRow(
                             selectInput(
                                 inputId = "publisher",
                                 label = "Which Publisher",
                                 choices = unique(games$publisher)
                             )
                         )
                     ),
                     mainPanel(
                         plotOutput("line_plot"),
                         plotOutput("line_plot_2")
                     )
                ),
            tabPanel("By Console",
                     sidebarPanel(
                         fluidRow(
                             selectInput(
                                 inputId = "platform",
                                 label = "Console",
                                 choices = unique(games$platform)
                             )
                         )
                     ),
                     mainPanel(
                         plotOutput("console"),
                         plotOutput("console_critic")
                )
                
            ),
            tabPanel("Best sellers",
                     plotOutput("best_sellers")
                    )
            )
        )
    ) 
   

server <- function(input, output) {
    output$line_plot <- renderPlot({games %>% 
            group_by(year_of_release) %>% 
            filter(publisher == input$publisher) %>% 
            summarise(avg.rating = mean(user_score)) %>% 
            ggplot() +
            aes(x = year_of_release, y = avg.rating) %>% 
            geom_line() +
            labs(x = "Year",
                 y = "Avg. Rating",
                 title = "Average User Scores\n") +
            theme_classic()})
    
    output$line_plot_2 <- renderPlot({games %>% 
            group_by(year_of_release) %>% 
            filter(publisher == input$publisher) %>% 
            summarise(avg.rating = mean(critic_score)) %>% 
            ggplot() +
            aes(x = year_of_release, y = avg.rating) %>% 
            geom_line() +
            labs(x = "Year",
                 y = "Avg. Rating",
                 title = "Averagen Critic Scores\n") +
            theme_classic()})

    output$console <- renderPlot({games %>% 
            group_by(year_of_release) %>% 
            filter(platform == input$platform) %>% 
            summarise(avg.rating = mean(user_score)) %>% 
            ggplot() +
            aes(x = year_of_release, y = avg.rating) %>% 
            geom_line() +
            labs(x = "Year",
                 y = "Avg. Rating",
                 title = "Average User Scores\n") +
            theme_classic()
    })
        
        output$console_critic <- renderPlot({games %>% 
                group_by(year_of_release) %>% 
                filter(platform == input$platform) %>% 
                summarise(avg.rating = mean(critic_score)) %>% 
                ggplot() +
                aes(x = year_of_release, y = avg.rating) %>% 
                geom_line() +
                labs(x = "Year",
                     y = "Avg. Rating",
                     title = "Average Crtic Scores\n") +
                theme_classic()
    
})
        
        output$best_sellers <- renderPlot({games %>% 
                arrange(desc(sales)) %>% 
                head(n = 20) %>% 
                ggplot() +
                aes(x = name, y = sales, fill = platform) +
                geom_col() +
                labs(x = "Game Title",
                     y = "Copies sold (million)",
                     title = "20 Best Selling Games") +
                     coord_flip() 
                })
    
}

shinyApp(ui = ui, server = server)
