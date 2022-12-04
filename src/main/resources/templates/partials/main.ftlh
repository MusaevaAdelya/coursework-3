<#macro renderWith title="Calopsia" scripts=[] styles=[]>
<#assign security=JspTaglibs["http://www.springframework.org/security/tags"]/>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${title}</title>
        <link rel="stylesheet" href="/vendor/bootstrap-icons/bootstrap-icons.css">
        <link rel="stylesheet" href="/vendor/bootstrap5/css/bootstrap.min.css">
        <link rel="stylesheet" href="/fonts/fonts.css">
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Lato:ital,wght@0,100;0,300;0,400;0,700;0,900;1,100;1,300;1,400;1,700;1,900&display=swap');
        </style>

        <#list styles as styleSource>
            <link rel="stylesheet" href="${styleSource}">
        </#list>

    </head>

    <body>

    <#nested>

    <script src="/vendor/jquery.js"></script>
    <script src="/vendor/bootstrap5/js/bootstrap.min.js"></script>
    <script src="https://use.fontawesome.com/ffe0d7ed97.js"></script>


    <#list scripts as scriptSource>
        <script src="${scriptSource}"></script>
    </#list>

    </body>

    </html>

</#macro>