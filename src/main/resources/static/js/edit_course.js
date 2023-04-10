const textArea = document.querySelector('#myTextArea')
// document.querySelector(".save-btn").addEventListener('click' , ()=>{
//    let text = tinymce.get('myTextArea').getContent();
//    console.log(text)
// });

const editForm=document.getElementById("editChapterForm")
const textHtml=document.getElementById("textHtml")

$(document).ready(function() {
   editForm.addEventListener("submit",function (e){
      e.preventDefault()
      textHtml.value=tinymce.get('myTextArea').getContent();
      editForm.submit()
   })
})


$("body").delegate('.remove-item','click',function (e) {
   $(this).parent().parent().remove();
});
$("body").delegate(".add-answer ",'click',function (e) {
   var count = $(this).parent().parent().children('.test').length;
   var text = '<div class="test d-flex justify-content-between">\n' +
       '          <div>\n' +
       '            <input type="radio" name="test{n}" id="test{n}">\n' +
       '            <input type="text" name="test{n}" data-radio="#test{n}" class="answer-input test-input" placeholder="answer">\n' +
       '          </div>\n' +
       '          <div>\n' +
       '            <button class="btn remove-item ">\n' +
       '              <i class="bi bi-trash3 text-danger"></i>\n' +
       '            </button>\n' +
       '\n' +
       '          </div>\n' +
       '        </div>';
   $(this).parent().before(text.replaceAll('{n}',count));
});

$('body').delegate('input.answer-input', 'input', function(){
   $($(this).attr('data-radio')).val($(this).val());
});

