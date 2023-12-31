library(e1071)
f<-read.csv("train.csv")
#print(head(f))
f$blue <- as.factor(f$blue)
f$dual_sim <- as.factor(f$dual_sim)
f$four_g <- as.factor(f$four_g)
f$three_g<- as.factor(f$three_g)
f$touch_screen <- as.factor(f$touch_screen)
f$wifi <- as.factor(f$wifi)
f$price_range <- as.factor(f$price_range)
#splitting the data into train and test----
set.seed(123)
split<-sample.split(f,SplitRatio=0.8)
tr_data<-subset(f,split==TRUE)
ts_data<-subset(f,split==FALSE)

svmfit <- svm(price_range~ ., data = tr_data, kernel = "linear", cost=10, scale = FALSE)
print(svmfit)
pred <- predict(svmfit, ts_data)
t1<- table(ts_data$price_range, pred)
confusionMatrix(t1, mode="everything", positive ="1")

#Roc
pred <- as.integer(pred)
tr_data$price_range<- as.integer(tr_data$price_range)
s3 <- roc(ts_data$price_range, pred)
s3