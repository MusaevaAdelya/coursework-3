<#import "partials/main.ftlh" as main />

<#assign extraStyleMarkup>

</#assign>

<@main.renderWith title="Calopsia | Error 404"
styles=["/css/error404.css"]
extrastyle=extraStyleMarkup>

    <div class="main-wrapper">
        <div class="error">
            <p class="error__num">4</p>
            <div class="error__moon"></div>
            <p class="error__num">4</p>
        </div>
        <div class="house">
            <div class="house__right">
                <div class="house__window"></div>
            </div>
            <div class="house__center">
                <div class="house__window"></div>
                <div class="house__window"></div>
            </div>
            <div class="house__left">
                <div class="house__window"></div>
                <div class="house__window"></div>
            </div>
            <div class="house__mini">
                <div class="house__window"></div>
                <div class="bridge"></div>
            </div>
            <div class="house__bottom">
                <div class="house__window"></div>
            </div>
        </div>
        <div class="graves">
            <div class="grave"></div>
            <div class="grave grave--mini"></div>
            <div class="grave grave--mini"></div>
        </div>
        <div class="bat bat--left">
            <div class="bat__right-wing"></div>
            <div class="bat__left-wing"></div>
        </div>
        <div class="bat bat--right">
            <div class="bat__right-wing"></div>
            <div class="bat__left-wing"></div>
        </div>
        <div class="ground-wrapper"></div>
        <div class="button-container">
            <p>Sorry! That page dosen't seem to exist</p><a class="button button--back" href="/">Go Back
                <div class="ghost">
                    <div class="ghost__hand"></div>
                    <div class="ghost__face"></div>
                    <div class="ghost__tail"></div>
                </div></a>
        </div>
    </div>


</@main.renderWith>