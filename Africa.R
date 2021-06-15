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

anthem <- anthems[135:190,5]
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
data4 <- freq
data4 <- tibble::rownames_to_column(data4,"word")
colnames(data4) <- c("word","count")

ggplot(head(data4), aes(x=word, y=count))+ geom_bar(stat = "identity")+ coord_flip()
wordcloud(data4$word, data4$count, random.order = FALSE, max_words=25, colors = brewer.pal(9, "Spectral"))
