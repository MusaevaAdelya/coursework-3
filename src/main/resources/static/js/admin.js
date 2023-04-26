$('#openModalBtn').on("click", function() {
    // Получение email пользователя из формы
    var userEmail = $(this).data("user-email");
    console.log(userEmail);
    // Выполнение AJAX-запроса на сервер с передачей email в качестве параметра
    $.ajax({
        url: "/userDetail", // URL для вашего контроллера на сервере
        type: "Post",
        data: { userEmail: userEmail },
        success: function(response) {
            // Обработка успешного ответа от сервера
            // Отображение полученных данных пользователя в форме
            console.log(response);
            $("#userForm.username").val(response);

        },
        error: function(xhr, status, error) {
            console.log(xhr);
            // Обработка ошибки
            console.error("Ошибка при получении данных пользователя: " + error.toString());
        }
    });
});