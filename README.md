# pFp - Python, Flask, PostgreSQL
- Python, Flask, PostgreSQL in a Docker Development environment

## Prerequisites
- Install and run Docker Desktop
  - [https://www.docker.com/get-started ](https://www.docker.com/get-started)

## Run Docker images
On the command line (the terminal)
- Clone this repository where you want it.
  - `git clone `
- Change into the directory
- `cd pfp`
- Change the PostgreSQL account info in the `docker-compose.yml` file if you want
 
  ```
      POSTGRES_DB: "dbase"
      POSTGRES_USER: "dbuser"
      POSTGRES_PASSWORD: "dbpass"
      PGDATA: "/var/lib/postgresql/data"
  ```

- The first time you run this, you will need to create a new docker network
  - `docker network create traefikNetwork`
- Start the container
  - `docker-compose up`
  - Or run it in the background to free up the terminal
    - `docker-compose up -d`
- To stop the containers
  - press ctrl-c
  - then run `docker-compose down`
- View the web pages at [http://lvh.me ](http://lvh.me) or
  [http://pfp.lvh.me ](http://pfp.lvh.me)
  - You can also edit the /etc/hosts file to allow for using existing domain
    names. For example, add `127.0.0.1 example.com` to your /etc/hosts file
    ([Linux or Mac](https://www.makeuseof.com/tag/modify-manage-hosts-file-linux/)), or c:\windows\system32\drivers\etc\hosts ([Windows](https://www.howtogeek.com/howto/27350/beginner-geek-how-to-edit-your-hosts-file/)). Now you can browse to [http://example.com ](http://example.com).
- View pgAdmin at [http://pga.lvh.me ](http://pga.lvh.me)
  - After start up, log into pgAdmin with credentials: 
    - username: dbuser@pgadmin.com
    - password: dbpass
    - This can be changed in the docker-compose.yml file
      ```
        PGADMIN_DEFAULT_EMAIL: "dbuser@pgadmin.com"
        PGADMIN_DEFAULT_PASSWORD: "dbpass"
      ```
  - Select the 'Add New Server' button.
  - Fill out the field for 'Name'.
  - Select the 'Connection' tab, and fill out 'Host' with `postgres`, 'Password' with
    `dbpass`, and check the 'Save Password' box.
  - Click the 'Save' button
  - The `dbase` database is now available.
  - type in the db user name and db password to log in

## Database Connection
- Connect to the PostgreSQL database with the following credentials:

  ```
    POSTGRES_DB: "dbase"
    POSTGRES_USER: "dbuser"
    POSTGRES_PASSWORD: "dbpass"
    url: "postgresql://dbuser:dbpass@postgres:5432/dbase"

  ```
  - The server/host/database url is 'postgres' which is the name of the PostgreSQL container. Because the Python/Flask and PostgreSQL are all in containers, they know to connect to each other through shortcut network names.

## General Notes 
- This will run four containers: a proxy container, a Python/Flask container, a PostgreSQL container and a pgAdmin container.
- All of the files for the website building can go in the `webapp` folder.
- The database files are stored in the `db-data` folder. This allows for the
  data to persist between restarts and for hands on access.
  - To restart with a clean database, just delete this folder.
  - To seed the database with a database, tables, and data, just uncomment the
    line in the docker-compose.yml file referencing `postgres_seed.sql`. The `db-data`
    folder will need to be deleted first. This works best if using a postgres dump
    file. Otherwise, the sql file just needs to have valid SQL statments.
    - `#- ./postgres_seed.sql:/docker-entrypoint-initdb.d/postgres_seed.sql`
- You can view the console output of any of the containers by using the
  command:
  - `docker logs -f <container name>`

## Traefik Notes
This uses the Traefik image from here: https://hub.docker.com/_/traefik/
- Documentation is here: https://doc.traefik.io/traefik/
- You can have multiple domains and subdomains pointing to a single container
using the Hosts line in the label section of docker-compose.yml
    - "traefik.http.routers.flask.rule=Host(`lvh.me`, `fun.lvh.me`, `realdomain.com`)"

## lvh.me Notes
lvh.me is a free service that redirects to localhost, so now you can access the
site at http://lvh.me instead of http://localhost




