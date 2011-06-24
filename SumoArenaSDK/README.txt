Version 0.1

Bugs connu :
- la réduction de la taille de l'arène entraine plusieurs bugs, ne pas l'utiliser pour l'instant 
Non implémenté :
- message d'acquittement de connexion
- gestion des rounds
- gestion de fin de partie

Pour tester :
- téléchargez le fichier SumoArena.air : c'est le jeu.   
- téléchargez le contenu du répertoire HumanSumoClient.

Après installation du fichier SumoArena.air, executez-le. Cette application vous permet :
- de lancer le serveur (il s'arrête quand on quitte SumoArena)
- de configurer le jeu
- de sélectionner les joueurs de la prochaine partie, parmi les clients connectés
- de lancer une partie
- de visualiser la partie en cours
 
L'onglet "help" contient quelques instructions sur son utilisation.

Dans HumanSumoClient, vous trouverez une page HTML qui permet de tester le jeu en simulant un client.

Utilisation : 
- dans le jeu, lancer le serveur sur le port 9090
- dans la page HTML (=le client), entrer un pseudo (ou garder celui qui est généré automatiquement)
- ouvrir la page HML dans un second onglet de votre navigateur pour connecter un second client
- dans le jeu, onglet "players", sélectionner les clients qui vont jouer
- dans controls, cliquer sur "start round"
- dans le client, cliquer sur le disque noir pour modifier la vitesse et la direction de votre sphère.
