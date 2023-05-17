$('.openUserModalBtn').on("click", function () {
    // Получение email пользователя из формы
    var userEmail = $(this).data("user-email");
    // Выполнение AJAX-запроса на сервер с передачей email в качестве параметра
    $.ajax({
        url: "/admin/userDetail", // URL для вашего контроллера на сервере
        type: "get",
        data: {userEmail: userEmail},
        success: function (response) {
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
            if (enabled) {
                $("#userForm #status").val("Active");
            } else {
                $("#userForm #status").val("Blocked");
            }

            $('.saveUserBtn').attr('data-user-email', response.email);

            var courseList = $('#created_course-list');
            courseList.empty();
            $.each(response.createdCourses, function (index, course) {
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
            $.each(response.studyingCourses, function (index, course) {
                var courseItem = $('<div>').addClass('col-md-4');
                var courseLink = $('<a>').attr('href', '#').addClass('text-decoration-none');
                var courseContainer = $('<div>').addClass('course');
                var courseImage = $('<div>').addClass('course-image');
                var courseImageSrc = $('<img>').attr('src', '/files/courses/' + course.thumbNailPath).attr('alt', course.name);
                var courseInfo = $('<div>').addClass('course-info');
                var courseTitle = $('<h3>').text(course.name);
                if (course.percent === 100) {
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
        error: function (xhr, status, error) {
            console.log(xhr);
            // Обработка ошибки
            console.error("Ошибка при получении данных пользователя: " + error.toString());
        }
    });
});

$('#created-courses-filter').on('change', function () {
    var selectedStatus = $(this).val(); // получаем выбранный статус
    // отправляем AJAX запрос на сервер с выбранным статусом
    $.ajax({
        url: '/admin/createdUserCourses', // замените на вашу URL для получения курсов
        method: 'GET',
        data: {status: selectedStatus, userEmail: $('#originalEmail').val()}, // передаем выбранный статус
        success: function (response) {
            // обновляем список курсов на странице с помощью шаблонизатора, например, Handlebars
            var courseList = $('#created_course-list');
            courseList.empty();
            $.each(response, function (index, course) {
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
        error: function (error) {
            console.log(error);
        }
    });
});

$('#studying-courses-filter').on('change', function () {
    var selectedStatus = $(this).val(); // получаем выбранный статус
    // отправляем AJAX запрос на сервер с выбранным статусом
    $.ajax({
        url: '/admin/studyingUserCourses', // замените на вашу URL для получения курсов
        method: 'GET',
        data: {status: selectedStatus, userEmail: $('#originalEmail').val()}, // передаем выбранный статус
        success: function (response) {
            // обновляем список курсов на странице с помощью шаблонизатора, например, Handlebars
            var courseList = $('#studying_course-list');
            courseList.empty();
            $.each(response, function (index, course) {
                var courseItem = $('<div>').addClass('col-md-4');
                var courseLink = $('<a>').attr('href', '#').addClass('text-decoration-none');
                var courseContainer = $('<div>').addClass('course');
                var courseImage = $('<div>').addClass('course-image');
                var courseImageSrc = $('<img>').attr('src', '/files/courses/' + course.thumbNailPath).attr('alt', course.name);
                var courseInfo = $('<div>').addClass('course-info');
                var courseTitle = $('<h3>').text(course.name);
                if (course.percent === 100) {
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
        error: function (error) {
            console.log(error);
        }
    });
});

$('.openCourseModalBtn').on("click", function () {
    // Получение email пользователя из формы
    var courseId = $(this).data("course-id");
    console.log(courseId);
    // Выполнение AJAX-запроса на сервер с передачей email в качестве параметра
    $.ajax({
        url: "/admin/courseDetail", // URL для вашего контроллера на сервере
        type: "get",
        data: {courseId: courseId},
        success: function (response) {
            // Обработка успешного ответа от сервера
            // Отображение полученных данных пользователя в форме
            console.log(response);
            $("#courseName").text(response.name);
            $("#courseImage").attr('src', '/files/courses/' + response.thumbNailPath).attr('alt', response.name);
            $("#teacher").html("<b>Teacher:</b> " + response.teacher.username);
            $("#category").html("<b>Category:</b> " + response.category.name);
            $("#coins").html("<b>Coins:</b> " + response.coins);
            $("#status").html("<b>Status:</b> <text class=\"text-success\">" + response.status + "</text>");
            $("#createdOn").html("<b>Created On:</b> " + getFormattedDate(response.dateOn.toString()));
            $("#rating").html("<b>Rating:</b> <i class=\"bi bi-star text-warning\"></i>" + " " + response.ratingScore.toString());

            var sectionlist = $("#sections")
            sectionlist.empty();
            $.each(response.courseSections, function (index, section) {
                sectionlist.append($('<li>').text(section.title))
            });
            var course_users = $("#course-users")
            course_users.empty();
            $.each(response.users, function (index, user) {
                var tableRow = $('<tr>');
                var tableData1 = $('<td>').text(user.id);
                var tableData2 = $('<td>').text(user.username);
                var tableData3 = $('<td>').text('03.04.2023');
                var tableData4 = $('<td>');
                var button = $('<button>').attr('type', 'button').addClass('deleteUserFromCourse btn btn-danger btn-icon-split btn-sm').attr('data-user-id', user.id).attr('data-course-id', courseId);
                var buttonIcon = $('<span>').addClass('icon text-white-50').html('<i class="bis bi-trash"></i>');
                var buttonText = $('<span>').addClass('text').text('Dismiss');

                button.append(buttonIcon).append(buttonText);
                tableData4.append(button);
                //
                button.on('click', function () {
                    console.log("gg");
                    var userId = $(this).data('user-id');
                    var courseId = $(this).data("course-id");
                    console.log(userId);

                });

                tableRow.append(tableData1, tableData2, tableData3, tableData4);
                course_users.append(tableRow);
            });

            $('.deleteUserFromCourse').on("click", function () {
                console.log("gg");
                var userId = $(this).data('user-id');
                var courseId = $(this).data("course-id");
                console.log(userId);
                $.ajax({
                    type: 'DELETE',
                    url: '/admin/users/' + userId + '/courses/' + courseId,
                    success: function (response) {
                        // Обработка успешного удаления пользователя из курса
                        course_users.empty();
                        $.each(response, function (index, user) {
                            var tableRow = $('<tr>');
                            var tableData1 = $('<td>').text(user.id);
                            var tableData2 = $('<td>').text(user.username);
                            var tableData3 = $('<td>').text('03.04.2023');
                            var tableData4 = $('<td>');
                            var button = $('<button>').attr('type', 'button').addClass('deleteUserFromCourse btn btn-danger btn-icon-split btn-sm').attr('data-user-id', user.id).attr('data-course-id', courseId);
                            var buttonIcon = $('<span>').addClass('icon text-white-50').html('<i class="bis bi-trash"></i>');
                            var buttonText = $('<span>').addClass('text').text('Dismiss');

                            button.append(buttonIcon).append(buttonText);
                            tableData4.append(button);
                            //
                            button.on('click', function () {
                                console.log("gg");
                                var userId = $(this).data('user-id');
                                var courseId = $(this).data("course-id");
                                console.log(userId);

                            });

                            tableRow.append(tableData1, tableData2, tableData3, tableData4);
                            course_users.append(tableRow);
                        });
                        console.log('User deleted from course successfully.');

                    },
                    error: function (xhr, status, error) {
                        // Обработка ошибки удаления пользователя из курса
                        console.error('Error deleting user from course:', error);
                    }
                });
            });

        },
        error: function (xhr, status, error) {
            console.log(xhr);
            // Обработка ошибки
            console.error("Ошибка при получении данных курса: " + error.toString());
        }
    });
});

$('.deleteCourseFromActive').on("click", function () {
    var courseId = $(this).data("course-id");
    var button = $('#modalSuccessButton');
    button.attr('data-course-id', courseId);
    button.attr('data-status', 'DECLINED');

});

$('.activeCourseFromDeleted').on("click", function () {
    var courseId = $(this).data("course-id");
    var button = $('#modalSuccessButton');
    button.attr('data-course-id', courseId);
    button.attr('data-status', 'ACCEPTED');

});


$('#modalSuccessButton').on("click", function () {
    var courseId = $(this).data("course-id");
    var type = $(this).data("status");

    $.ajax({
        type: 'POST',
        url: '/admin/updateCourseStatus',
        data: {'courseId': courseId, 'status': type},
        success: function (response) {
            // Обработка успешного удаления пользователя из курса
            updateAllCoursesList();
            console.log("Response successful")

        },
        error: function (xhr, status, error) {
            // Обработка ошибки удаления пользователя из курса
            console.error('Error deleting user from course:', error);
        }
    });

});

function assignButtonHandlers() {
    $('.deleteCourseFromActive').off('click');
    // Обработчик для кнопки удаления курса
    $('.deleteCourseFromActive').on("click", function () {
        var courseId = $(this).data("course-id");
        var button = $('#modalSuccessButton');
        console.log("gg");
        console.log(courseId);
        button.data('course-id', courseId);
        button.data('status', 'DECLINED');

    });
    $('.activeCourseFromDeleted').off("click");
    $('.activeCourseFromDeleted').on("click", function () {
        var courseId = $(this).data("course-id");
        var button = $('#modalSuccessButton');
        console.log("gg");
        console.log(courseId);
        button.data('course-id', courseId);
        button.data('status', 'ACCEPTED');

    });
    $('.openCourseModalBtn').off("click");
    // Обработчик для кнопки открытия модального окна
    $('.openCourseModalBtn').on("click", function () {
        // Получение email пользователя из формы
        var courseId = $(this).data("course-id");
        console.log(courseId);
        // Выполнение AJAX-запроса на сервер с передачей email в качестве параметра
        $.ajax({
            url: "/admin/courseDetail", // URL для вашего контроллера на сервере
            type: "get",
            data: {courseId: courseId},
            success: function (response) {
                // Обработка успешного ответа от сервера
                // Отображение полученных данных пользователя в форме
                console.log(response);
                $("#courseName").text(response.name);
                $("#courseImage").attr('src', '/files/courses/' + response.thumbNailPath).attr('alt', response.name);
                $("#teacher").html("<b>Teacher:</b> " + response.teacher.username);
                $("#category").html("<b>Category:</b> " + response.category.name);
                $("#coins").html("<b>Coins:</b> " + response.coins);
                $("#status").html("<b>Status:</b> <text class=\"text-success\">" + response.status + "</text>");
                // $("#createdOn").html("<b>Created On:</b> " + response.dateOn);
                $("#rating").html("<b>Rating:</b> <i class=\"bi bi-star text-warning\"></i>" + " " + response.ratingScore.toString());

                var sectionlist = $("#sections")
                sectionlist.empty();
                $.each(response.courseSections, function (index, section) {
                    sectionlist.append($('<li>').text(section.title))
                });
                var course_users = $("#course-users")
                course_users.empty();
                $.each(response.users, function (index, user) {
                    var tableRow = $('<tr>');
                    var tableData1 = $('<td>').text(user.id);
                    var tableData2 = $('<td>').text(user.username);
                    var tableData3 = $('<td>').text('03.04.2023');
                    var tableData4 = $('<td>');
                    var button = $('<button>').attr('type', 'button').addClass('deleteUserFromCourse btn btn-danger btn-icon-split btn-sm').attr('data-user-id', user.id).attr('data-course-id', courseId);
                    var buttonIcon = $('<span>').addClass('icon text-white-50').html('<i class="bis bi-trash"></i>');
                    var buttonText = $('<span>').addClass('text').text('Dismiss');

                    button.append(buttonIcon).append(buttonText);
                    tableData4.append(button);
                    //
                    button.on('click', function () {
                        console.log("gg");
                        var userId = $(this).data('user-id');
                        var courseId = $(this).data("course-id");
                        console.log(userId);

                    });

                    tableRow.append(tableData1, tableData2, tableData3, tableData4);
                    course_users.append(tableRow);
                });

                $('.deleteUserFromCourse').on("click", function () {
                    console.log("gg");
                    var userId = $(this).data('user-id');
                    var courseId = $(this).data("course-id");
                    console.log(userId);
                    $.ajax({
                        type: 'DELETE',
                        url: '/admin/users/' + userId + '/courses/' + courseId,
                        success: function (response) {
                            // Обработка успешного удаления пользователя из курса
                            course_users.empty();
                            $.each(response, function (index, user) {
                                var tableRow = $('<tr>');
                                var tableData1 = $('<td>').text(user.id);
                                var tableData2 = $('<td>').text(user.username);
                                var tableData3 = $('<td>').text('03.04.2023');
                                var tableData4 = $('<td>');
                                var button = $('<button>').attr('type', 'button').addClass('deleteUserFromCourse btn btn-danger btn-icon-split btn-sm').attr('data-user-id', user.id).attr('data-course-id', courseId);
                                var buttonIcon = $('<span>').addClass('icon text-white-50').html('<i class="bis bi-trash"></i>');
                                var buttonText = $('<span>').addClass('text').text('Dismiss');

                                button.append(buttonIcon).append(buttonText);
                                tableData4.append(button);
                                //
                                button.on('click', function () {
                                    console.log("gg");
                                    var userId = $(this).data('user-id');
                                    var courseId = $(this).data("course-id");
                                    console.log(userId);

                                });

                                tableRow.append(tableData1, tableData2, tableData3, tableData4);
                                course_users.append(tableRow);
                            });
                            console.log('User deleted from course successfully.');

                        },
                        error: function (xhr, status, error) {
                            // Обработка ошибки удаления пользователя из курса
                            console.error('Error deleting user from course:', error);
                        }
                    });
                });

            },
            error: function (xhr, status, error) {
                console.log(xhr);
                // Обработка ошибки
                console.error("Ошибка при получении данных курса: " + error.toString());
            }
        });
    });

    $('#modalSuccessButton').off("click");

    $('#modalSuccessButton').on("click", function () {
        var courseId = $(this).data("course-id");
        var type = $(this).data("status");

        $.ajax({
            type: 'POST',
            url: '/admin/updateCourseStatus',
            data: {'courseId': courseId, 'status': type},
            success: function (response) {
                // Обработка успешного удаления пользователя из курса
                updateAllCoursesList();
                console.log("Response successful")

            },
            error: function (xhr, status, error) {
                // Обработка ошибки удаления пользователя из курса
                console.error('Error deleting user from course:', error);
            }
        });

    });

}
function updateAllCoursesList() {
    $.ajax({
        type: 'GET',
        url: '/admin/getCoursesByStatus',
        data: {"status": "ACCEPTED"},
        success: function (response) {
            // Обработка успешного удаления пользователя из курса
            var list = $('#activeCoursesList')
            list.empty();

            $.each(response, function (index, course) {
                var tableRow = $('<tr>');
                var tableData1 = $('<td>').text(course.id);
                var tableData2 = $('<td>').text(course.name);
                var tableData3 = $('<td>').html('<button type="button" data-bs-toggle="modal" data-bs-target="#success-modal" data-course-id="' + course.id + '" class="deleteCourseFromActive btn btn-success btn-sm"><span class="text">Active</span></button>');
                var tableData4 = $('<td>').text(course.teacher.username);
                var tableData5 = $('<td>').html('<span class="icon text-warning"><i class="bis bi-star"></i></span>' + course.ratingScore);
                var tableData6 = $('<td>').text(course.category.name);
                var tableData7 = $('<td>').text(getFormattedDate(course.dateOn.toString()));
                var tableData8 = $('<td>').html('<button type="button" data-bs-toggle="modal" data-bs-target="#profile-modal" data-course-id="' + course.id + '" class="openCourseModalBtn btn btn-info btn-icon-split btn-sm"><span class="icon text-white-50"><i class="bi bi-eye"></i></span><span class="text">See details</span></button>');
                tableRow.append(tableData1, tableData2, tableData3, tableData4, tableData5, tableData6, tableData7, tableData8);
                list.append(tableRow);

            });
            console.log("Response successful")
            assignButtonHandlers();


        },
        error: function (xhr, status, error) {
            // Обработка ошибки удаления пользователя из курса
            console.error('Error deleting user from course:', error);
        }
    });
    $.ajax({
        type: 'GET',
        url: '/admin/getCoursesByStatus',
        data: {"status": "MODERATION"},
        success: function (response) {
            // Обработка успешного удаления пользователя из курса
            var list = $('#moderCoursesList')
            list.empty();

            $.each(response, function (index, course) {
                var tableRow = $('<tr>');
                var tableData1 = $('<td>').text(course.id);
                var tableData2 = $('<td>').text(course.name);
                var tableData3 = $('<td>').html('<button type="button" data-bs-toggle="modal" data-target="#success-modal" data-course-id="' + course.id + '" class="deleteCourseFromActive btn btn-warning btn-sm"><span class="text">Moderating</span></button>');
                var tableData4 = $('<td>').text(course.teacher.username);
                var tableData6 = $('<td>').text(course.category.name);
                var tableData7 = $('<td>').text(getFormattedDate(course.dateOn.toString()));
                var tableData8 = $('<td>').html('<button type="button" data-bs-toggle="modal" data-bs-target="#profile-modal" data-course-id="' + course.id + '" class="openCourseModalBtn btn btn-info btn-icon-split btn-sm"><span class="icon text-white-50"><i class="bi bi-eye"></i></span></button>' +
                    '<button type="button" data-bs-toggle="modal" data-bs-target="#success-modal" data-course-id="' + course.id + '" class="activeCourseFromDeleted btn btn-success btn-icon-split btn-sm"><span class="text"><i class="bis bi-check"></i></span></button>' +
                    '<button type="button" data-bs-toggle="modal" data-bs-target="#success-modal" data-course-id="' + course.id + '" class="deleteCourseFromActive btn btn-danger btn-icon-split btn-sm"><span class="text"><i class="bis bi-trash"></i></span></button>');
                tableRow.append(tableData1, tableData2, tableData3, tableData4, tableData6, tableData7, tableData8);
                list.append(tableRow);

            });
            console.log("Response successful")
            assignButtonHandlers();


        },
        error: function (xhr, status, error) {
            // Обработка ошибки удаления пользователя из курса
            console.error('Error deleting user from course:', error);
        }
    });
    $.ajax({
        type: 'GET',
        url: '/admin/getCoursesByStatus',
        data: {"status": "DECLINED"},
        success: function (response) {
            // Обработка успешного удаления пользователя из курса
            var list = $('#deletedCoursesList')
            list.empty();

            $.each(response, function (index, course) {
                var tableRow = $('<tr>');
                var tableData1 = $('<td>').text(course.id);
                var tableData2 = $('<td>').text(course.name);
                var tableData3 = $('<td>').html('<button type="button" data-bs-toggle="modal" data-bs-target="#success-modal" data-course-id="' + course.id + '" class="activeCourseFromDeleted btn btn-danger btn-sm"><span class="text">Deleted</span></button>');
                var tableData4 = $('<td>').text(course.teacher.username);
                var tableData5 = $('<td>').html('<span class="icon text-warning"><i class="bis bi-star"></i></span>' + course.ratingScore);
                var tableData6 = $('<td>').text(course.category.name);
                var tableData7 = $('<td>').text(getFormattedDate(course.dateOn.toString()));
                var tableData8 = $('<td>').html('<button type="button" data-bs-toggle="modal" data-bs-target="#profile-modal" data-course-id="' + course.id + '" class="openCourseModalBtn btn btn-info btn-icon-split btn-sm"><span class="icon text-white-50"><i class="bi bi-eye"></i></span><span class="text">See details</span></button>');
                tableRow.append(tableData1, tableData2, tableData3, tableData4, tableData5, tableData6, tableData7, tableData8);
                list.append(tableRow);

            });
            console.log("Response successful")
            assignButtonHandlers();


        },
        error: function (xhr, status, error) {
            // Обработка ошибки удаления пользователя из курса
            console.error('Error deleting user from course:', error);
        }
    });
}

function getFormattedDate(date) {
    var parts = date.split(',');
    var year = parseInt(parts[0]);
    var month = parseInt(parts[1]);
    var day = parseInt(parts[2]);

    // Преобразуем значения дня и месяца в двузначный формат, если они меньше 10
    var formattedDay = (day < 10) ? '0' + day : day;
    var formattedMonth = (month < 10) ? '0' + month : month;

    var formattedDate = formattedDay + '-' + formattedMonth + '-' + year;
    return formattedDate;
}


$('#nestable').on('change', function() {
    var newOrder = $('.dd').nestable('serialize');
    console.log(newOrder);
    traverseCategories(newOrder)
});


// [
//     {
//         "categoryId": 1,
//         "children": [
//             {
//                 "categoryId": 2,
//                 "children": [
//                     {
//                         "categoryId": 5
//                     },
//                     {
//                         "categoryId": 6
//                     }
//                 ]
//             }
//         ]
//     },
//     {
//         "categoryId": 7,
//         "children": [
//             {
//                 "categoryId": 4
//             },
//             {
//                 "categoryId": 3
//             }
//         ]
//     }
// ]

function traverseCategories(categories, parentPosition) {
    for (var i = 0; i < categories.length; i++) {
        var category = categories[i];
        var categoryId = category.categoryId;
        var newPosition = parentPosition ? parentPosition.toString() : 0;
        $.ajax({
            type: 'POST',
            url: '/admin/updateCategory',
            data: {'categoryId': categoryId, 'parentId': newPosition},
            success: function (response) {

            },
            error: function (xhr, status, error) {
                // Обработка ошибки удаления пользователя из курса
                console.error('Error deleting user from course:', error);
            }
        });
        // Выполнение AJAX-запроса с использованием categoryId и newPosition
        if (category.children && category.children.length > 0) {
            traverseCategories(category.children, categoryId);
        }
    }
}

// добавление категории
$("#add-item").click(function (e) {
    e.preventDefault(); // отменяем действие по умолчанию при клике на кнопку
    var name = $("#categoryName").val(); // получаем значение поля "Name"
    if (name !== '') { // проверяем, что поле "Name" не пустое
        $.ajax({
            type: 'POST',
            url: '/admin/addNewCategory',
            data: {'name': name},
            success: function (response) {
                var newItem = '<li class="dd-item" data-category-id="'+ response +'"><div class="dd-handle"><div class="dd-handle-container d-flex"><span>' + name + '</span><span class="buttons"><button class="btn dd-btn btn-danger btn-sm ml-2" data-bs-toggle="modal" data-bs-target="#deleteModal" data-category-id="'+ response +'"><i class="bi bi-trash"></i></button><button class="editCategoryNameBtn btn dd-btn btn-info btn-sm ml-2" data-bs-toggle="modal" data-bs-target="#editModal" data-category-id="'+ response +'"><i class="bi bi-pen"></i></button></span></div></div></li>'; // создаем новый элемент списка
                $("#nestable ol:first-child").append(newItem); // добавляем новый элемент в список
                $("#categoryName").val(''); // очищаем поле "Name"
            },
            error: function (xhr, status, error) {
                // Обработка ошибки удаления пользователя из курса
                console.error('Error deleting user from course:', error);
            }
        });

    }
});

$('.editCategoryNameBtn').on('click', function () {
    var categoryId = $(this).data("category-id");
    $('.saveNewCategoryNameBtn').attr('data-category-id', categoryId)
});

$('.saveNewCategoryNameBtn').on('click', function (e) {
    e.stopPropagation();
    var categoryId = $(this).data("category-id");
    var name = $('#editCategoryName').val()
    if (name !== '') { // проверяем, что поле "Name" не пустое
        $.ajax({
            type: 'POST',
            url: '/admin/updateCategoryName',
            data: {'categoryId': categoryId, 'name': name},
            success: function (response) {
                location.reload()

            },
            error: function (xhr, status, error) {
                // Обработка ошибки удаления пользователя из курса
                console.error('Error deleting user from course:', error);
            }
        });
        var listItem = $('li[data-category-id="' + categoryId + '"]');

        // Обновляем значение спана внутри найденного <li> элемента
        listItem.find('span').text(name);
    }
})


var categories = [/* Ваш массив категорий */];
var nestable = $('#nestable');

categories.forEach(function(category) {
    var categoryItem = renderCategory(category);
    nestable.find('.dd-list').append(categoryItem);
});
