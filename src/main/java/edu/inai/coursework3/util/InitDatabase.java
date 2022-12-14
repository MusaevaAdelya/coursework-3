package edu.inai.coursework3.util;


import edu.inai.coursework3.entities.*;
import edu.inai.coursework3.enums.CourseStatus;
import edu.inai.coursework3.enums.UserRoles;
import edu.inai.coursework3.exceptions.CategoryNotFoundException;
import edu.inai.coursework3.exceptions.UserNotFoundException;
import edu.inai.coursework3.repositories.*;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

@Configuration
public class InitDatabase {
    private final PasswordEncoder passwordEncoder;
    private final static Random rnd=new Random();

    @Value(value="${avatar.path}")
    private String avatarPath;

    @Value(value="${courses.path}")
    private String coursesPath;

    @Value(value="${avatar.default.image}")
    private String defaultAvatar;

    @Value(value="${courses.default.image}")
    private String defaultCourseImage;

    public InitDatabase(PasswordEncoder passwordEncoder) {
        this.passwordEncoder = passwordEncoder;
    }

    @Bean
    CommandLineRunner init(UserRepository userRepository,
                           CategoryRepository categoryRepository,
                           CourseRepository courseRepository,
                           CourseTestRepository courseTestRepository,
                           CourseChapterRepository courseChapterRepository,
                           CourseSectionRepository courseSectionRepository) {
        return (args) -> {
            if (userRepository.findByEmail("msvadelya@gmail.com").isEmpty()) {
                User user1=User.builder()
                        .email("msvadelya@gmail.com")
                        .password(passwordEncoder.encode("12345678"))
                        .username("Adelya Musaeva")
                        .avatar(defaultAvatar)
                        .role(UserRoles.ADMIN)
                        .about("Hey")
                        .build();
                userRepository.save(user1);
            }
            if (userRepository.findByEmail("dylan.obrien@gmail.com").isEmpty()) {
                User user2=User.builder()
                        .email("dylan.obrien@gmail.com")
                        .password(passwordEncoder.encode("12345678"))
                        .username("Dylan O'Brien")
                        .avatar(defaultAvatar)
                        .about("I am handsome")
                        .build();
                userRepository.save(user2);
            }

            if (userRepository.findByEmail("ilya.ugai@gmail.com").isEmpty()) {
                User user3=User.builder()
                        .email("ilya.ugai@gmail.com")
                        .password(passwordEncoder.encode("12345678"))
                        .username("Ilya Ugai")
                        .avatar(defaultAvatar)
                        .about("I am Ilya. I can teach you UX/UI design")
                        .build();
                userRepository.save(user3);
            }

            List<Category> categories = categoryRepository.findAll();
            if (categories.size() == 0) {
                Category parent1=Category.builder()
                        .name("Programming")
                        .build();
                Category parent2=Category.builder()
                        .name("Design")
                        .build();
                Category child11=Category.builder()
                        .name("Back-end")
                        .parent(parent1)
                        .build();
                Category child12=Category.builder()
                        .name("Front-end")
                        .parent(parent1)
                        .build();
                Category child21=Category.builder()
                        .name("Motion-Design")
                        .parent(parent2)
                        .build();
                Category child22= Category.builder()
                        .name("UX/UI Design")
                        .parent(parent2)
                        .build();
                categories = List.of(parent1,parent2,child11,child12,child21,child22);

                categoryRepository.saveAll(categories);
            }

            List<Course> courses=courseRepository.findAll();
            List<CourseTest> tests=courseTestRepository.findAll();
            List<CourseChapter> chapters=courseChapterRepository.findAll();
            List<CourseSection> sections=courseSectionRepository.findAll();
            if(courses.size()==0 && tests.size()==0 && chapters.size()==0 && sections.size()==0){
                User teacher1= userRepository.findByEmail("ilya.ugai@gmail.com").orElseThrow(
                        ()-> new UserNotFoundException("ilya.ugai@gmail.com")
                );
                User teacher2=userRepository.findByEmail("msvadelya@gmail.com").orElseThrow(
                        ()-> new UserNotFoundException("msvadelya@gmail.com")
                );

                List<User> allUsers=userRepository.findAll();

                CourseTest courseTest= CourseTest.builder()
                        .question("What is your favorite TV series")
                        .answers(List.of(TestAnswer.builder()
                                        .text("Game Of Thrones")
                                        .correct(true)
                                        .build(),
                                TestAnswer.builder()
                                        .text("House Of The Dragon")
                                        .build(),
                                TestAnswer.builder()
                                        .text("Anne with an E")
                                        .build(),
                                TestAnswer.builder()
                                        .text("Wednesday Addams")
                                        .build()))
                        .build();


                CourseChapter courseChapter= CourseChapter.builder()
                        .title("Introduction")
                        .text("The lesson is over")
                        .imagePaths(List.of("/img/student1.jpg","/img/student2.jpg"))
                        .test(courseTest)
                        .build();


                CourseSection courseSection=CourseSection.builder()
                        .title("Module 1: Spring Boot Fundamentals")
                        .chapters(List.of(courseChapter))
                        .build();



                try{
                    courses=List.of(
                            Course.builder()
                                    .name("Spring Boot")
                                    .coins(100.0)
                                    .status(CourseStatus.ACCEPTED)
                                    .teacher(teacher2)
                                    .thumbNailPath(defaultCourseImage)
                                    .category(categoryRepository.findByName("Back-end").orElseThrow(()-> new CategoryNotFoundException("Back-end")))
                                    .users(allUsers)
                                    .ratingScore(5.0)
                                    .description("Become a Java Web Developer: MVC, REST API, OpenAPI Documentation, Testing, Spring Data JPA (SQL), Spring Security (JWT)")
                                    .requirements(List.of("Java","Object-Oriented Programming"))
                                    .skills(List.of("Launch an HTTP Server","Field Validation",
                                            "Unit Testing Business Logic.","REST API",
                                            "OpenAPI Documentation","Spring Security (Basic)","Model View Controller"))
                                    .courseSections(List.of(courseSection))
                                    .build(),
                            Course.builder()
                                    .name("Spring Security")
                                    .coins(100.0)
                                    .status(CourseStatus.ACCEPTED)
                                    .teacher(teacher2)
                                    .thumbNailPath(defaultCourseImage)
                                    .category(categoryRepository.findByName("Back-end").orElseThrow(()-> new CategoryNotFoundException("Back-end")))
                                    .users(allUsers)
                                    .ratingScore(4.7)
                                    .build(),
                            Course.builder()
                                    .name("Spring Data JPA")
                                    .coins(100.0)
                                    .status(CourseStatus.ACCEPTED)
                                    .teacher(teacher2)
                                    .thumbNailPath(defaultCourseImage)
                                    .category(categoryRepository.findByName("Back-end").orElseThrow(()-> new CategoryNotFoundException("Back-end")))
                                    .users(allUsers)
                                    .ratingScore(3.8)
                                    .build(),
                            Course.builder()
                                    .name("JDBC")
                                    .coins(100.0)
                                    .status(CourseStatus.ACCEPTED)
                                    .teacher(teacher2)
                                    .thumbNailPath(defaultCourseImage)
                                    .category(categoryRepository.findByName("Back-end").orElseThrow(()-> new CategoryNotFoundException("Back-end")))
                                    .users(allUsers)
                                    .ratingScore(5.0)
                                    .build(),
                            Course.builder()
                                    .name("Bootstrap 5")
                                    .coins(150.0)
                                    .status(CourseStatus.ACCEPTED)
                                    .teacher(teacher1)
                                    .thumbNailPath(defaultCourseImage)
                                    .category(categoryRepository.findByName("Front-end").orElseThrow(()-> new CategoryNotFoundException("Front-end")))
                                    .build(),
                            Course.builder()
                                    .name("Full HTML/CSS course")
                                    .coins(150.0)
                                    .status(CourseStatus.ACCEPTED)
                                    .teacher(teacher1)
                                    .thumbNailPath(defaultCourseImage)
                                    .category(categoryRepository.findByName("Front-end").orElseThrow(()-> new CategoryNotFoundException("Front-end")))
                                    .build(),
                            Course.builder()
                                    .name("Introduction to JavaScript")
                                    .coins(150.0)
                                    .status(CourseStatus.ACCEPTED)
                                    .teacher(teacher1)
                                    .thumbNailPath(defaultCourseImage)
                                    .category(categoryRepository.findByName("Front-end").orElseThrow(()-> new CategoryNotFoundException("Front-end")))
                                    .build(),
                            Course.builder()
                                    .name("UX/UI Design with Figma")
                                    .coins(150.0)
                                    .status(CourseStatus.ACCEPTED)
                                    .teacher(teacher1)
                                    .thumbNailPath(defaultCourseImage)
                                    .category(categoryRepository.findByName("UX/UI Design").orElseThrow(()-> new CategoryNotFoundException("UX/UI Design")))
                                    .build()
                            );
                }catch (CategoryNotFoundException ex){
                    ex.printStackTrace();
                }

                courseRepository.saveAll(courses);

            }
        };
    }
}
