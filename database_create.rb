require('pg')

DB = PG.connect({:dbname => "mgoren"})

db_name = "salon"
db_name_test = (db_name + "_test")
###############################################


table1_name = "stylists"
table1_column1 = "name"
table1_column1_type = "varchar"

table2_name = "clients"
table2_column1 = "name"
table2_column1_type = "varchar"
table2_column2 = "stylist_id"
table2_column2_type = "int"


DB.exec("CREATE DATABASE #{db_name};")

#disconnect from Guest database and connect to our new one
DB2 = PG.connect({:dbname => db_name})
DB2.exec("CREATE TABLE #{table1_name} (id serial PRIMARY KEY, #{table1_column1} #{table1_column1_type});")
DB2.exec("CREATE TABLE #{table2_name} (id serial PRIMARY KEY, #{table2_column1} #{table2_column1_type}, #{table2_column2} #{table2_column2_type});")

#create our test database
DB2.exec("CREATE DATABASE #{db_name_test} WITH TEMPLATE #{db_name};")

###############################################

#or comment out all between the two lines of pound signs above, and delete some databases
# DB.exec("DROP DATABASE #{db_name};")
# DB.exec("DROP DATABASE #{db_name_test};")


# <3 Dan 2015 danwright.co
