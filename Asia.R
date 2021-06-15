install.packages("tm")
library(tm)
install.packages("stringr")
library(stringr)
install.packages("ggplot2")
library(ggplot2)
install.packages("wordcloud")
library(wordcloud)
install.packages("dplyr")
library(dplyr)

anthem <- anthems[91:134,5]
anthem <- tolower(trimws(anthem))
anthem <- removeWords(anthem, stopwords())
anthem <- removePunctuation(anthem)
anthem <- removeWords(anthem, c("may","thee","thou","thy",
                                "say","ever","every","across",
                                "another","many","will","cut","always",
                                "avoid","one","make","let","shall"))


corpus <- Corpus(VectorSource(anthem))
dtm <- as.matrix(DocumentTermMatrix(corpus))

freq <- colSums(dtm)
freq <- as.data.frame(sort(freq, decreasing = TRUE))
data3 <- freq
data3 <- tibble::rownames_to_column(data3,"word")
colnames(data3) <- c("word","count")

ggplot(head(data3), aes(x=word, y=count))+ geom_bar(stat = "identity")+ coord_flip()
 

wordcloud(data3$word, data3$count, random.order = FALSE, max_words=10, colors = brewer.pal(9, "Spectral"))
