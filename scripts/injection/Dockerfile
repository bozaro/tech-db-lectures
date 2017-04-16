FROM ubuntu:16.04

MAINTAINER Artem V. Navrotskiy

# Обвновление списка пакетов
RUN apt-get -y update

#
# Установка LAMP
#
ENV PGVER 9.5
RUN apt-get install -y libapache2-mod-php apache2 php-pgsql

#
# Установка postgresql
#
ENV PGVER 9.5
RUN apt-get install -y postgresql-$PGVER

# Run the rest of the commands as the ``postgres`` user created by the ``postgres-$PGVER`` package when it was ``apt-get installed``
USER postgres

# Create a PostgreSQL role named ``docker`` with ``docker`` as the password and
# then create a database `docker` owned by the ``docker`` role.
RUN /etc/init.d/postgresql start &&\
    psql --command "CREATE USER docker WITH SUPERUSER PASSWORD 'docker';" &&\
    createdb -O docker docker &&\
    /etc/init.d/postgresql stop

# Adjust PostgreSQL configuration so that remote connections to the
# database are possible.
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/$PGVER/main/pg_hba.conf

# And add ``listen_addresses`` to ``/etc/postgresql/$PGVER/main/postgresql.conf``
RUN echo "listen_addresses='*'" >> /etc/postgresql/$PGVER/main/postgresql.conf

# Expose the PostgreSQL port
EXPOSE 5432

# Create sample database
ADD scheme.sql /tmp/scheme.sql
RUN /etc/init.d/postgresql start &&\
    psql docker < /tmp/scheme.sql &&\
    /etc/init.d/postgresql stop

# Add VOLUMEs to allow backup of config, logs and databases
VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

# Back to the root user
USER root

# Объявлем порт сервера
EXPOSE 80

# Php configuration
ADD 99-injection.ini /etc/php/7.0/apache2/conf.d/

# Create sample page
ADD news.php /var/www/html/

#
# Запускаем PostgreSQL и сервер
#
CMD service postgresql start && /usr/sbin/apache2ctl -D FOREGROUND
