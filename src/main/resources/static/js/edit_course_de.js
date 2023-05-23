$(document).ready(function() {
    $("#test").click(function() {
        console.log($("#editChapterForm"))
    });
});


$("body").delegate('.remove-item','click',function (e) {
    $(this).parent().parent().remove();
});
$("body").delegate(".add-answer ",'click',function (e) {
    var count = $(this).parent().parent().children('.test').length;
    var text = '<div class="test d-flex justify-content-between">\n' +
        '          <div>\n' +
        '            <input type="radio" name="correct" id="test${answer.id + 1}" <#if answer.correct>checked</#if> value="${answer.text!""}">\n' +
        '            <input type="text" name="answer" data-radio="#test${answer.id + 1}" class="answer-input test-input" placeholder="Antwort" value="${answer.text!""}">\n' +
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

