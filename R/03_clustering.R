#Chargement des données
data <- read.csv("../data/wine.data",header = TRUE)

#Ajout des noms des colonnes 
colnames(data) <- c("Wine", "Alcohol","Malic Acid","Ash","Alcalinity of ash","Magnesium","Total phenols","Flavanoids","Nonflavanoid phenols","Proanthocyanis","Color intensity","Hue","OD280/OD315 of diluted wines","Proline");

#Vue globale du jeu de données
#summary(data)




# Chargement du package
library(cluster)

# 1. On enlève la colonne "Wine" pour le clustering
data_num <- data[, -1] 

# 2. Réalisation de la CAH sur les variables chimiques uniquement
cah_wine <- agnes(scale(data_num), method = "ward")

# 3. Affichage du dendrogramme (sans les textes en bas)
plot(as.hclust(cah_wine), 
     labels = FALSE,        # <- C'est ça qui enlève le texte illisible !
     xlab = "Vins", 
     ylab = "Hauteur de coupe", 
     sub = "",              # Enlève le sous-titre automatique moche
     main = "Dendrogramme des vins italiens")

# 4. Dessiner les rectangles
rect.hclust(cah_wine, k = 3, border = "red")

#install.packages("factoextra", repos = "https://cloud.r-project.org/")# Installe le package si tu ne l'as pas déjà : install.packages("factoextra")
#library(factoextra)

## 1. On crée le graphique horizontal classique
#dendro_large <- fviz_dend(cah_wine, 
#          k = 3, 
#          show_labels = FALSE, 
#          rect = TRUE, 
#          rect_border = c("#2E9FDF", "#00AFBB", "#E7B800"),
#          rect_fill = TRUE,
#          lwd = 0.3,         
#          main = "Dendrogramme des Vins",
#          ggtheme = theme_minimal())
#
## 2. On l'exporte avec une largeur importante
## On passe à 15 pouces de large pour seulement 7 de haut
#ggsave(filename = "../img/03_dendro_large.png", 
#       plot = dendro_large, 
#       width = 25,                   # Très large
#       height = 14, 
#       units = "in", 
#       dpi = 300)

library(FactoMineR) # Indispensable pour la fonction catdes()

# 1. Couper l'arbre pour obtenir l'appartenance de chaque vin aux 3 clusters (TP6 Q6)
mes_clusters <- cutree(cah_wine, k = 3)

# 2. Ajouter ces clusters comme une nouvelle colonne dans le jeu de données (TP6 Q7)
# On convertit en "factor" (qualitatif) pour que catdes comprenne que ce sont des catégories
data$Cluster_CAH <- as.factor(mes_clusters)

# 3. Lancer catdes() sur cette nouvelle colonne (TP6 Q8)
# num.var indique à R quelle colonne analyser. ncol(data) cible automatiquement la dernière colonne (celle qu'on vient de créer).
description_clusters <- catdes(data, num.var = ncol(data))

# 4. Afficher les résultats (les variables chimiques qui caractérisent chaque groupe)
#description_clusters$quanti


# 1. Création du tableau croisé avec des noms clairs pour les axes
matrice_confusion <- table("Vrai Cépage" = data$Wine, "Cluster Trouvé" = data$Cluster_CAH)

# 2. Affichage simple dans la console pour que tu puisses l'analyser
print(matrice_confusion)

library(FactoMineR)
library(factoextra)

# 1. Faire l'ACP uniquement sur les variables chimiques (data_num)
res.pca <- PCA(data_num, scale.unit = TRUE, graph = FALSE)

# 2. Dessiner la carte factorielle colorée par tes clusters
carte_clusters <- fviz_pca_ind(res.pca,
             habillage = data$Cluster_CAH,     # <-- On colore en utilisant la colonne de 'data'
             palette = "jco",                  # Belles couleurs
             addEllipses = TRUE,               # Ajoute les zones de confiance
             ellipse.type = "convex",
             geom = "point",                   # Enlève les numéros illisibles
             title = "Carte factorielle des vins (Colorée par Clusters CAH)",
             ggtheme = theme_minimal())

# 3. Afficher et Sauvegarder
print(carte_clusters)
ggsave("../img/03_carte_factorielle_clusters.png", carte_clusters, width = 10, height = 7)