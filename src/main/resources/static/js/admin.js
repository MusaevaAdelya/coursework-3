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
            $("#created-courses-filter").val('ALL');
            $("#userForm #username").val(response.username);
            $("#userForm #email").val(response.email);
            $("#userForm #originalEmail").val(response.email);
            // $("#userForm #role").val(response.role);
            $("#userForm #balance").val(response.coins.toString());
            var role = response.role;
            $("#userForm #role").val(role);

            var enabled = response.enabled;
            if(enabled){
                $("#userForm #status").val("Active");
            } else {
                $("#userForm #status").val("Blocked");
            }

            $('.saveUserBtn').attr('data-user-email', response.email);

            var courseList = $('#created_course-list');
            courseList.empty();
            $.each(response.createdCourses, function(index, course) {
                var courseItem = $('<div>').addClass('col-md-4');
                var courseLink = $('<a>').attr('href', '#').addClass('text-decoration-none');
                var courseContainer = $('<div>').addClass('course');
                var courseImage = $('<div>').addClass('course-image');
                var courseImageSrc = $('<img>').attr('src', '/files/courses/' + course.thumbNailPath).attr('alt', course.name);
                var courseInfo = $('<div>').addClass('course-info');
                var courseTitle = $('<h3>').text(course.name);
                var courseStatus = $('<p>').text('Status: ' + course.status.toLowerCase());
                courseImage.append(courseImageSrc);
                courseInfo.append(courseTitle).append(courseStatus);
                courseContainer.append(courseImage).append(courseInfo);
                courseLink.append(courseContainer);
                courseItem.append(courseLink);
                courseList.append(courseItem);
            });

            var courseList = $('#studying_course-list');
            courseList.empty();
            $.each(response.studyingCourses, function(index, course) {
                var courseItem = $('<div>').addClass('col-md-4');
                var courseLink = $('<a>').attr('href', '#').addClass('text-decoration-none');
                var courseContainer = $('<div>').addClass('course');
                var courseImage = $('<div>').addClass('course-image');
                var courseImageSrc = $('<img>').attr('src', '/files/courses/' + course.thumbNailPath).attr('alt', course.name);
                var courseInfo = $('<div>').addClass('course-info');
                var courseTitle = $('<h3>').text(course.name);
                if(course.percent === 100){
                    var courseStatus = $('<p>').text("Status: Finished");
                } else {
                    var courseStatus = $('<p>').text("Status: Learning");
                }
                courseImage.append(courseImageSrc);
                courseInfo.append(courseTitle).append(courseStatus);
                courseContainer.append(courseImage).append(courseInfo);
                courseLink.append(courseContainer);
                courseItem.append(courseLink);
                courseList.append(courseItem);
            });



        },
        error: function(xhr, status, error) {
            console.log(xhr);
            // Обработка ошибки
            console.error("Ошибка при получении данных пользователя: " + error.toString());
        }
    });
});

$('#created-courses-filter').on('change', function() {
    var selectedStatus = $(this).val(); // получаем выбранный статус
    // отправляем AJAX запрос на сервер с выбранным статусом
    $.ajax({
        url: '/admin/createdUserCourses', // замените на вашу URL для получения курсов
        method: 'GET',
        data: { status: selectedStatus, userEmail: $('#originalEmail').val() }, // передаем выбранный статус
        success: function(response) {
            // обновляем список курсов на странице с помощью шаблонизатора, например, Handlebars
            var courseList = $('#created_course-list');
            courseList.empty();
            $.each(response, function(index, course) {
                var courseItem = $('<div>').addClass('col-md-4');
                var courseLink = $('<a>').attr('href', '#').addClass('text-decoration-none');
                var courseContainer = $('<div>').addClass('course');
                var courseImage = $('<div>').addClass('course-image');
                var courseImageSrc = $('<img>').attr('src', '/files/courses/' + course.thumbNailPath).attr('alt', course.name);
                var courseInfo = $('<div>').addClass('course-info');
                var courseTitle = $('<h3>').text(course.name);
                var courseStatus = $('<p>').text("Status: " + course.status.toLowerCase());
                courseImage.append(courseImageSrc);
                courseInfo.append(courseTitle).append(courseStatus);
                courseContainer.append(courseImage).append(courseInfo);
                courseLink.append(courseContainer);
                courseItem.append(courseLink);
                courseList.append(courseItem);
            });
        },
        error: function(error) {
            console.log(error);
        }
    });
});

$('#studying-courses-filter').on('change', function() {
    var selectedStatus = $(this).val(); // получаем выбранный статус
    // отправляем AJAX запрос на сервер с выбранным статусом
    $.ajax({
        url: '/admin/studyingUserCourses', // замените на вашу URL для получения курсов
        method: 'GET',
        data: { status: selectedStatus, userEmail: $('#originalEmail').val() }, // передаем выбранный статус
        success: function(response) {
            // обновляем список курсов на странице с помощью шаблонизатора, например, Handlebars
            var courseList = $('#studying_course-list');
            courseList.empty();
            $.each(response, function(index, course) {
                var courseItem = $('<div>').addClass('col-md-4');
                var courseLink = $('<a>').attr('href', '#').addClass('text-decoration-none');
                var courseContainer = $('<div>').addClass('course');
                var courseImage = $('<div>').addClass('course-image');
                var courseImageSrc = $('<img>').attr('src', '/files/courses/' + course.thumbNailPath).attr('alt', course.name);
                var courseInfo = $('<div>').addClass('course-info');
                var courseTitle = $('<h3>').text(course.name);
                if(course.percent === 100){
                    var courseStatus = $('<p>').text("Status: Finished");
                } else {
                    var courseStatus = $('<p>').text("Status: Learning");
                }
                courseImage.append(courseImageSrc);
                courseInfo.append(courseTitle).append(courseStatus);
                courseContainer.append(courseImage).append(courseInfo);
                courseLink.append(courseContainer);
                courseItem.append(courseLink);
                courseList.append(courseItem);
            });
        },
        error: function(error) {
            console.log(error);
        }
    });
});

