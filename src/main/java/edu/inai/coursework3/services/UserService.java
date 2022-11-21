package edu.inai.coursework3.services;

import edu.inai.coursework3.config.SecurityConfig;
import edu.inai.coursework3.dto.RegisterForm;
import edu.inai.coursework3.dto.UserDto;
import edu.inai.coursework3.entities.User;
import edu.inai.coursework3.exceptions.UserNotFoundException;
import edu.inai.coursework3.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;

    @Value(value="${avatar.default.image}")
    private String defaultAvatar;


    public UserDto getUserDtoByEmail(String email) {
        return UserDto.from(userRepository.findByEmail(email).orElseThrow(()-> new UserNotFoundException(email)));
    }


    public void register(RegisterForm user){
        HttpServletRequest request =
                ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes())
                        .getRequest();

        userRepository.save(User.builder()
                .username(user.getUsername())
                .email(user.getEmail())
                .password(SecurityConfig.encoder().encode(user.getPassword()))
                        .avatar(defaultAvatar)
                .build());

        SecurityConfig.authWithHttpServletRequest(request, user.getEmail(), user.getPassword());
    }
}
