# for this example


require('pg')

DB_tmp = PG.connect({:dbname => "postgres"}) # change postgres to your default db name if postgres does not exist

db_name = "salon"
db_name_test = (db_name + "_test")

table1_name = "stylists"
table1_column1 = "name"
table1_column1_type = "varchar"

table2_name = "clients"
table2_column1 = "name"
table2_column1_type = "varchar"
table2_column2 = "stylist_id"
table2_column2_type = "int"

DB_tmp.exec("CREATE DATABASE #{db_name};")

DB = PG.connect({:dbname => db_name})
DB.exec("CREATE TABLE #{table1_name} (id serial PRIMARY KEY, #{table1_column1} #{table1_column1_type});")
DB.exec("CREATE TABLE #{table2_name} (id serial PRIMARY KEY, #{table2_column1} #{table2_column1_type}, #{table2_column2} #{table2_column2_type});")

DB.exec("CREATE DATABASE #{db_name_test} WITH TEMPLATE #{db_name};")

# script by Dan Wright, with modificationsby Mike Goren
# original script: https://github.com/dwright213/setter_upper
