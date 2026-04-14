#Chargement des données
data <- read.csv("wine.data",header = TRUE)

#Ajout des noms des colonnes 
colnames(data) <- c("Wine", "Alcohol","Malic Acid","Ash","Alcalinity of ash","Magnesium","Total phenols","Flavanoids","Nonflavanoid phenols","Proanthocyanis","Color intensity","Hue","OD280/OD315 of diluted wines","Proline");

#Vue globale du jeu de données
summary(data)
str(data)
dim(data)

#Conversion de la col wine en variable qualitative 
data$Wine <- factor(data$Wine)

#Vue globale des variables par type de vin 
table(data$Wine)
prop.table(table(data$Wine)) * 100

#--------------------------------------------------
#Analyse univariée : variables quantitatives
#--------------------------------------------------

#On enleve la 1ere colonne car variable qualitative
data_num <- data[,-1]

#Analyse de chaque variable
stats_uni <- data.frame(
  Variable = names(data_num),
  Moyenne = sapply(data_num, mean),
  Mediane = sapply(data_num, median),
  Ecart_type = sapply(data_num, sd),
  Minimum = sapply(data_num, min),
  Q1 = sapply(data_num, quantile, probs = 0.25),
  Q3 = sapply(data_num, quantile, probs = 0.75),
  Maximum = sapply(data_num, max)
)

stats_uni$IQR <- stats_uni$Q3 - stats_uni$Q1
stats_uni$CV <- stats_uni$Ecart_type / stats_uni$Moyenne

#Affichage des histogrammes / Box plot
par(mfrow = c(4, 4), mar = c(3, 3, 2, 1))

for (v in names(data_num)) {
  hist(data_num[[v]],
       main = paste("Histogramme de", v),
       xlab = v,
       col = "skyblue",
       border = "white")
}

box <- boxplot(scale(data_num),
         main = "Boxplots des variables standardisées",
         col = "#FFF8DC",
         las = 2) 

#--------------------------------------------------
#Analyse univariée : variable quantitative (Wine)
#--------------------------------------------------

barplot(table(data$Wine),
        main = "Répartition des classes de vin",
        xlab = "Classe de vin",
        ylab = "Effectif",
        col = "lightgreen")


#--------------------------------------------------
#Analyse bivariée 
#--------------------------------------------------

#Boxplot par classe
par(mfrow = c(1,1))

for (v in names(data_num)) {
  boxplot(data[[v]] ~ data$Wine,
          main = paste(v, "selon Wine"),
          xlab = "Classe de vin",
          ylab = v,
          col = c("lightblue", "lightgreen", "lightpink"))
}

par(mfrow = c(1, 1))

#Calcule des moyennes par type de wine
aggregate(. ~ Wine, data = data[, c("Wine", names(data_num))], mean)

#Calcule des medianes par type de wine
aggregate(. ~ Wine, data = data[, c("Wine", names(data_num))], median)


#Intallastion de corrplot
install.packages("corrplot")
library(corrplot)

#Matrice de corrélation entre les variables qunatitatives

corrplot(mat_corr, method = "color", type = "upper",tl.col = "black", tl.srt = 45)

