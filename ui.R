
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  tags$head(tags$script(src = "message-handler.js")),
  fluidRow(
    column(2),
    column(10,
           h1("German Credit Simulation"),
           p("Data Products Final Project"),
           br(),
           h4("Instructions"),
           p("The next Shiny app, is a simulation of a credit request form."),
           p(
             paste(
               "In order to use it, just play with the form fields and see how the PD",
               "changes."
             )
           )
    )
  ),
  fluidRow(
    column(2),
    column(8,
           h2("Credit Form")
    )
  ),
  hr(),
  fluidRow(
    column(2),
    column(10, h3(textOutput("text1")))
    # ,
    # column(3, actionButton("compute_pd", "Compute PD", class="btn-success pull-right"))
  ),
  hr(),
  fluidRow(

    column(2),
    column(4, 
      selectInput(
        "acccount_status", "Checking Account Status:",
        c(
          "<0 DM" = "X1",
          "[0,200) DM" = "X2",
          ">200 DM" = "X3",
          "No checking account" = "X4"
        )    
      ),
      numericInput("month_duration", "Credit Duration:", 12, min = 4, max = 72, step = 1),
      selectInput(
        "previous_credit_status", "Previous Credit Payment Status:",
        c(
          "No credits taken/All credits paid back" = "X1",
          "All credits at this bank paid back" = "X2",
          "Existing credits paid back till now" = "X3",
          "Payment delays in the past" = "X4",
          "Critical Account/Other credits existing" = "X5"          
        )    
      ),
      selectInput(
        "credit_purpose", "Credit Purpose:",
        c(
          "car (new)" = "X1",
          "car (used)" = "X2",
          "furniture/equipment" = "X3",
          "radio/television" = "X4",
          "domestic appliances" = "X5",
          "repairs" = "X6",
          "education" = "X7",
          "(vacation - does not exist?)" = "X8",
          "retraining" = "X9",
          "business" = "X10",
          "others" = "X11"
        )    
      ),
      numericInput("credit_amount", "Credit Amount:", 5000, min = 343, max = 20000),
      selectInput(
        "saving_accounts_bonds", "Saving Accounts/Bonds:",
        c(
          "... < 100 DM " = "X1",
          "100 <= ... < 500 DM " = "X2",
          "500 <= ... < 1000 DM " = "X3",
          ".. >= 1000 DM " = "X4",
          "unknown/ no savings account" = "X5" 
        )    
      ), 
      selectInput(
        "lengh_current_employment", "Present employment since:",
        c(
          "unemployed"  = "X1",
          "... < 1 year"  = "X2",
          "1 <= ... < 4 years"  = "X3",
          "4 <= ... < 7 years"  = "X4",
          ".. >= 7 years" = "X5" 
        )    
      ), 
      # Attribute 8: (numerical) 
      # Installment rate in percentage of disposable income 
      selectInput(
        "personal_status_sex", "Personal status and sex:",
        c(
          "male : divorced/separated" = "X1",
          "female : divorced/separated/married" = "X2",
          "male : single" = "X3",
          "male : married/widowed" = "X4",
          "female : single" = "X5" 
        )    
      ),  
      
      selectInput(
        "debtors_guarantors", "Other debtors / guarantors:",
        c(
          "none" = "X1",
          "co-applicant" = "X2",
          "guarantor" = "X3"
        )    
      )
    ),
    column(4,
      selectInput(
        "duration_current_addr", "Present residence for N years:",
        c(
          "1" = "X1",
          "2" = "X2",
          "3" = "X3",
          "4" = "X4" 
        )    
      ),       
      selectInput(
        "most_valuable_property", "Property:",
        c(
          "real estate"  = "X1",
          "if not A121 : building society savings agreement/ life insurance"  = "X2",
          "if not A121/A122 : car or other, not in attribute 6"  = "X3",
          "unknown / no property" = "X4" 
        )    
      ),
      numericInput("age", "Age (years):", 40, min = 18, max = 75, step = 1),
      selectInput(
        "concurrent_credits", "Concurrent credits:",
        c(
          "bank" = "X1",
          "stores" = "X2",
          "none" = "X3"
        )    
      ), 
      selectInput(
        "apartment", "Type of apartment:",
        c(
          "rent" = "X1",
          "own" = "X2",
          "for free" = "X3"
        )    
      ),  
      selectInput(
        "no_credits_in_bank", "Number of credits at this bank:",
        c(
          "1" = "X1",
          "2" = "X2",
          "3" = "X3",
          "4" = "X4" 
        )    
      ),
      selectInput(
        "occupation", "Occupation:",
        c(
          "unemployed/ unskilled - non-resident" = "X1",
          "unskilled - resident" = "X2",
          "skilled employee / official" = "X3",
          "management/ self-employed/ highly qualified employee/ officer" = "X4" 
        )    
      ),   
      selectInput(
        "dependents", "Number of dependent people:",
        c(
          "1" = "X1",
          "2" = "X2"
        )    
      ), 
      selectInput(
        "telephone", "Telephone:",
        c(
          "No" = "X1",
          "Yes, registered under the customers name " = "X2"
        )    
      )

      
    )
  ),
  hr(),
  fluidRow(
    column(2),
    column(10,
           h1("German Credit Simulation"),
           p("Data Products Final Project")
    )
  )  

))
