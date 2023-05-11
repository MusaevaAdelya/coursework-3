$('.openModalBtn').on("click", function() {
    // Получение email пользователя из формы
    var userEmail = $(this).data("user-email");
    // Выполнение AJAX-запроса на сервер с передачей email в качестве параметра
    $.ajax({
        url: "/admin/userDetail", // URL для вашего контроллера на сервере
        type: "get",
        data: { userEmail: userEmail },
        success: function(response) {
            // Обработка успешного ответа от сервера
            // Отображение полученных данных пользователя в форме
            console.log(response);
            $("#userForm #username").val(response.username);
            $("#userForm #email").val(response.email);
            // $("#userForm #role").val(response.role);
            $("#userForm #balance").val(response.coins.toString());
            var role = response.role;
            role = role.charAt(0).toUpperCase() + role.slice(1).toLowerCase();
            $("#userForm #role").val(role);

            var enabled = response.enabled;
            if(enabled){
                $("#userForm #status").val("Active");
            } else {
                $("#userForm #status").val("Blocked");
            }



        },
        error: function(xhr, status, error) {
            console.log(xhr);
            // Обработка ошибки
            console.error("Ошибка при получении данных пользователя: " + error.toString());
        }
    });
});

$('.saveUserBtn').on('click', function() {
    var formData = $('#userForm').serialize(); // Получение данных формы
    console.log(formData);

    $.ajax({
        url: '/admin/userUpdate',
        type: 'POST',
        data: formData,
        success: function(response) {
            // Обработка успешного ответ
            // Обработка успешного ответа от сервера
            console.log(response);
        },
        error: function(xhr, status, error) {
            // Обработка ошибки
            console.error('Ошибка при сохранении изменений пользователя: ' + error.toString());
        }
    });
});