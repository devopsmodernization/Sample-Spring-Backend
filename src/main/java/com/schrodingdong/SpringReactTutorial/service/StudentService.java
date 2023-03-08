package com.schrodingdong.SpringReactTutorial.service;

import com.schrodingdong.SpringReactTutorial.model.Student;

import java.util.List;

public interface StudentService {
    public Student saveStudent(Student student);
    public List<Student> getAllStudents();
}
