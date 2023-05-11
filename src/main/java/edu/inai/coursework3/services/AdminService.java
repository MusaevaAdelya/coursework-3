package edu.inai.coursework3.services;

import edu.inai.coursework3.dto.AdminUserEditForm;
import edu.inai.coursework3.dto.UserDto;
import edu.inai.coursework3.entities.User;
import edu.inai.coursework3.exceptions.UserNotFoundException;
import edu.inai.coursework3.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Service
@RequiredArgsConstructor
public class AdminService {

    private final UserRepository userRepository;

    public UserDto getUserDtoByEmail(String email) {
        return UserDto.from(userRepository.findByEmail(email).orElseThrow(() -> new UserNotFoundException(email)));
    }

    public Page<User> getUsers(Pageable pageable) {
        return userRepository.getUsers(pageable);

    }

    public void editUser(AdminUserEditForm form, String userEmail, RedirectAttributes ra){
        User user = userRepository.findByEmail(userEmail).orElseThrow(() -> new UserNotFoundException(userEmail));

        user.setEmail(form.getNewEmail());
        user.setUsername(form.getNewUsername());
        user.setCoins(form.getNewBalance());
        user.setRole(form.getNewRole());
        user.setEnabled(form.getNewStatus());

        userRepository.save(user);
    }
}
