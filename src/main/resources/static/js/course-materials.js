function Fix() {
    var btn = document.getElementById("thumbtack")
    if (btn.innerHTML === "<i class =\"bi bi-pin-angle\"></i>") {
        btn.innerHTML = "<i class=\"bi bi-pin-fill\"></i>";


    }
    else{
        btn.innerHTML = "<i class =\"bi bi-pin-angle\"></i>";


    }
}


var header = $(".test-section");
var scrollChange =$(".course-materials").height() - $(".test-section").height() *3;
$(window).scroll(function() {
    var scroll = $(window).scrollTop();
    if (scroll >= scrollChange) {
        header.addClass('shadow-cat');
    } else {
        header.removeClass("shadow-cat");
    }
});


var prog = document.getElementById("progress")
var width = prog.style.width
var reviews_btn = document.getElementById("reviews-btn")
var width_int = Number(width.replace("%" , ""))

if(width_int< 10){
    reviews_btn.style.display = "none"
    prog.innerHTML = width
}else{
    reviews_btn.style.display = "block"
    prog.innerHTML = width
}