<#macro renderWith title="Calopsia" scripts=[] styles=[] footer="true" extrastyle=""
extraScriptAfter="" extraScriptBefore="">
<#assign security=JspTaglibs["http://www.springframework.org/security/tags"]/>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${title}</title>
        <script src="https://cdn.tiny.cloud/1/yqs0bilptzksistq5bm5uxaxxwmyzzt7h072jpwss8hlg70k/tinymce/6/tinymce.min.js"
                referrerpolicy="origin"></script>



        <script src="/vendor/anychart/anychart-base.min.js"></script>
        <script src="/vendor/anychart/anychart-ui.min.js"></script>
        <script src="/vendor/anychart/anychart-exports.min.js"></script>
        <script src="/vendor/anychart/anychart-calendar.min.js"></script>
        <script src="/vendor/anychart/anychart-data-adapter.min.js"></script>
        <link rel="stylesheet" href="/vendor/anychart/anychart-font.min.css">
        <link rel="stylesheet" href="/vendor/anychart/anychart-ui.min.css">
        <link href="https://use.fontawesome.com/ffe0d7ed97.css" media="all" rel="stylesheet">
        <link rel="stylesheet" href="/vendor/bootstrap-icons/bootstrap-icons.css">
        <link rel="stylesheet" href="/vendor/bootstrap5/css/bootstrap.min.css">
        <link rel="stylesheet" href="/fonts/fonts.css">
        <script src="https://cdn.ckeditor.com/4.16.2/full-all/ckeditor.js"></script>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Lato:ital,wght@0,100;0,300;0,400;0,700;0,900;1,100;1,300;1,400;1,700;1,900&display=swap');
        </style>

        <link href="/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
        <link rel="stylesheet" href="/vendor/nestable/jquery.nestable.min.css">

        <#list styles as styleSource>
            <link rel="stylesheet" href="${styleSource}">
        </#list>

        ${extrastyle}

        <script src="//code.jivo.ru/widget/e7qXj0lhXn" async></script>


    </head>

    <body>

    <#nested>

    <#if footer=="true">
        <div class="container-fluid bg-blue">
            <footer class="container d-flex flex-wrap justify-content-between align-items-center py-3">
                <a href="#"><img class="logo-header" src="/img/White_logo.svg" alt=""></a>
                <p class="mb-0 text-white"><i class="bi bi-c-circle"></i> 2023 Calopsia, Inc</p>
            </footer>
        </div>
    </#if>


    ${extraScriptBefore}
    <script src="/vendor/jquery.js"></script>
    <script src="/vendor/jquery/jquery.js"></script>
    <#--    <script src="/vendor/bootstrap5/js/bootstrap.min.js"></script>-->
    <script src="/vendor/bootstrap5/js/bootstrap.bundle.min.js"></script>
    <script src="https://use.fontawesome.com/ffe0d7ed97.js"></script>
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>



    <script src="/vendor/jquery-easing/jquery.easing.min.js"></script>
        <!-- Page level plugins -->
    <script src="/vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="/vendor/datatables/dataTables.bootstrap4.min.js"></script>
        <!-- Page level custom scripts -->
    <script src="/js/datatables.js"></script>
    <!-- Custom scripts for all pages-->
    <script src="/js/sb-admin-2.min.js"></script>

    <script src="/vendor/nestable/jquery.nestable.min.js"></script>



    <#list scripts as scriptSource>
        <script src="${scriptSource}"></script>
    </#list>

    ${extraScriptAfter}

    </body>

    </html>

</#macro>