# Analyse et Classification des Vins Italiens (Wine Dataset)

![R](https://img.shields.io/badge/Language-R-blue.svg)
![FactoMineR](https://img.shields.io/badge/Library-FactoMineR-orange.svg)

Ce projet, réalisé dans le cadre du cours de **Traitement Numérique des Données (TND)**, porte sur l'analyse physico-chimique de 178 vins issus de trois cépages différents cultivés en Italie.

## 🎯 Objectifs
L'enjeu est de démontrer comment des méthodes statistiques exploratoires permettent de retrouver la structure naturelle des données (les cépages) sans utiliser d'algorithme d'apprentissage supervisé.

## 📂 Arborescence du Projet
Voici l'organisation actuelle du dépôt :

```text
/Projet_Wine_TND
├── data/                  # Données brutes et documentation
│   ├── wine.data          # Jeu de données (178 individus, 13 variables)
│   └── wine.names         # Description des variables et métadonnées
├── R/                     # Scripts de traitement et d'analyse
│   ├── 01_exploration.R   # Nettoyage, statistiques descriptives et boxplots
│   ├── 02_acp.R           # Analyse en Composantes Principales (FactoMineR)
│   └── 03_clustering.R    # Classification ascendante hiérarchique (HCPC)
└── img/                   # Dossier destiné aux graphiques (PNG/PDF)