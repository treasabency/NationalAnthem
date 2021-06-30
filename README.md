# NationalAnthem

Reference: medium.com/@lucasdesa/text-clustering-with-k-means-a039d84a941b

This project uses a dataset of national anthems from different countries around the world and groups them together based on the anthem's theme. 

Initially we clean the data and remove stopwords, country names, nationalities and other words that don't contribute to the anthem's semantic structure.
We also remove numbers, punctuations, URL's, 1 and 2 letter words. 

We next cluster the data by first creating a TD-IDF matrix with the words generated from each anthems, across the entire dataset. We then use this information 
to predict an appropriate k value for the k-means method using the elbow method. 
Then we implement the k-means algorithm for clustering the data using the k generated from the previous step. 

The clustered groups are then cross referenced with the top 10 words present in each anthem. The more words in a cluster, that specific anthems gets allocated
to that cluster. 

We then use the clustered information from the above steps to create an interactive world map on Tableau, which when hovering over the countries gives you the 
cluster number it is assigned to. 

Interactive map: public.tableau.com/app/profile/treasa.jose/viz/Anthems/Sheet1   
Online version using R markdown: https://rpubs.com/tb678/Anthems

