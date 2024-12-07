L'enonce de ce projet est contenu dans le fichier ***PROJET 2 BD Avancees Master 1 UPAC-2023**

########################################################################################################33

Pour la réalisation de ce model en plsql, nous avons créé un **triggers** qui va permettre qu'après chaque occupation d’une chambre (insertion dans la table tOccupation), la table **tLoyer** 
sera mise à jour de tel sorte que si une chambre est occupée pour la première fois, un nouveau tuple sera insérer dans la table (qui contient la chambre, le client et la date d’occupation).
Si par contre la chambre a déjà été occupée dans la même journée et qu’une nouvelle occupation de la chambre est effectuée pendant cette même journée le montant du loyer de la chambre de cette journée 
sera mise à jour. 
Cette table **loyer** nous permettra de stocker les loyers d’une chambre chaque jour de l’année et par la suite de calculer le chiffre d’affaire de l’hôtel qui contient les chambres. 
