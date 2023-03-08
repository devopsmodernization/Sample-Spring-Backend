package com.schrodingdong.SpringReactTutorial.controller;

import com.schrodingdong.SpringReactTutorial.model.Student;
import com.schrodingdong.SpringReactTutorial.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/student")
@CrossOrigin
public class StudentController {
    @Autowired
    private StudentService studentService;

    @PostMapping("/add")
    public String add(@RequestBody Student student){
        studentService.saveStudent(student);
        return "new Student is added !!";
    }

    @GetMapping("/get-all")
    public List<Student> getAllStudents(){
        return studentService.getAllStudents();
    }

}
