if (!require('pROC')){
  install.packages('pROC')
  library(pROC)
}

if (!require('randomForest')){
  install.packages('randomForest')
  library(randomForest)
}


url="http://freakonometrics.free.fr/german_credit.csv"
credit=read.csv(url, header = TRUE, sep = ",") 
factor_variables = c(1,2,4,5,7,8,9,10,11,12,13,15,16,17,18,19,20)

set.seed(3456)
trainIndex <- createDataPartition(credit$Creditability, p = .7, list = FALSE, times = 1)
creditTrain <- credit[ trainIndex,]
creditTest  <- credit[-trainIndex,]

nzv <- nearZeroVar(creditTrain)
credit_nzv <- creditTrain[, -nzv]

credit_cor <- cor(credit_nzv)

highlyCorDescr <- findCorrelation(credit_cor, cutoff = .75)

if(length(highlyCorDescr) > 0){
  credit_nzv_corr <- credit_nzv[,-highlyCorDescr]
} else credit_nzv_corr <- credit_nzv 

comboInfo <- findLinearCombos(credit_nzv_corr)

if(length(comboInfo$remove) > 0){
  credit_lc <- credit_nzv_corr[, -comboInfo$remove]
} else credit_lc <- credit_nzv_corr

# View(head(credit_lc))

for(i in factor_variables) credit_lc[,i]=as.factor(credit_lc[,i])

feature.names=names(credit_lc)

for (f in feature.names) {
  if (class(credit_lc[[f]])=="factor") {
    levels <- unique(c(credit_lc[[f]]))
    credit_lc[[f]] <- factor(credit_lc[[f]],
                             labels=make.names(levels))
  }
}

# names(credit_lc)

set.seed(12345)

rf_model<-train(
  factor(Creditability)~., 
  data=credit_lc, 
  method="rf", 
  metric = "ROC",
  trControl=trainControl(
    method="cv", 
    number=5, 
    classProbs=TRUE,
    summaryFunction = twoClassSummary
  ),
  prox=TRUE,
  allowParallel=TRUE
)

# save the model to disk
saveRDS(rf_model, "./rf_model.rds")