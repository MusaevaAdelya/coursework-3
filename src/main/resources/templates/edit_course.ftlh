<#import "partials/main.ftlh" as main />

<@main.renderWith title="Calopsia | Edit Course"
scripts=["/js/script.js","/js/edit_course.js"]
styles=["/css/style.css","/css/edit-course.css",
"/css/progress-style.css"]
footer="false">
    <#assign security=JspTaglibs["http://www.springframework.org/security/tags"]/>
    <div id="element">
        <div class="overflow"></div>
    </div>
    <header>
        <nav class="container nav navbar navbar-expand-lg navbar-dark fixed-top mt-3" id="mainNav">
            <div class="container d-flex justify-content-between">
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



    <main class="container-fluid min-vh-100-minus-header  pt-nav">
        <div class="categories-create flex-shrink-0 p-3 scrollarea" style="width: 280px;">
            <img src="${coursesPath}${course.thumbNailPath}" class="img-fluid rounded img-course w-100" alt="">
            <div class="mt-2">
                <!-- Здесь статусы курса, показываться будет один из них -->
                <!-- <span class="status-course success my-3 rounded px-2 py-1" >Published</span> -->
                <span class="status-course gray my-3 rounded px-2 py-1">Archive</span>
                <!-- <span class="status-course alert my-3 rounded px-2 py-1" >Error</span> -->
            </div>
            <a href="/" class="d-flex pb-3 mt-2 link-dark text-decoration-none">
                <span class="fs-5 fw-semibold">${course.name}</span>
            </a>
            <a name="" id="" class="btn btn-outline-primary mb-3 btn-max-width" href="#" role="button">Edit</a>
            <ul class="list-unstyled ps-0 pt-2 border-top">
                <h5>Menu</h5>
                <#list course.courseSections as section>
                    <li class="mb-1">
                        <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
                                data-bs-toggle="collapse" data-bs-target="#dashboard-collapse${section.id}"
                                aria-expanded="true">
                            ${section.title}
                        </button>
                        <div class="collapse" id="dashboard-collapse${section.id}">
                            <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                                <#list section.chapters as chapter>
                                    <li><a href="/course/${course.id}/edit/${chapter.id}"
                                           class="link-dark d-inline-flex text-decoration-none rounded">
                                            ${chapter.title}</a>
                                    </li>
                                </#list>
                            </ul>
                        </div>
                    </li>
                </#list>

            </ul>
        </div>


        <div class="col p-3 shadow bg-white scrollarea categories-create">
            <form method="POST" action="/course/${course.id}/edit/${chapter.id}"
                  modelAttribute="editChapterForm" id="editChapterForm">

                <#if _csrf??>
                    <input type="hidden" name="${(_csrf.parameterName)!'csrf'}"
                           value="${(_csrf.token)!'--no-token--'}"/>
                </#if>
                <input hidden id="textHtml" name="text">
                <input hidden name="chapterId" value="${chapter.id}">

                <div id="content-description" class="content-create">
                    <input type="text" id="LessonNametext" readonly
                           class="LessonNameText" value="${chapter.title}">
                    <hr>

                    <div style="width: 100%;">
                        <textarea name="editor" id="editor"></textarea>
                    </div>

                    <hr>

                    <form>

                    </form>
                    <h2 class="mb-5 mt-4">Create test</h2>

                    <div class="test-section mb-5 mt-3">
                        <input type="text" name="question" id="question" placeholder="Write question" class="question">
                        <div class="test d-flex justify-content-between">
                            <div>
                                <input type="radio" name="correct" id="test1">
                                <input type="text" name="answer" data-radio="#test1" class="answer-input test-input"
                                       placeholder="answer">
                            </div>
                            <div>
                                <button class="btn remove-item ">
                                    <i class="bi bi-trash3 text-danger"></i>
                                </button>

                            </div>
                        </div>
                        <div class="test d-flex justify-content-between">
                            <div>
                                <input type="radio" name="correct" id="test2">
                                <input type="text" name="answer" data-radio="#test2" class="answer-input test-input"
                                       placeholder="answer">
                            </div>
                            <div>
                                <button class="btn remove-item ">
                                    <i class="bi bi-trash3 text-danger"></i>
                                </button>

                            </div>
                        </div>
                        <div class="test d-flex justify-content-between">
                            <div>
                                <input type="radio" name="correct" id="test3">
                                <input type="text" name="answer" data-radio="#test3" class="answer-input test-input"
                                       placeholder="answer">
                            </div>
                            <div>
                                <button class="btn remove-item ">
                                    <i class="bi bi-trash3 text-danger"></i>
                                </button>

                            </div>
                        </div>
                        <div class="test d-flex justify-content-between">
                            <div>
                                <input type="radio" name="correct" id="test4">
                                <input type="text" name="answer" data-radio="#test4" class="answer-input test-input"
                                       placeholder="answer">
                            </div>
                            <div>
                                <button class="btn remove-item ">
                                    <i class="bi bi-trash3 text-danger"></i>
                                </button>

                            </div>
                        </div>
                        <#--                    <div class="test ps-0">-->
                        <#--                        <input class="add-answer w-100 h-100 bg-transparent border-0 text-start ps-2" type="button"-->
                        <#--                               value="Add answer">-->
                        <#--                    </div>-->

                    </div>

                    <button id="saveBtn" class="save-btn" type="submit">Save</button>
                </div>

            </form>


        </div>
        <script>
            CKEDITOR.replace('editor', {
                filebrowserUploadMethod: 'form',
                filebrowserUploadUrl: '/files/courses',
                debug: true,
                filebrowserImageUploadMethod: 'form',
                filebrowserUploadResponse: function(responseData) {
                    var response = JSON.parse(responseData);
                    return {
                        "url": response.url,
                        "name": response.name,
                        "filename": response.name
                    };
                }
            });

        </script>


    </main>


</@main.renderWith>