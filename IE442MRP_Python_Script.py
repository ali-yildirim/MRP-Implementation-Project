import mysql.connector
import streamlit as st
import pandas as pd

connection = mysql.connector.connect(
    host="localhost",  
    user="root",  
    password="ie442project",  
    database="data_base" 
)

cursor = connection.cursor()

with open(r"C:\Users\aliky\OneDrive\Masaüstü\schema_construction.sql", 'r') as file:
    sql_script = file.read()
    for result in cursor.execute(sql_script, multi=True):
        print(result)


period = st.number_input("Enter Period Number", min_value=1, max_value=12)
demand = st.number_input("Enter Gross Requirements (Demand)", min_value=0)
cursor.execute("SELECT DISTINCT item_id FROM master_schedule")
item_ids = [row[0] for row in cursor.fetchall()]
item_id = st.selectbox("Select Item ID", options=item_ids)  

update_sql = """
UPDATE master_schedule AS ms
SET ms.gross_requirements = %s
WHERE ms.period_number = %s
AND ms.item_id = %s;
"""

if st.button("Run MRP Algorithm"):
    cursor.execute(update_sql, (demand, period, item_id))
    connection.commit()
    st.success(f"MRP Algorithm has been successfully implemented for Item:{item_id}, Demand:{demand}, Period:{period}.")

with open(r"C:\Users\aliky\OneDrive\Masaüstü\all procedures and functions - python.sql", 'r') as file:
    sql_script = file.read()
    for result in cursor.execute(sql_script, multi=True):
        print(result)

with open(r"C:\Users\aliky\OneDrive\Masaüstü\UpdateMRPTables.sql", 'r') as file:
    sql_script = file.read()
    for result in cursor.execute(sql_script, multi=True):
        print(result)

select_sql = "SELECT * FROM master_schedule"
cursor.execute(select_sql)

columns = [desc[0] for desc in cursor.description]

results = cursor.fetchall()
df = pd.DataFrame(results, columns=columns)
connection.commit()
cursor.close()
connection.close()

item_ids = df['item_id'].unique()  
dfs = {}

for item_id in item_ids:
    item_df = df[df['item_id'] == item_id]
    item_df_transposed = item_df.transpose()
    dfs[item_id] = item_df_transposed

st.title('MRP Algorithm Output')

for item_id, transposed_data in dfs.items():
    st.subheader(f"Table for item_id: {item_id}")
    st.write(transposed_data) 
