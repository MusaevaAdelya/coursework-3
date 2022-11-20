<#macro renderWith title="Calopsia" scripts=[] styles=[]>
<#assign security=JspTaglibs["http://www.springframework.org/security/tags"]/>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${title}</title>
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


    <header>
        <nav class="container nav navbar navbar-expand-lg navbar-dark fixed-top mt-3" id="mainNav">
            <div class="container d-flex justify-content-between">
                <a href="#"><img class="logo-header" src="/img/Black_logo.svg" alt=""></a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                        data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false"
                        aria-label="Toggle navigation">
                    Menu
                    <i class="fa fa-bars text-black fs-1" aria-hidden="true"></i>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav  ms-auto py-4 py-lg-0">
                        <li class="nav-item"><a class="nav-link text-black active" href="index.html#">Home</a></li>
                        <li class="nav-item"><a class="nav-link text-black" href="#">All courses</a></li>
                        <li class="nav-item"><a class="nav-link text-black" href="#">Free courses</a></li>
                        <li class="nav-item"><a class="nav-link text-black" href="#">Contacts</a></li>
                        <li class="nav-item"><a class="nav-link text-black" href="#">About us</a></li>
                    </ul>

                    <@security.authorize access="! isAuthenticated()">
                        <ul class="navbar-nav ms-auto d-sm-inline py-4 py-lg-0">
                            <li class="menu-separator nav-item d-sm-inline ">.</li>
                            <li class="nav-item d-sm-inline "><a class="nav-link d-sm-inline text-black text-bold"
                                    href="#">Login</a></li>
                            <li class="nav-item d-sm-inline "><a class="nav-link d-sm-inline text-black header-button-purp"
                                    href="#">Register</a></li>

                        </ul>
                    </@security.authorize>

                    <@security.authorize access="isAuthenticated()">
                        <p class="menu-separator d-sm-inline ms-auto">.</p>
                        <#if user??>
                            <a class="auth-user mx-3" href="#">
                                <p class=" username">${user.username}</p>
                                <img src="${avatarPath}${user.avatar}" alt="user avatar" class=" avatar">
                            </a>
                        </#if>

                        <div class="nav-item d-sm-inline  ms-3"><a class="nav-link d-sm-inline text-black header-button-purp"
                                                                   href="#">Logout</a></div>
                    </@security.authorize>

                </div>

            </div>
        </nav>

    </header>

    <#nested>

    <script src="/vendor/bootstrap5/js/bootstrap.min.js"></script>
    <script src="https://use.fontawesome.com/ffe0d7ed97.js"></script>

    <#list scripts as scriptSource>
        <script src="${scriptSource}"></script>
    </#list>

    </body>

    </html>

</#macro>