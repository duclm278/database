alter table class
add constraint fk_class_class foreign key (company_id) references class(id);

alter table class
add constraint fk_class_subject foreign key (subject_id) references subject(id);

alter table class
add constraint fk_class_lecturer foreign key (lecturer_id) references lecturer(id);

alter table curriculum
add constraint fk_curriculum_subject foreign key (subject_id) references subject(id);

alter table curriculum
add constraint fk_curriculum_program foreign key (program_id) references program(id);

alter table enrollment
add constraint fk_enrollment_student foreign key (student_id) references student(id);

alter table enrollment
add constraint fk_enrollment_class foreign key (class_id) references class(id);

alter table lecturer
add constraint fk_lecturer_faculty foreign key (faculty_id) references faculty(id);

alter table program
add constraint fk_program_faculty foreign key (faculty_id) references faculty(id);

alter table specialization
add constraint fk_specialization_lecturer foreign key (lecturer_id) references lecturer(id);

alter table specialization
add constraint fk_specialization_subject foreign key (subject_id) references subject(id);

alter table student
add constraint fk_student_program foreign key (program_id) references program(id);

alter table subject
add constraint fk_subject_faculty foreign key (faculty_id) references faculty(id);

alter table subject
add constraint fk_subject_subject foreign key (prerequisite_id) references subject(id);
