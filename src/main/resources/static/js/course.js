$(document).ready(function() {
    $('.seeallcourcesbut').html('See all course');
    $('.seeallcourcesbut').click(function() {
        if ($(this).text() == 'See all course') {
            $(this).html('Hide all course');
        } else {
            $(this).html('See all course');
        }
    })
});

$(document).ready(function() {
    $('.seeallreviewsbut').html('See all reviews');
    $('.seeallreviewsbut').click(function() {
        if ($(this).text() == 'See all reviews') {
            $(this).html('Hide all reviews');
        } else {
            $(this).html('See all reviews');
        }
    })
})


var header = $(".course-card");
var scrollChange = $(".course-header").height();
console.log(scrollChange)
$(window).scroll(function() {
    var scroll = $(window).scrollTop();

    if (scroll >= scrollChange) {
        header.addClass('shadow-cat');
    } else {
        header.removeClass("shadow-cat");
    }
});


const allStars = document.querySelectorAll(".star-btn"),
    currentRating = document.querySelector(".current-rating");
let commentStartsInput = document.getElementById("commentStars")


allStars.forEach((star, i) => {
    star.onclick = function () {
        let current_star_level = i + 1;
        commentStartsInput.value = current_star_level;

        allStars.forEach((star, j) => {
            if (current_star_level >= j + 1) {
                star.innerHTML = '&#9733';
                currentRating.innerText = current_star_level + 'of 5'
            } else {
                star.innerHTML = '&#9734';
            }
        })
    }
});


function RollIn(){
    var prog = document.getElementById("progress")
    var prog_block = document.getElementById("progress-t")
    var comments = document.getElementById("add-reviews")
    var roll = document.getElementById("roll-in")
    var width = prog.style.width
    var width_int = Number(width.replace("%" , ""))

    roll.style.display = "none"
    prog_block.style.display = "block"
    if(width_int< 10){
        comments.style.display = "none"
        prog.innerHTML = width
    }else{
        comments.style.display = "block"
        prog.innerHTML = width
    }

}