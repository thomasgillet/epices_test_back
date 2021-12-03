# Sujet

Une installation photovoltaïque dispose d'un appareil appelé "datalogger" qui nous transmet chaque jour des données sur la production de la veille.

Cette installation photovoltaïque est composée de 2 onduleurs.

Les données sont transmises en format CSV. Elles contiennent la production horaire de chaque onduleur. *(cf fichiers de production en pièces jointes)*

Le but de l'application est, à partir des fichiers de production, de disposer dans la base de données :

- des données horaires de chaque onduleur
- des données consolidées (somme des énergies) sur la journée pour l'ensemble du système

Une interface web simple (pas de mise en forme CSS demandée) qui permet :

- d'envoyer un fichier CSV à charger
- de voir la production totale d'une journée (au choix de l'utilisateur) pour l'ensemble du système avec le total et la production par heure

# Nous observerons

- Les modèles créés et leurs relations,
- L'algorithme d'import,
- La qualité et l'organisation du code en général.

**Contrainte :** Utiliser RubyOnRails comme framework web.

**Mettre le code à disposition sur un dépôt git et nous transmettre les moyens d'y accéder.**
