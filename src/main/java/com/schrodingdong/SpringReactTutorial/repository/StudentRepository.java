package com.schrodingdong.SpringReactTutorial.repository;

import com.schrodingdong.SpringReactTutorial.model.Student;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface StudentRepository extends JpaRepository<Student, Integer> {
}
