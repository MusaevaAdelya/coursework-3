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