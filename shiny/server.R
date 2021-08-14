#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(here)
library(janitor)
library(ggplot2)
library(forcats)

df <- readRDS("exported.rds")


# Define server logic 
shinyServer(function(input, output, session) {
    
    
    player_names <- df$player
    updateSelectizeInput(session,
                         inputId = "selectPlayer", 
                         choices = player_names, 
                         server = TRUE)
    
    
    
    
    
    
    output$playerInfo <- renderTable({
        df %>% 
            filter(player == input$selectPlayer) %>% 
            select(2:6) %>% 
            clean_names(case = "title")
        
    })
    
    
    output$otherPlayer <- renderTable({df %>% 
            select(player, country, position, club, league, score = input$selectPlayer) %>% 
            arrange(score) %>% 
            filter(score != 0) %>% 
            head(10) %>% 
            clean_names(case = "title")
    })
    
    
    
    output$graphPlayers <- renderPlot({
        df %>% 
        select(player, score = input$selectPlayer) %>% 
            arrange(score) %>% 
            head(10) %>% 
            mutate(player = fct_reorder(player, score, min)) %>% 
            ggplot() +
            geom_col(aes(player,score)) +
            theme_minimal() +
            labs(x= "",
                 y= "Score",
                 title = "Euclidean distance between PCA components",
                 subtitle = "Based on players with > 900 minutes in the 'top five' leagues in 2020/2021") +
            theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=1))
        
        
        
    })
    
    

})
