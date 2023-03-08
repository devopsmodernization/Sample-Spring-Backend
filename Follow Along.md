# Notes for the Video 
video source : https://www.youtube.com/watch?v=O_XL9oQ1_To

## Package structure :
- com.schrodingdong.SpringReactTutorial
  - controller
    - Mapping the methods
  - model
    - used for creating the entities
  - repository
    - For JPA implementation
  - service
---
## Following Steps
### Writing the model 
we created the model at first
````java
@Entity
public class Student {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private int id;
  private String name;
  private String address;

  public Student() {
  }
  // getters setters ...
}
````
- The `@Entity` Annotation
  - Where : In the JPA
  - What : Just POJOs representing the DATA in a database
- The `@Id` Annotation
  - Where : In the JPA
  - What : Specifying the varibale representing the PRIMARY KEY
- The `@GeneratedValue` Annotation
  - Where : In the JPA
  - What : How that id will be generated, could be either : AUTO, TABLE, SEQUENCE, or IDENTITY

### Writing the Repository
we jsut have to extend the interface :
```java
@Repository
public interface StudentRepository extends JpaRepository<Student, Integer> {
}
```
- The `@Repository` Annotation
  - Where : In the Spring
  - What : Specifies that this will be the mecanism for the CRUD operation

### Connect to DB
we use the the application.properties, we will change the extension to yaml for better viewing ig lmao 
```yaml
spring:
  jpa:
    hibernate:
      ddl-auto: update
  datasource:
    url: jdbc:postgresql://localhost:5432/SpringReactTest
    username: postgres
    password: admin
    driver-class-name: org.postgresql.Driver
```
- `ddl-auto`
  - what : it changes the database / schemas depending on the models you defined. 
  - [what are the possible values ?](https://stackoverflow.com/questions/438146/what-are-the-possible-values-of-the-hibernate-hbm2ddl-auto-configuration-and-wha)
  - the value we have `update` updates the schema
  - for production nkhliw update ?? You are basically doing the DB updates automaticaly, which could cause some problems
  - Once we run the spring, a new student table is created !
  - [What about in production env ?](https://stackoverflow.com/questions/221379/hibernate-hbm2ddl-auto-update-in-production)

### Communicating with the DB
The communication is delegated to the `JpaRepository` implementation that Spring has (so we wont have to go low level for DB interaction).

`StudentService` will hold all the methods that we will write, using the implemented methods of that said already implemented `JpaRepository`
```java
public interface StudentService {
    public Student saveStudent(Student student);
    public List<Student> getAllStudents();
}
```
Then we implement them !
```java

@Service
public class StudentServiceImplementation implements StudentService{
    @Autowired
    private StudentRepository studentRepository;

    @Override
    public Student saveStudent(Student student) {
        return studentRepository.save(student);
    }

    @Override
    public List<Student> getAllStudents() {
        return studentRepository.findAll();
    }
}
```
Here the `save()` && `findAll()` are implemented by spring. These methods are what makes the communication with the DB possible.
We will then just have to use the name of the methods `saveStudent()` && `getAllStudents()` we implemented.
- The `@Service` Annotation
  - Where : In the Spring
  - What : Specifies that this is a service component


### Controller
The controller will handle all the incoming request/response interaction
```java
@RestController
@RequestMapping("/student")
public class StudentController {
    @Autowired
    private StudentService studentService;
    // methods ...
}
```
- The `@RestController` Annotation
  - Where : In the Spring
  - What : Specifies that this controller is of type REST
- The `@RequestMapping` Annotation
  - Where : In the Spring
  - What : Maps requests to controllers (like that each method is assigned to uri `/student/*`)
- The `@Autowired` Annotation
  - Where : In the Spring
  - What : Used for Dependency injection of Valid Spring Beans

For each endpoint, 



We will have a POST method and a GET method :
```java
@PostMapping("/add")
public String add(@RequestBody Student student){
    studentService.saveStudent(student);
    return "new Student is added !!";
}

@GetMapping("/get-all")
public List<Student> getAllStudents(){
    return studentService.getAllStudents();
}
```
---
## FRONT END
React time !

