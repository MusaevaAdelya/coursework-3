package edu.inai.coursework3.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ProfileEditForm {
    private String newUsername;
    private String newAbout;
    private MultipartFile newAvatar;
    private String newPassword;
    private String newPasswordRepeat;
}
