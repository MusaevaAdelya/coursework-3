
$(document).ready(function() {
    $('.seeallreviewsbut').html('See all reviews');
    $('.seeallreviewsbut').click(function() {
        if ($(this).text() == 'See all reviews') {
            $(this).html('Alle Bewertungen ausblenden');
        } else {
            $(this).html('Alle Bewertungen sehen');
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

