Salon Manager
=============

by Mike Goren

Salon Manager is a simple web app that uses a database and Sinatra. Salon owners can use this app to manage stylists and their clients.

Installation
------------

Install Salon Manager by first cloning the repository.  
```
$ git clone http://github.com/mgoren/salon_manager.git
```

Install all of the required gems:
```
$ bundle install
```

Start the database:
```
$ postgres
```

Create the databases and tables by running the following:
```
$ ruby database_create.rb
```

Start the webserver:
```
$ ruby app.rb
```

In your web browser, go to http://localhost:4567

License
-------

GNU GPL v2. Copyright 2015 Mike Goren


Database Info:
--------------

In case the database_create script does not work, here is the database info:

database name: salon

table: stylists (columns: id serial PRIMARY KEY, name varchar)

table: clients (columns: id serial PRIMARY KEY, name varchar, stylist_id int)
