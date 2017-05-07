#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

if (!require('caret')){
  install.packages('caret')
  library(caret)
}

if (!require('pROC')){
  install.packages('pROC')
  library(pROC)
}

if (!require('randomForest')){
  install.packages('randomForest')
  library(randomForest)
}

#View(head(credit_lc))
rf_model <- readRDS("rf_model.rds")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  v <- reactiveValues(data = NULL)
  
  toListen <- reactive({
    list(
      input$acccount_status,
      input$month_duration,
      input$previous_credit_status,
      input$credit_purpose,
      input$credit_amount,
      input$saving_accounts_bonds,
      input$lengh_current_employment,
      input$personal_status_sex,
      input$debtors_guarantors,
      input$duration_current_addr,
      input$most_valuable_property,
      input$age,
      input$concurrent_credits,
      input$apartment,
      input$no_credits_in_bank,
      input$occupation,
      input$dependents,
      input$telephone
    )
  })
  
  observeEvent(toListen(), {
    X_test <- data.frame(
      Account.Balance = input$acccount_status, # c('X1'),
      Duration.of.Credit..month. = input$month_duration, # c(18),
      Payment.Status.of.Previous.Credit = input$previous_credit_status, #c('X1'),
      Purpose = input$credit_purpose, # c('X1'),
      Credit.Amount = input$credit_amount, # c(1049),
      Value.Savings.Stocks = input$saving_accounts_bonds, # c('X1'),
      Length.of.current.employment = input$lengh_current_employment, # c('X4'),
      Instalment.per.cent = c('X1'),
      Sex...Marital.Status = input$personal_status_sex, # c('X3'),
      Guarantors = input$debtors_guarantors, # c('X1'),
      Duration.in.Current.address = input$duration_current_addr, # c('X1'),
      Most.valuable.available.asset = input$most_valuable_property, # c('X1'),
      Age..years. = input$age, # c(21),
      Concurrent.Credits = input$concurrent_credits, # c('X2'),
      Type.of.apartment = input$apartment, # c('X1'),
      No.of.Credits.at.this.Bank = input$no_credits_in_bank, # c('X1'),
      Occupation = input$occupation, # c('X1'),
      No.of.dependents = input$dependents, # c('X1'),
      Telephone = input$telephone # c('X1')
    )
    
    v$pd <- paste(100.0 * predict(rf_model, newdata = X_test, type="prob")[['X2']], "%")
  })  
  
  output$text1 <- renderText({ 
    paste("Probability of default: ", v$pd)
  })
 
  
  
  
})
