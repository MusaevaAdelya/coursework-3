$(function () {
    var topNav = $('.nav');

    if (topNav.length) {
        $(window).on('scroll', function () {
            if ($(this).scrollTop()) {
                topNav.stop(true,false).removeAttr('style').addClass('full', {duration:500});
            } else {
                topNav.stop(true,false).removeAttr('style').removeClass('full', {duration:500});
            }
        });
    }
});

function openLinkWithInputValue() {
    // Получаем значение инпута
    var inputValue = $('#SearchBtn').val();

    // Формируем URL со значением инпута
    // Открываем ссылку в новой вкладке
    window.location.href = 'http://localhost:5050/courses?keywords=' + encodeURIComponent(inputValue);
}