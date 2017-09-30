import mysql.connector

cnx = mysql.connector.connect(user='root', password='zadmin1',
                              host='127.0.0.1',
                              database='db_churn')

cursor = cnx.cursor()
query = ("select distinct(state) from tab_churn;")
cursor.execute(query)

i = 0
for state in cursor:
	i = i + 1
	f1 = str(i) +">>"+str(state)
	print (f1)

cursor.close()

cnx.close()