install.packages("dplyr")
install.packages("tidytext")
install.packages("tm")
install.packages("stringr")
install.packages("proxy")
install.packages("ggplot2")
install.packages("cluster")
install.packages("xfun")
library(xfun)
library(cluster)
library(ggplot2)
library(proxy)
library(doSNOW)
library(stringr)
library(tm)
library(dplyr)
library(tidytext)

# data source
data <- anthems    

# create a list of anthems from data source
my_func <- function(D){
  x <- list()
  for (k in 1:190){
    x[[k]] <- D[k,5]
  }
  x
}


anthem <- my_func(anthems)

corpus <- VectorSource(anthem)
corpus <- Corpus(corpus)

# list of custom stopwords
cwords <- c(stopwords)

# data cleaning
anthem <- tm::tm_map(corpus, tolower)
anthem <- tm::tm_map(anthem, removeWords, stopwords("english"))
anthem <- tm::tm_map(anthem, removeNumbers)
anthem <- tm::tm_map(anthem, removePunctuation)
anthem <- tm::tm_map(anthem, removeWords, c("may","thee","thou","thy",
                                            "say","ever","every","across",
                                            "another","many","will","cut","always",
                                            "avoid","listanthem","one","make","let","shall"))
                                            

#custom <- c(stopwords)
#custom <- head(sort(unlist(custom), decreasing=TRUE), 3) 
anthem <- tm::tm_map(anthem, stemDocument)

# data processing and TD-IDF weights
dtm <- DocumentTermMatrix(anthem)
dtm <- removeSparseTerms(dtm, sparse = 0.98)
dtm.tfidf <- weightTfIdf(dtm)
tfidf.matrix <- t(as.matrix(dtm.tfidf))

# K-means cluster analysis
fviz_nbclust(tfidf.matrix, kmeans, method = "wss")
clustering.kmeans <- kmeans(tfidf.matrix, centers = 5, nstart = 50)
