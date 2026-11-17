package com.example.multiapp;
import org.springframework.web.bind.annotation.*;
import java.util.*;
@RestController
@RequestMapping("/students")
public class StudentController 
{
    private final StudentRepository repo;
    public StudentController(StudentRepository repo)
    {
        this.repo=repo;
    }
    @PostMapping
    public Student add(@RequestBody Student s)
    {
        return repo.save(s);
    }
    @GetMapping
    public List<Student> get()
    {	
        return repo.findAll();
    }
    @DeleteMapping("/{id}")
    public void delete(@PathVariable int id)
    {
        repo.deleteById(id);
    }
}