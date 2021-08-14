#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)

fluidPage(theme = shinytheme("cerulean"),
    
    titlePanel("What am I doing with my life?"),
    
    
    fluidRow(
        
        
        
        column(2,
               "",
               selectizeInput("selectPlayer", 
                              label = "Player Selected:", 
                              choices = NULL)),
        
        
        column(10,
               "",
               
               h1("Selected Player"),
               
               tableOutput("playerInfo"),
               
               br(),
               
               h1("Similar Players"),
               h2("Table"),
               p("Lower score is better"),
               
             
               tableOutput("otherPlayer"),
               
               h2("Graph"),
        
               plotOutput("graphPlayers"))
    
    
    
        )
    )