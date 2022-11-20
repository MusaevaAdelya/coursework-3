package edu.inai.coursework3.services;

import edu.inai.coursework3.dto.UserDto;
import edu.inai.coursework3.exceptions.UserNotFoundException;
import edu.inai.coursework3.repositories.UserRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class UserService {
    private final UserRepository userRepository;


    public UserDto getUserDtoByEmail(String email) {
        return UserDto.from(userRepository.findByEmail(email).orElseThrow(()-> new UserNotFoundException(email)));
    }
}
