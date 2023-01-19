import psycopg2
from pprint import pprint

# Modify to match database
con = psycopg2.connect(database="sms", user="postgres", password="272202")
cur = con.cursor()


def main():
    load_sql("scripts/sms-create.sql")
    load_csv("data/faculty.csv", "faculty")
    load_csv("data/program.csv", "program")
    show_tab("faculty")
    show_tab("program")
    cur.close()
    con.close()


def load_sql(path):
    with open(path, "r", encoding="utf-8") as f:
        cur.execute(f.read())
        con.commit()


def load_csv(path, table):
    with open(path, "r", encoding="utf-8") as f:
        cur.copy_from(f, table, sep=",")
        con.commit()


def show_tab(table):
    cur.execute(f"SELECT * FROM {table};")
    pprint(cur.fetchall())


if __name__ == '__main__':
    main()
