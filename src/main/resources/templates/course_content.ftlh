<#import "partials/main.ftlh" as main />

<@main.renderWith title="Calopsia | Course"
scripts=["/js/script.js","/js/course-materials.js"]
styles=["/css/style.css","/css/course-materials.css"]>
    <#assign security=JspTaglibs["http://www.springframework.org/security/tags"]/>

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
    <main>
        <!--        Общий класс для материалы курса-->
        <div class="course-materials container pt-5 mt-5">

            <div class="row pb-5">
                <!--        Начало основной страницы-->

                <div class="col-10">
                    <div class="course text-start ">

                        <div class="course-header text-center">
                            <h1 class="mt-3">${}</h1>
                        </div>

                        <div class="main-course-materials mt-3">
                            <div class="course-video">
                                <iframe width="100%" height="500"
                                        src="https://www.youtube.com/embed/nGfeSo52_8A"
                                        title="YouTube video player" frameborder="0" a
                                        llow="accelerometer; autoplay; clipboard-write;
                                    encrypted-media; gyroscope; picture-in-picture"
                                ></iframe>


                            </div>
                            <div class="course-training mt-5">
                                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ab adipisci aliquam aliquid
                                    assumenda
                                    atque blanditiis commodi consectetur cum cupiditate delectus dolor ea eius error et
                                    eum
                                    fuga,
                                    impedit incidunt ipsa ipsam laboriosam minima, modi molestias natus neque, nulla
                                    officiis quae
                                    quibusdam reiciendis reprehenderit ullam! Cupiditate illo inventore praesentium
                                    veritatis
                                    vero!</p>
                                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ab adipisci aliquam aliquid
                                    assumenda
                                    atque blanditiis commodi consectetur cum cupiditate delectus dolor ea eius error et
                                    eum
                                    fuga,
                                    impedit incidunt ipsa ipsam laboriosam minima, modi molestias natus neque, nulla
                                    officiis quae
                                    quibusdam reiciendis reprehenderit ullam! Cupiditate illo inventore praesentium
                                    veritatis
                                    vero!</p>
                                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ab adipisci aliquam aliquid
                                    assumenda
                                    atque blanditiis commodi consectetur cum cupiditate delectus dolor ea eius error et
                                    eum
                                    fuga,
                                    impedit incidunt ipsa ipsam laboriosam minima, modi molestias natus neque, nulla
                                    officiis quae
                                    quibusdam reiciendis reprehenderit ullam! Cupiditate illo inventore praesentium
                                    veritatis
                                    vero!</p>
                                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ab adipisci aliquam aliquid
                                    assumenda
                                    atque blanditiis commodi consectetur cum cupiditate delectus dolor ea eius error et
                                    eum
                                    fuga,
                                    impedit incidunt ipsa ipsam laboriosam minima, modi molestias natus neque, nulla
                                    officiis quae
                                    quibusdam reiciendis reprehenderit ullam! Cupiditate illo inventore praesentium
                                    veritatis
                                    vero!</p>
                                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ab adipisci aliquam aliquid
                                    assumenda
                                    atque blanditiis commodi consectetur cum cupiditate delectus dolor ea eius error et
                                    eum
                                    fuga,
                                    impedit incidunt ipsa ipsam laboriosam minima, modi molestias natus neque, nulla
                                    officiis quae
                                    quibusdam reiciendis reprehenderit ullam! Cupiditate illo inventore praesentium
                                    veritatis
                                    vero!</p>
                                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ab adipisci aliquam aliquid
                                    assumenda
                                    atque blanditiis commodi consectetur cum cupiditate delectus dolor ea eius error et
                                    eum
                                    fuga,
                                    impedit incidunt ipsa ipsam laboriosam minima, modi molestias natus neque, nulla
                                    officiis quae
                                    quibusdam reiciendis reprehenderit ullam! Cupiditate illo inventore praesentium
                                    veritatis
                                    vero!</p>
                                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ab adipisci aliquam aliquid
                                    assumenda
                                    atque blanditiis commodi consectetur cum cupiditate delectus dolor ea eius error et
                                    eum
                                    fuga,
                                    impedit incidunt ipsa ipsam laboriosam minima, modi molestias natus neque, nulla
                                    officiis quae
                                    quibusdam reiciendis reprehenderit ullam! Cupiditate illo inventore praesentium
                                    veritatis
                                    vero!</p>
                                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ab adipisci aliquam aliquid
                                    assumenda
                                    atque blanditiis commodi consectetur cum cupiditate delectus dolor ea eius error et
                                    eum
                                    fuga,
                                    impedit incidunt ipsa ipsam laboriosam minima, modi molestias natus neque, nulla
                                    officiis quae
                                    quibusdam reiciendis reprehenderit ullam! Cupiditate illo inventore praesentium
                                    veritatis
                                    vero!</p>

                            </div>


                        </div>
                        <hr>
                        <div class="test-section text-center mx-auto">
                            <#if completedChapterIds?seq_contains(currentChapterId)>
                                <img src="/img/completed.png" style="object-fit: contain; width: 100%;">
                            <#else>



                                <h2 class="header-text">Test</h2>
                                <div class="question">
                                    <p>How are you?</p>
                                </div>
                                <div class="answers  d-flex justify-content-between">
                                    <div class="column">
                                        <div class="answers-check">
                                            <input class="answers-check-input" type="radio" name="exampleRadios"
                                                   id="exampleRadios1" value="option1" checked>
                                            <label class="answers-check-label" for="exampleRadios1">
                                                Answer1
                                            </label>
                                        </div>
                                        <div class="answers-check">
                                            <input class="answers-check-input" type="radio" name="exampleRadios"
                                                   id="exampleRadios2" value="option2" checked>
                                            <label class="answers-check-label" for="exampleRadios2">
                                                Answer2
                                            </label>
                                        </div>
                                        <div class="answers-check">
                                            <input class="answers-check-input" type="radio" name="exampleRadios"
                                                   id="exampleRadios3" value="option3">
                                            <label class="answers-check-label" for="exampleRadios3">
                                                Answer3
                                            </label>
                                        </div>
                                        <div class="answers-check">
                                            <input class="answers-check-input" type="radio" name="exampleRadios"
                                                   id="exampleRadios4" value="option4" checked>
                                            <label class="answers-check-label" for="exampleRadios4">
                                                Answer4
                                            </label>
                                        </div>
                                        <div class="answers-check">
                                            <input class="answers-check-input" type="radio" name="exampleRadios"
                                                   id="exampleRadios5" value="option5">
                                            <label class="answers-check-label" for="exampleRadios5">
                                                Answer5
                                            </label>
                                        </div>
                                    </div>
                                    <div class="column">
                                        <div class="answers-check">
                                            <input class="answers-check-input" type="radio" name="exampleRadios"
                                                   id="exampleRadios6" value="option6" checked>
                                            <label class="answers-check-label" for="exampleRadios6">
                                                Answer6
                                            </label>
                                        </div>
                                        <div class="answers-check">
                                            <input class="answers-check-input" type="radio" name="exampleRadios"
                                                   id="exampleRadios7" value="option7">
                                            <label class="answers-check-label" for="exampleRadios7">
                                                Answer7
                                            </label>
                                        </div>
                                        <div class="answers-check">
                                            <input class="answers-check-input" type="radio" name="exampleRadios"
                                                   id="exampleRadios8" value="option8" checked>
                                            <label class="answers-check-label" for="exampleRadios8">
                                                Answer8
                                            </label>
                                        </div>
                                        <div class="answers-check">
                                            <input class="answers-check-input" type="radio" name="exampleRadios"
                                                   id="exampleRadios9" value="option9">
                                            <label class="answers-check-label" for="exampleRadios9">
                                                Answer9
                                            </label>
                                        </div>
                                        <div class="answers-check">
                                            <input class="answers-check-input" type="radio" name="exampleRadios"
                                                   id="exampleRadios10" value="option10">
                                            <label class="answers-check-label" for="exampleRadios10">
                                                Answer10
                                            </label>
                                        </div>
                                    </div>
                                </div>

                                <button class="test-check" type="submit">Check</button>
                            </#if>
                        </div>

                    </div>


                </div>
                <!--      Конец основной страницы-->

                <!--        ______________________________-->

                <!--        Боковое меню-->
                <div class="col-2 side-menu ">
                    <div class="header-side text-center d-flex justify-content-around">

                        <a href="#" class="course-name">${course.name}</a>

                    </div>

                    <div class="reviews-btn text-center mt-3 mb-3" id="reviews-btn">
                        <a href="/course/${course.id}">Add review</a>
                    </div>

                    <!--                Прогресс бар -->
                    <div class="progress mt-3 mb-3">
                        <div class="progress-bar" id="progress" role="progressbar"
                             style="width: ${studentProgress}%;"
                             aria-valuemax="100"></div>
                    </div>
                    <!--                Конец прогресс бар-->


                    <!--                Item меню-->
                    <div class="course-step">
                        <ul>
                            <#list course.courseSections as section>
                                <li><a href="#">${section.title}</a>
                                    <ul>
                                        <#list section.chapters as chapter>
                                            <li><#if completedChapterIds?seq_contains(chapter.id)>
                                                    <i class="bi bi-check text-success"></i>
                                                </#if>
                                                <a <#if chapter.id=currentChapterId>class="fw-bold text-success"</#if>
                                                   href="/course/${course.id}/content/${chapter.id}">${chapter.title}</a>
                                            </li>
                                        </#list>
                                    </ul>
                                </li>
                            </#list>

                        </ul>
                    </div>
                    <!--                Конец item меню-->
                </div>
                <!--        Конец бокового меню-->


            </div>

        </div>
        <!--    Конец общего класса для материалы курса-->
    </main>



</@main.renderWith>