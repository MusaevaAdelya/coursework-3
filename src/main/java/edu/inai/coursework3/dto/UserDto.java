package edu.inai.coursework3.dto;

import edu.inai.coursework3.entities.User;
import edu.inai.coursework3.enums.UserRoles;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class UserDto {
    public static UserDto from(User user){
        return UserDto.builder()
                .id(user.getId())
                .username(user.getUsername())
                .email(user.getEmail())
                .role(user.getRole())
                .avatar(user.getAvatar())
                .coins(user.getCoins())
                .build();
    }

    private Long id;
    private String username;
    private String email;
    private UserRoles role;
    private String avatar;
    private Double coins;
}
