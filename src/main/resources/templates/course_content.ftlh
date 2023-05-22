<#import "partials/main.ftlh" as main />

<#if currentChapter.text??>
    <#assign extraScriptAfterMarkup>
        <script>

            var decodeEntities = (function () {
                // this prevents any overhead from creating the object each time
                var element = document.createElement('div');

                function decodeHTMLEntities(str) {
                    if (str && typeof str === 'string') {
                        // strip script/html tags
                        str = str.replace(/<script[^>]*>([\S\s]*?)<\/script>/gmi, '');
                        str = str.replace(/<\/?\w(?:[^"'>]|"[^"]*"|'[^']*')*>/gmi, '');
                        element.innerHTML = str;
                        str = element.textContent;
                        element.textContent = '';
                    }

                    return str;
                }

                return decodeHTMLEntities;
            })();

            $(document).ready(function () {
                let decodedContent = decodeEntities("${currentChapter.text}")
                let content = document.createElement("div");
                content.innerHTML = decodedContent

                $("#mainContent").append(content)
            })
        </script>
    </#assign>
</#if>



<@main.renderWith title="Calopsia | Course"
scripts=["/js/script.js","/js/course-materials.js"]
styles=["/css/style.css","/css/course-materials.css"]
extraScriptAfter=extraScriptAfterMarkup footer="false">
    <#assign security=JspTaglibs["http://www.springframework.org/security/tags"]/>

    <header class="sticky-top">
        <nav class="container nav navbar navbar-expand-lg navbar-dark fixed-top mt-3 full" id="mainNav">
            <div class="container d-flex justify-content-between">
                <button style="margin-bottom: 0.5rem" id="docs-sidebar-toggler"
                        class="docs-sidebar-toggler docs-sidebar-visible me-2 d-xl-none" type="button">
                    <span></span>
                    <span></span>
                    <span></span>
                </button>
                <a href="#"><img class="logo-header" src="/img/Black_logo.svg" alt=""></a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                        data-bs-target="#navbarResponsive"
                        aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                    Menu
                    <i class="fa fa-bars text-black fs-1" aria-hidden="true"></i>
                </button>

                <div class="collapse navbar-collapse bg-white" id="navbarResponsive">
                    <ul class="navbar-nav ms-auto py-0">
                        <li class="nav-item"><a class="nav-link text-black " href="/">Home</a></li>
                        <li class="nav-item"><a class="nav-link text-black active" href="/courses">All courses</a></li>
                        <li class="nav-item"><a class="nav-link text-black" href="#">Market</a></li>
                        <li class="nav-item"><a class="nav-link text-black" href="#">Contacts</a></li>
                        <li class="nav-item"><a class="nav-link text-black" href="#">About us</a></li>
                    </ul>
                    <@security.authorize access="! isAuthenticated()">
                        <ul class="navbar-nav ms-auto d-sm-inline py-4 py-lg-0 second">
                            <li class="menu-separator nav-item ">.</li>
                            <li class="nav-item d-sm-inline header-button"><a
                                        class="nav-link d-sm-inline text-black text-bold"
                                        href="/login">Login</a>
                            </li>
                            <li class="nav-item d-sm-inline header-button"><a
                                        class="nav-link d-sm-inline text-black header-button-purp"
                                        href="/login?register=true">Register</a></li>
                        </ul>
                    </@security.authorize>

                    <@security.authorize access="isAuthenticated()">
                        <p class="menu-separator d-sm-inline ms-auto">.</p>
                        <#if user??>
                            <a class="auth-user mx-3" href="/profile">
                                <p class=" username">${user.username}</p>
                                <img src="${avatarPath}${user.avatar}" alt="user avatar" class=" avatar">
                            </a>
                        </#if>

                        <form action="/logout" method="post" role="form">
                            <#if _csrf??>
                                <input type="hidden" name="${(_csrf.parameterName)!'csrf'}"
                                       value="${(_csrf.token)!'--no-token--'}"/>
                            </#if>

                            <div class="nav-item d-sm-inline  ms-3">
                                <button type="submit"
                                        class="d-sm-inline btn btn-outline-secondary btn-main text-white header-button-purp"
                                        href="#">Logout
                                </button>
                            </div>

                        </form>
                    </@security.authorize>

                </div>
            </div>
        </nav>
    </header>
    <main>
        <!--        Общий класс для материалы курса-->
        <div class="docs-wrapper">
            <div id="docs-sidebar" class="docs-sidebar">
                <div class="p-3">
                    <h5>${course.name!''}</h5>
                    <p>Progress: ${completedChapterIds?size!"0"}/${course.courseSections?size!'0'}</p>
                    <div class="progress" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                        <div class="progress-bar" style="width: ${studentProgress!"0"}%"></div>
                    </div>
                    <hr>
                </div>
                <nav id="docs-nav" class="docs-nav navbar">

                    <#list course.courseSections as chapter>
                        <ul class="section-items list-unstyled nav flex-column pb-3">
                            <li class="nav-item section-title"><a class="nav-link scrollto active" href="#section-${chapter.id}"><span
                                            class="theme-icon-holder me-2"><b>${chapter_index +1 }</b></span>${chapter.title}
                                </a></li>
                            <#if chapter.chapters??>
                                <#list chapter.chapters as c>
                                    <li class="nav-item section-item <#if false>passed</#if>"><a class="nav-link scrollto"
                                                                         href="#item-${chapter_index!""}-${c.id!""}">${c.title!""}</a>
                                    </li>
                                    <li class="nav-item section-item test"><i class="fa fa-file-pen"></i><a
                                                class="nav-link scrollto"
                                                href="#test-${c.test.id}"><i
                                                    class="bi bi-file-text w-100"></i>Lesson Test</a></li>
                                </#list>
                            </#if>
                        </ul>
                    </#list>


                </nav><!--//docs-nav-->
            </div><!--//docs-sidebar-->
            <div class="docs-content">
                <div class="container">
                    <#if course.courseSections??>
                    <#list course.courseSections as chapter>
                    <article class="docs-article" id="section-${chapter.id}">
                                                <header class="docs-header">
                                                    <h1 class="docs-heading">${chapter.title!""} <span class="docs-time">Last updated: ${course.dateOn}</span></h1>
                                                </header>


                                <#list chapter.chapters as c>
                                    <section class="docs-section" id="item-${chapter_index!""}-${c.id!""}">
                                        <h2 class="section-heading">${c.title!''}</h2>

                                        <#noautoesc>
                                            ${c.text!""}
                                        </#noautoesc>
                                    </section><!--//section-->

                                    <section class="docs-section" id="test-${c.test.id}">
                                        <h2 class="section-heading">Test</h2>
                                        <div class="container border p-4 mb-5">
                                            <form action="" method="post">
                                                <div class="row">
                                                    <#if c.test??>
                                                        <div class="col-12"><p class="fw-bold">${c.test.question!""}</p>
                                                            <div>
                                                                <input type="radio" name="box" id="${c.test.answers[0].id}" value="${c.test.answers[0].id}">
                                                                <input type="radio" name="box" id="${c.test.answers[1].id}" value="${c.test.answers[1].id}">
                                                                <input type="radio" name="box" id="${c.test.answers[2].id}" value="${c.test.answers[2].id}">
                                                                <input type="radio" name="box" id="${c.test.answers[3].id}" value="${c.test.answers[3].id}">
                                                                <label for="${c.test.answers[0].id}" class="box first">
                                                                    <div class="course"><span class="circle"></span> <span
                                                                                class="subject"> ${c.test.answers[0].text}</span>
                                                                    </div>
                                                                </label> <label for="${c.test.answers[1].id}" class="box second">
                                                                    <div class="course"><span class="circle"></span> <span
                                                                                class="subject">  ${c.test.answers[1].text} </span>
                                                                    </div>
                                                                </label> <label for="${c.test.answers[2].id}" class="box third">
                                                                    <div class="course"><span class="circle"></span> <span
                                                                                class="subject">  ${c.test.answers[2].text} </span>
                                                                    </div>
                                                                </label> <label for="${c.test.answers[3].id}" class="box forth">
                                                                    <div class="course"><span class="circle"></span> <span
                                                                                class="subject">  ${c.test.answers[3].text} </span>
                                                                    </div>
                                                                </label></div>
                                                        </div>
                                                    </#if>
                                                    <div class="col-12 mt-4">
                                                        <div class="d-flex justify-content-end">
                                                            <button class="btn btn-primary px-4 py-2 fw-bold" type="submit"> Check</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </section><!--//section-->

                                </#list>




                    </article>
                    </#list>
                    </#if>
                </div>
            </div>
        </div> <!--    Конец общего класса для материалы курса-->
    </main>



</@main.renderWith>