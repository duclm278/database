import psycopg2
from pprint import pprint

# Modify to match database
con = psycopg2.connect(database="sms", user="postgres", password="272202")
cur = con.cursor()


def main():
    exec_file("scripts/sms-create.sql")
    load_data("data/faculty.csv", "faculty")
    load_data("data/program.csv", "program")
    load_data("data/subject.tsv", "subject", sep="\t", null="NULL")
    select_table("subject")
    cur.close()
    con.close()


def exec_file(path):
    with open(path, "r", encoding="utf-8") as f:
        cur.execute(f.read())
        con.commit()


def load_data(path, table, sep=",", null="NULL"):
    with open(path, "r", encoding="utf-8") as f:
        cur.copy_from(f, table, sep=sep, null=null)
        con.commit()


def select_table(table):
    cur.execute(f"SELECT * FROM {table};")
    pprint(cur.fetchall())


if __name__ == '__main__':
    main()
