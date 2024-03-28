# Author: Zatovic Dominik 
# Date: 2024-Mar-04
# Goal: Prva bonusova uloha
# Riesenie

#-----------------------------------------------------------------------------
# QUESTION 1)
# MY WORKING: 
#First i open the file and load data from it
data <- read.csv("AlzheimerData.csv", fileEncoding = "UTF-8")
head(data)
View(data)
set.seed(23)
#Then using functions mean (for average) and median (for median) i calculate average
#and median for age and cognition
age_mean <- mean(data$Age)
age_median <- median(data$Age)
cognition_mean <- mean(data$Cognition)
cognition_median <- median(data$Cognition)
#I print it out
cat("Average Age:", age_mean, "\n")
cat("Median Age:", age_median, "\n")
cat("Average Cognition:", cognition_mean, "\n")
cat("Median Cognition:", cognition_median, "\n")
# MY ANSWER: 
#The average Age is 73.15498, 
#Median age is 73.22378, 
#Average Cognition is 0.5032508
#Median Cognition is 0.4981977

#We can see the average and median are really close, nearly equal which
#means the data is symetrically distributed

#-----------------------------------------------------------------------------
# QUESTION 2)
# MY WORKING:
library(ggplot2)
#Firstly i make groups for each age category
age_groups <- c(50, 60, 70, 80, 90)
#I make strings that will be put in the data, showing the whole age category parameters
age_labels <- c("50-60", "61-70", "71-80", "81-90")
#I add new data to my data set. Command cut divides data based on Age values. Age_groups is a
#vector that defines boundaries that determine how the data will be divided into labels.
#labels then assigns the age_labels created by function cut
data$Age_Group <- cut(data$Age, breaks = age_groups, labels = age_labels, include.lowest = TRUE)
#head(data) will put my new column in my data set
head(data)

#Now I am creating boxplot for cognition for each age group.
#First i define aesthetics for the boxplot 
plot <- ggplot(data, aes(x = Age_Group, y = Cognition))
#Then i create boxplot with ggplot and adding labels to it
plot + geom_boxplot() +
  labs(x = "Age Group", y = "Cognition", title = "Boxplot of Cognition by Age Group")
# MY ANSWER:
#The best cognition has the age group of 50-60, as we can see the median is centered
#in the middle of the box and the whiskers are also symetrical
#There are few outliers in the age group of 81-90, which we can see by the dots around
#values of 0.2 cognition
#The boxplots seems to be more symetrical then not, apart from the age group of 81-90, which is
#pretty asymetrical and contains also outliers

#----------------------------------------------------------------------------


