library(sigFeature)
setwd("/Users/ramitb/Documents/Working_copy_kea/KEADrugResponse/data/ColbySVM-RFE")
x <- read.csv("cisplatinfeatures.csv")
y <- x[1]
x <- x[2:21]
system.time(sigfeatureRankedList <- sigFeature(x, y))
library(e1071)
sigFeature.model=svm(x[ ,sigfeatureRankedList], y,type="C-classification", kernel="linear")
pred <- predict(sigFeature.model, x[ ,sigfeatureRankedList])
y <- y[,1]
table(pred,y)
system.time(featureRankedList <- svmrfeFeatureRanking(x, y))
pred <- predict(RFE.model, x[ ,featureRankedList])
table(pred,y)
table <- table(pred,y)
write.csv(table, file = "cisplatinresults.csv")