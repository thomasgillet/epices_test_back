# Réponse au test pour Epices Energie

N'ayant aucune notion de Ruby ni de Rails, je suis parti du [Getting started](https://guides.rubyonrails.org/getting_started.html) de Rails.

Développement sous Windows, Ruby 3.0.3 et Rails 6.1.4, avec une base de dev SQLite.

J'ai laissé mon fichier TODO que je suis bien loin d'avoir pu terminer.

## Modèle

Par réflexe, je suis parti sur un modèle "table de faits" + "table consolidée" (ou "cube"),
du fait de mon habitude de travailler avec :
- des données peu fiables, au format sujet à modifications ou différents pour chaque sous-système source
- des cubes qui gagnent avec le temps de nouvelles valeurs et/ou dimensions (ici on peut imaginer une consolidation par semaine ou mois ou année, ou bien par source)

Le cube est alors une simple optimisation technique et ne fait pas vraiment parti du modèle.

En relisant le sujet, et vu que les données sont très propres, peut-être qu'un modèle plus classique
aurait tout aussi bien fait l'affaire.

Par exemple deux entités `DailySlice` et `HourlySlice`, liées par une relation one-to-many.
Moins flexible, mais plus clair, et plus adapté aux conventions de Rails (il semble, mais je découvre encore).

En revanche petite attention à porter à la consolidation, il y aura probablement des contraintes de clé étrangère à différer avant insertion et consolidation, sous réserve que la DB le supporte (mais pas de problème si Postgres).

## Style

Oui, ce n'était pas demandé, mais j'ai pas pu m'empêcher.
C'est toujours plus rigolo avec du CSS :)
