FROM mysql:5.7

# Add a database
ENV MYSQL_DATABASE titanicNew

# Add the create.sql to the docker image
# All scripts in docker-entrypoint-initdb.d/ are automatically
# executed during container startup
COPY CreateTable.sql /docker-entrypoint-initdb.d/

# Copy the csv file to /var/lib/mysql-files/ 
COPY titanic.csv /var/lib/mysql-files/

