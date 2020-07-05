library(keras)
library(BiocManager)
library(tensorflow)
library(reticulate)
library(OpenImageR)
library(devtools)
library(plyr)
# install vctrs
library(lubridate)
library(caret)
library(tseries)
library(tidyverse)

#install.packages("BiocManager")
#BiocManager::install()

# Read images
setwd('/Users/Praery/Documents/test_drink/drink_5')
pics <- c('LeoCan_1.jpg','LeoCan_2.jpg','LeoCan_3.jpg','LeoCan_4.jpg','LeoCan_5.jpg','LeoCan_6.jpg',
          'LeoCan_7.jpg','LeoCan_8.jpg','LeoCan_9.jpg','LeoCan_10.jpg','LeoCan_11.jpg','LeoCan_12.jpg',
          'LeoCan_13.jpg','LeoCan_14.jpg','LeoCan_15.jpg','LeoCan_16.jpg','LeoCan_17.jpg','LeoCan_18.jpg',
          'LeoCan_19.jpg','LeoCan_20.jpg','LeoCan_21.jpg','LeoCan_22.jpg','LeoCan_23.jpg','LeoCan_24.jpg',
          'LeoCan_25.jpg','LeoCan_26.jpg','LeoCan_27.jpg','LeoCan_28.jpg','LeoCan_29.jpg','LeoCan_30.jpg',
          'PepsiCola_1.jpg','PepsiCola_2.jpg','PepsiCola_3.jpg','PepsiCola_4.jpg','PepsiCola_5.jpg','PepsiCola_6.jpg',
          'PepsiCola_7.jpg','PepsiCola_8.jpg','PepsiCola_9.jpg','PepsiCola_10.jpg','PepsiCola_11.jpg','PepsiCola_12.jpg',
          'PepsiCola_13.jpg','PepsiCola_14.jpg','PepsiCola_15.jpg','PepsiCola_16.jpg','PepsiCola_17.jpg','PepsiCola_18.jpg',
          'PepsiCola_19.jpg','PepsiCola_20.jpg','PepsiCola_21.jpg','PepsiCola_22.jpg','PepsiCola_23.jpg','PepsiCola_24.jpg',
          'PepsiCola_25.jpg','PepsiCola_26.jpg','PepsiCola_27.jpg','PepsiCola_28.jpg','PepsiCola_29.jpg','PepsiCola_30.jpg')
mypics <- list()
for(i in 1:60){mypics[[i]] <- readImage(pics[i]) }

# Explore
print(mypics[[1]])
summary(mypics[[1]])
hist(mypics[[2]])
str(mypics)

# Resize

for (i in 1:60) {mypics[[i]] <- resizeImage(mypics[[i]],64,64,method = "nearest") }

 # Reshope
memory.limit(size = 4000)
for (i in i:60) {mypics[[i]] <- array_reshape(mypics[[i]],c(64,64,3))}

# Row Bind
trainx <- NULL
for (i in 31:59) {trainx <- rbind(trainx, mypics[[i]])}
str(trainx)
testx <- rbind(mypics[[30]], mypics[[60]])
trainy <- c(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
            1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1)
testy <- c(0,1)



# One Hot Encoding
trainLabels <- to_categorical(trainy)

testLabels <- to_categorical(testy)



