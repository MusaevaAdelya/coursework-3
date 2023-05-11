package edu.inai.coursework3.dto;

import edu.inai.coursework3.enums.UserRoles;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class AdminUserEditForm {
    String newUsername;
    String newEmail;
    UserRoles newRole;
    Double newBalance;
    Boolean newStatus;
}
