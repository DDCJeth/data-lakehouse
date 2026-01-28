# Deployment

- **iceberg-rest** est le catalogue qui represente le coeur du moteur Iceberg. Il utilise une base de données In-Memory
- **Minio** est le stockage objet ou est stocké les données et métadonnées des tables Iceberg


```
docker compose up -d
```

# Getting started

You can also use the notebook server available at 
- http://localhost:8888


# Obsersations
La configuration avec deux catalogues ne fonctionne pas pour la même instance Minio




# Links
https://www.dremio.com/blog/intro-to-dremio-nessie-and-apache-iceberg-on-your-laptop/
