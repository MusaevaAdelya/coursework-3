$('.create-menu-link').click(function (e) {
    $(".content-create").addClass("hide");
    $($(this).attr("data-content")).removeClass("hide");
});
function removeItem() {
    $(this).parent().parent().parent().remove();
}

$("body").delegate('.remove-item','click',function (e) {
    if ($(this).attr('data-item') == 'lesson'){
        $(this).parent().parent().parent().remove();
    } else if ($(this).attr('data-item') == 'module') {
        $(this).parent().parent().parent().parent().remove();
    }
});
$("body").delegate(".add-lesson",'click',function (e) {
    $(this).before('<a href="#" class="list-group-item list-group-item-action d-flex gap-3 py-3" aria-current="true"> <div class="d-flex gap-2 w-100 justify-content-between"> <div class="w-50"> <div class="mb-3"> <input type="text" class="form-control fs-5 lesson-class" name="lesson" id="courseNameInput" placeholder="Lesson name" /> </div> </div> <div> <button class="btn btn-primary" type="button">Edit</button><button data-item="lesson" class="btn remove-item" type="button"><i class="bi bi-trash3 text-danger"></i></button> </div> </div> </a>');
});
$("body").delegate(".add-module",'click',function (e) {
    var count = $(this).parent().children('.list-group-item').length - 1;
    $(this).before('<div class="list-group-item module-item"> <div href="#" class="list-group-item list-group-item-action d-flex gap-3 py-3" aria-current="true"> <div class="fs-3">'+(count+1)+'</div> <div class="d-flex gap-2 w-100 justify-content-between"> <div class="w-50"> <div class="mb-3"> <input type="text" class="form-control fs-5 module-class" name="module" id="courseNameInput" placeholder="Module name" value="Module 1" /> </div>  </div> <div>  <button data-item="module" class="btn remove-item" type="button"><i class="bi bi-trash3 text-danger"></i></button> </div> </div> </div> <div class="list-group mb-4 ps-5"> <a href="#" class="list-group-item list-group-item-action d-flex gap-3 py-3 add-lesson" aria-current="true"> <div class="fs-3">Add lesson</div> </a> </div> </div>');
});


$(document).ready(function() {
    const courseSubmitBtn=document.getElementById("courseSubmit")
    const courseForm=document.getElementById("createCourseForm")

    courseForm.addEventListener("submit",function (e){
        e.preventDefault()
        let groupItems=document.getElementsByClassName("module-item")

        for (let i = 0; i < (groupItems.length); i++) {
            let module=groupItems[i].getElementsByClassName("module-class")[0]
            let lessons=groupItems[i].getElementsByClassName("lesson-class")

            module.value=i+"#"+module.value

            for (let j = 0; j < lessons.length; j++) {
                lessons[j].value=i+"#"+lessons[j].value
            }
        }

        courseForm.submit()

    })
})
