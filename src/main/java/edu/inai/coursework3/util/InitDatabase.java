package edu.inai.coursework3.util;


import edu.inai.coursework3.entities.Category;
import edu.inai.coursework3.entities.Course;
import edu.inai.coursework3.entities.User;
import edu.inai.coursework3.enums.UserRoles;
import edu.inai.coursework3.exceptions.CategoryNotFoundException;
import edu.inai.coursework3.exceptions.UserNotFoundException;
import edu.inai.coursework3.repositories.CategoryRepository;
import edu.inai.coursework3.repositories.CourseRepository;
import edu.inai.coursework3.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.util.List;
import java.util.Random;

@Configuration
public class InitDatabase {
    private final PasswordEncoder passwordEncoder;
    private final static Random rnd=new Random();

    @Value(value="${avatar.default.image}")
    private String defaultAvatar;

    @Value(value="${courses.default.image}")
    private String defaultCourseImage;

    public InitDatabase(PasswordEncoder passwordEncoder) {
        this.passwordEncoder = passwordEncoder;
    }

    @Bean
    CommandLineRunner init(UserRepository userRepository, CategoryRepository categoryRepository, CourseRepository courseRepository) {
        return (args) -> {
            if (userRepository.findByEmail("msvadelya@gmail.com").isEmpty()) {
                User user1=User.builder()
                        .email("msvadelya@gmail.com")
                        .password(passwordEncoder.encode("12345678"))
                        .username("Adelya Musaeva")
                        .avatar(defaultAvatar)
                        .role(UserRoles.ADMIN)
                        .build();
                userRepository.save(user1);
            }
            if (userRepository.findByEmail("dylan.obrien@gmail.com").isEmpty()) {
                User user2=User.builder()
                        .email("dylan.obrien@gmail.com")
                        .password(passwordEncoder.encode("12345678"))
                        .username("Dylan O'Brien")
                        .avatar(defaultAvatar)
                        .build();
                userRepository.save(user2);
            }

            if (userRepository.findByEmail("ilya.ugai@gmail.com").isEmpty()) {
                User user3=User.builder()
                        .email("ilya.ugai@gmail.com")
                        .password(passwordEncoder.encode("12345678"))
                        .username("Ilya Ugai")
                        .avatar(defaultAvatar)
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
            if(courses.size()==0){
                User teacher1= userRepository.findByEmail("ilya.ugai@gmail.com").orElseThrow(
                        ()-> new UserNotFoundException("ilya.ugai@gmail.com")
                );
                User teacher2=userRepository.findByEmail("msvadelya@gmail.com").orElseThrow(
                        ()-> new UserNotFoundException("msvadelya@gmail.com")
                );
                try{
                    courses=List.of(
                            Course.builder()
                                    .name("Spring Boot")
                                    .coins(100.0)
                                    .enabled(true)
                                    .teacher(teacher2)
                                    .thumbNailPath(defaultCourseImage)
                                    .category(categoryRepository.findByName("Back-end").orElseThrow(()-> new CategoryNotFoundException("Back-end")))
                                    .build(),
                            Course.builder()
                                    .name("Spring Security")
                                    .coins(100.0)
                                    .enabled(true)
                                    .teacher(teacher2)
                                    .thumbNailPath(defaultCourseImage)
                                    .category(categoryRepository.findByName("Back-end").orElseThrow(()-> new CategoryNotFoundException("Back-end")))
                                    .build(),
                            Course.builder()
                                    .name("Spring Data JPA")
                                    .coins(100.0)
                                    .enabled(true)
                                    .teacher(teacher2)
                                    .thumbNailPath(defaultCourseImage)
                                    .category(categoryRepository.findByName("Back-end").orElseThrow(()-> new CategoryNotFoundException("Back-end")))
                                    .build(),
                            Course.builder()
                                    .name("JDBC")
                                    .coins(100.0)
                                    .enabled(true)
                                    .teacher(teacher2)
                                    .thumbNailPath(defaultCourseImage)
                                    .category(categoryRepository.findByName("Back-end").orElseThrow(()-> new CategoryNotFoundException("Back-end")))
                                    .build(),
                            Course.builder()
                                    .name("Bootstrap 5")
                                    .coins(150.0)
                                    .enabled(true)
                                    .teacher(teacher1)
                                    .thumbNailPath(defaultCourseImage)
                                    .category(categoryRepository.findByName("Front-end").orElseThrow(()-> new CategoryNotFoundException("Front-end")))
                                    .build(),
                            Course.builder()
                                    .name("Full HTML/CSS course")
                                    .coins(150.0)
                                    .enabled(true)
                                    .teacher(teacher1)
                                    .thumbNailPath(defaultCourseImage)
                                    .category(categoryRepository.findByName("Front-end").orElseThrow(()-> new CategoryNotFoundException("Front-end")))
                                    .build(),
                            Course.builder()
                                    .name("Introduction to JavaScript")
                                    .coins(150.0)
                                    .enabled(true)
                                    .teacher(teacher1)
                                    .thumbNailPath(defaultCourseImage)
                                    .category(categoryRepository.findByName("Front-end").orElseThrow(()-> new CategoryNotFoundException("Front-end")))
                                    .build(),
                            Course.builder()
                                    .name("UX/UI Design with Figma")
                                    .coins(150.0)
                                    .enabled(true)
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
