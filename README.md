# Payroll Project

## Prerequisites
- setup docker environment [setup link](https://docs.docker.com/get-docker/)

## Database Diagram
![Payroll](https://user-images.githubusercontent.com/13538182/117767251-aef47d00-b1fe-11eb-9331-019f73cca522.png)

## Installation Instructions
- Please don't occupy port 5432 in the local, i.e. having another postgresql server in the local

```sh
docker-compose up --build
```

## Endpoints
- everything is deployed in the local
- frontend: localhost:3000 
- backend: localhost:4000
- database: localhost:5432
