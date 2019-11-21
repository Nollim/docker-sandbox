Afficher l'id du conteneur sur le localhost sur le port 8000

    docker run -d -p 8000:8000 --name whoami -t jwilder/whoami
    
  
Mettre whoami dans un docker compose
    
Lancer le service 

    docker-compose -f ./config/docker/docker-compose-drupal.yml up -d
    
Arreter le service 

    docker-compose -f ./config/docker/docker-compose-drupal.yml down -v    
    
Tag    