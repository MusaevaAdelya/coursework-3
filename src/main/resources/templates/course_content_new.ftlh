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
        <div class="docs-wrapper">
            <div id="docs-sidebar" class="docs-sidebar">
                <div class="p-3">
                    <h5>${course.name}</h5>
                    <p>Progress: 3/23</p>
                    <div class="progress" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                        <div class="progress-bar" style="width: ${studentProgress!0}%;"></div>
                    </div>
                    <hr>
                </div>
                <nav id="docs-nav" class="docs-nav navbar">

                    <#list course.courseSections as section>
                        <ul class="section-items list-unstyled nav flex-column pb-3">
                            <li class="nav-item section-title"><a class="nav-link scrollto active" href="#section"><span
                                            class="theme-icon-holder me-2"><b>1</b></span>${section.title}</a></li>
                            <#list section.chapters as chapter>
                                <li class="nav-item section-item <#if chapter.id=(currentChapter.id)> passed </#if> ">
                                    <a class="nav-link" href="/course/${course.id}/content/${chapter.id}">
                                        ${chapter.title}
                                        <#if completedChapterIds?seq_contains(chapter.id)>
                                            <i class="bi bi-check text-success"></i>
                                        </#if>
                                    </a>
                                </li>
                            </#list>

                        </ul>
                    </#list>

                </nav><!--//docs-nav-->

            </div><!--//docs-sidebar-->
            <div class="docs-content">
                <div class="container">
                    <article class="docs-article" id="section">
                        <header class="docs-header">
                            <h1 class="docs-heading">${currentChapter.title}</h1>
                        </header>
                        <section class="docs-section">
                            <#noautoesc>
                                ${currentChapter.text!""}
                            </#noautoesc>
                        </section><!--//section-->


                        <#if studentProgress??>
                            <#if currentChapter.test??>
                                <section class="docs-section">
                                    <#if completedChapterIds?seq_contains(currentChapter.id)>
                                        <img src="/img/completed.png" style="object-fit: contain; width: 100%;">

                                    <#else>

                                        <h2 class="section-heading">Test</h2>
                                        <div class="container border p-4 mb-5">
                                            <div class="row">
                                                <div class="col-12">
                                                    <p class="fw-bold">${currentChapter.test.question}</p>
                                                    <div>
                                                        <input type="radio" name="box" id="one">
                                                        <input type="radio" name="box" id="two">
                                                        <input type="radio" name="box" id="three">
                                                        <input type="radio" name="box" id="four">

                                                        <label for="one" class="box first">
                                                            <div class="course"><span class="circle"></span> <span class="subject">${currentChapter.test.answers[0].text}</span>
                                                            </div>
                                                        </label>


                                                        <label for="two" class="box second">
                                                            <div class="course"><span class="circle"></span> <span class="subject">${currentChapter.test.answers[1].text}
                                                    </span>
                                                            </div>

                                                        </label>


                                                        <label for="three" class="box third">
                                                            <div class="course"><span class="circle"></span> <span class="subject">${currentChapter.test.answers[2].text}</span>
                                                            </div>

                                                        </label>

                                                        <label for="four" class="box forth">
                                                            <div class="course"><span class="circle"></span> <span class="subject">${currentChapter.test.answers[3].text}</span>
                                                            </div>
                                                        </label>

                                                    </div>
                                                </div>
                                                <div class="col-12 mt-4">
                                                    <div class="d-flex justify-content-end">
                                                        <button class="btn btn-primary px-4 py-2 fw-bold"> Check</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </#if>
                                </section>
                            </#if>
                        </#if>



                    </article>
                </div>
            </div>
        </div>
    </main>



</@main.renderWith>