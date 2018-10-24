library(sigFeature)   #imports the package
setwd("/Users/ramitb/Documents/Working_copy_kea/KEADrugResponse/data/ColbySVM-RFE")
x <- read.csv("cisplatinfeatures.csv") #readsthefile
y <- x[1] #creates target vector
x <- x[2:21] #creates feature vector
system.time(sigfeatureRankedList <- sigFeature(x, y)) #performs rfe
library(e1071)  #package to implement a svm
sigFeature.model=svm(x[ ,sigfeatureRankedList], y,type="C-classification", kernel="linear") #runs a svm model
pred <- predict(sigFeature.model, x[ ,sigfeatureRankedList]) #predicts crossvalidation results(default is 10-fold)
y <- y[,1] #mateches dimensions to that of pred
table(pred,y)
system.time(featureRankedList <- svmrfeFeatureRanking(x, y)) #optional command that runs another svm-rfe model that is slower than sigfeatiure
pred <- predict(RFE.model, x[ ,featureRankedList])
table(pred,y) #outputs table with True positives, False positives, True negatives and False negatives.
table <- table(pred,y)
write.csv(table, file = "cisplatinresults.csv") #writes results to a file
