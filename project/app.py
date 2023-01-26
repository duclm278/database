import psycopg2
import random
from faker import Faker
from pprint import pprint
from psycopg2.extras import execute_values

# Settings
conn = psycopg2.connect(database="sms", user="postgres", password="272202")
curs = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
fake = Faker()


def main():
    exec_file("scripts/sms-create.sql")
    import_data("data/faculty.csv", "faculty")
    import_data("data/program.csv", "program")
    import_data("data/subject.tsv", "subject", sep="\t")
    import_data("data/class-20221.tsv", "class", sep="\t")
    insert_lecturers()
    insert_specialization()
    assign_lecturers()
    insert_curriculums()
    insert_students()
    insert_enrollments()
    # select_table("specialization")
    curs.close()
    conn.close()


def exec_file(path):
    with open(path, "r", encoding="utf-8") as f:
        curs.execute(f.read())
        conn.commit()


def import_data(path, table, sep=",", null="NULL"):
    with open(path, "r", encoding="utf-8") as f:
        curs.copy_from(f, table, sep=sep, null=null)
        conn.commit()


def select_table(table):
    curs.execute(f"SELECT * FROM {table}")
    pprint(curs.fetchall())


def insert_table(table, rows):
    columns = rows[0].keys()
    query = f"INSERT INTO {table} ({', '.join(columns)}) VALUES %s"
    values = [[value for value in row.values()] for row in rows]
    execute_values(curs, query, values)
    conn.commit()


def insert_lecturers():
    rows = []
    curs.execute(f"SELECT * FROM faculty")
    faculties = curs.fetchall()
    for faculty in faculties:
        for i in range(0, 100):
            rows.append({
                "id": fake.pystr(min_chars=12, max_chars=12),
                "first_name": fake.first_name(),
                "last_name": fake.last_name(),
                "gender": fake.random_element(elements=("M", "F")),
                "birthday": fake.date_of_birth(minimum_age=35, maximum_age=70),
                "status": fake.random_element(elements=(True, False)),
                "join_date": fake.date_between(start_date="-25y", end_date="today"),
                "address": fake.address(),
                "email": fake.email(),
                "phone": fake.phone_number(),
                "faculty_id": faculty["id"]
            })

    insert_table("lecturer", rows)


def insert_specialization():
    curs.execute(f"SELECT * FROM faculty")
    faculties = curs.fetchall()
    for faculty in faculties:
        # List of subjects of given faculty
        curs.execute(
            f"SELECT * FROM subject WHERE faculty_id = '{faculty['id']}'")
        subjects = [item['id'] for item in curs.fetchall()]

        # List of lecturers of given faculty
        curs.execute(
            f"SELECT * FROM lecturer WHERE faculty_id = '{faculty['id']}'")
        lecturers = [item['id'] for item in curs.fetchall()]
        assigned_lecturers = dict.fromkeys(lecturers, 0)

        # Assign 3 lecturers for each subject
        for i, subject in enumerate(subjects):
            # Sample 3 lecturers for specialization
            try:
                specialization = random.sample(lecturers, 3)
            # Assign all lecturers if len(lecturers) < 3
            except:
                specialization = lecturers

            for lecturer in specialization:
                curs.execute(
                    f"INSERT INTO specialization (lecturer_id, subject_id) VALUES ('{lecturer}', '{subject}')")
                conn.commit()

                # Assign each lecturer to maximum 3 subjects
                assigned_lecturers[lecturer] += 1
                if assigned_lecturers[lecturer] == 3:
                    # Remove lecturer if limit reached
                    lecturers.remove(lecturer)
                    assigned_lecturers.pop(lecturer)

                # TODO: Log output
                print(
                    f"{len(subjects) - i - 1} subjects left, {len(lecturers)} lecturers left")
                curs.execute(
                    f"SELECT * FROM specialization WHERE lecturer_id = '{lecturer}'")
                print(curs.fetchall())


def assign_lecturers():
    return None


def insert_curriculums():
    return None


def insert_students():
    return None


def insert_enrollments():
    return None


if __name__ == '__main__':
    main()
