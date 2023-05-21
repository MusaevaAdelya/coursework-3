"use strict";


/* ====== Define JS Constants ====== */
const sidebarToggler = document.getElementById('docs-sidebar-toggler');
const sidebar = document.getElementById('docs-sidebar');
const sidebarLinks = document.querySelectorAll('#docs-sidebar .scrollto');



/* ===== Responsive Sidebar ====== */

window.onload=function()
{
    responsiveSidebar();
};

window.onresize=function()
{
    responsiveSidebar();
};


function responsiveSidebar() {
    let w = window.innerWidth;
    if(w >= 1200) {
        // if larger
        console.log('larger');
        sidebar.classList.remove('sidebar-hidden');
        sidebar.classList.add('sidebar-visible');

    } else {
        // if smaller
        console.log('smaller');
        sidebar.classList.remove('sidebar-visible');
        sidebar.classList.add('sidebar-hidden');
    }
};

sidebarToggler.addEventListener('click', () => {
    if (sidebar.classList.contains('sidebar-visible')) {
        console.log('visible');
        sidebar.classList.remove('sidebar-visible');
        sidebar.classList.add('sidebar-hidden');

    } else {
        console.log('hidden');
        sidebar.classList.remove('sidebar-hidden');
        sidebar.classList.add('sidebar-visible');
    }
});


/* ===== Smooth scrolling ====== */
/*  Note: You need to include smoothscroll.min.js (smooth scroll behavior polyfill) on the page to cover some browsers */
/* Ref: https://github.com/iamdustan/smoothscroll */

sidebarLinks.forEach((sidebarLink) => {

    sidebarLink.addEventListener('click', (e) => {

        e.preventDefault();

        var target = sidebarLink.getAttribute("href").replace('#', '');

        //console.log(target);

        document.getElementById(target).scrollIntoView({ behavior: 'smooth' });


        //Collapse sidebar after clicking
        if (sidebar.classList.contains('sidebar-visible') && window.innerWidth < 1200){

            sidebar.classList.remove('sidebar-visible');
            sidebar.classList.add('sidebar-hidden');
        }

    });

});


/* ===== Gumshoe SrollSpy ===== */
/* Ref: https://github.com/cferdinandi/gumshoe  */
// Initialize Gumshoe
var spy = new Gumshoe('#docs-nav a', {
    offset: 69 //sticky header height
});


/* ====== SimpleLightbox Plugin ======= */
/*  Ref: https://github.com/andreknieriem/simplelightbox */

var lightbox = new SimpleLightbox('.simplelightbox-gallery a', {/* options */});












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



