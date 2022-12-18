<#import "partials/main.ftlh" as main />

<#assign extraScriptAfterMarkup>
    <script>
        $(document).ready(function () {
            <#if review??>
                <#if review="success">
                    Swal.fire({
                        icon: 'success',
                        title: 'Success',
                        text: 'your review was successfully added to the course "${course.name}"',
                    })
                </#if>
            </#if>

        })

    </script>
</#assign>

<@main.renderWith title="Calopsia | Course"
scripts=["/js/script.js","/js/course.js"]
styles=["/css/style.css","/css/course.css"]
extraScriptAfter=extraScriptAfterMarkup>
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
                            <a class="auth-user mx-3" href="#">
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
        <div class="course-header">
            <div class="row ">
                <div class="col-8">
                    <h2 class="fw-bold">${course.name}</h2>
                    <p class="header-desc"><#if course.description??>${course.description}</#if></p>
                    <div class="course-categories mt-4">
                        <a class="motion-btn my-3 mx-2 rounded  px-2 py-1 shadow-cat"
                           href="#">${course.category.name}</a>
                    </div>
                    <div class="d-flex justify-content-between">
                        <div class="course-level">
                            <p class="mt-4 mb-0 beginner">${course.level}</p>
                            <hr>
                        </div>

                        <div class="course-level">
                            <p class="mt-4 mb-0 ">${course.users?size} students</p>
                        </div>
                    </div>
                </div>
                <div class="col-4 mb-0 pb-0">
                    <img class="rounded img-fluid"
                         src="${coursesPath}${course.thumbNailPath}"
                         alt="">
                </div>
            </div>
        </div>

        <div class="container-block">
            <div class="course-info ">
                <div class="row">
                    <div class="col-8 ">
                        <div class="container mt-5 px-5 py-3 skills rounded text-center">
                            <p class="h4 text-start mb-3 purp-text my-2">What you will learn</p>
                            <div class="row row-cols-lg-2 row-cols-1">
                                <#list course.skills as skill>
                                    <div class="col text-start">
                                        <li>${skill}</li>
                                    </div>
                                </#list>

                            </div>
                        </div>
                        <hr>

                        <div class="initial-requirements mt-3">
                            <h2 class="header-text">Initial requirements</h2>
                            <ul class="text-capitalize text-start">
                                <#list course.requirements as r>
                                    <li>${r}</li>
                                </#list>

                            </ul>
                        </div>
                        <hr>
                        <div class="course-program" id="course-program">
                            <h2 class="header-text">Course program</h2>
                            <p class="course-program-header">${course.courseSections?size} sections • ${chaptersQty}
                                lectures</p>
                            <#if course.courseSections??>
                                <div class="accordion" id="accordionPanelsStayOpenExample">
                                    <#list course.courseSections as section>
                                        <div class="accordion-item">
                                            <h2 class="accordion-header" id="panelsStayOpen-heading${section.id}">
                                                <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                                        data-bs-target="#panelsStayOpen-collapse${section.id}"
                                                        aria-expanded="true"
                                                        aria-controls="panelsStayOpen-collapse${section.id}">
                                                    ${section.title}
                                                </button>
                                            </h2>
                                            <div id="panelsStayOpen-collapse${section.id}"
                                                 class="accordion-collapse collapse show"
                                                 aria-labelledby="panelsStayOpen-heading${section.id}">
                                                <div class="accordion-body">
                                                    <ul>
                                                        <#if section.chapters??>
                                                            <#list section.chapters as chapter>
                                                                <li>${chapter.title}</li>
                                                            </#list>
                                                        </#if>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </#list>
                                </div>
                            </#if>
                        </div>
                        <hr>
                        <div class="container mt-5">
                            <div class="row">
                                <div class="col-lg-8">
                                    <a href="#" class="teacher-name">${course.teacher.username}</a>
                                    <p class="teacher-btn rounded px-2 py-1 mt-2">Teacher</p>
                                    <p>${course.teacher.about}</p>
                                </div>
                                <div class="col-lg-4">
                                    <img src="${avatarPath}${course.teacher.avatar}" class="img-fluid rounded">
                                </div>
                            </div>
                        </div>

                        <div class="all-reviews mt-3 mb-4" id="all-reviews">
                            <div class="tab-pane fade active show" id="course-reviews" role="tabpanel"
                                 aria-labelledby="course-reviews-tab">
                                <h2 class="header-text">Reviews</h2>
                                <div class="cources-block">
                                    <#if ratings?size!=0>
                                        <div class="row mb-4">

                                            <#if (ratings?size>2)>
                                                <#list 0..1 as index>
                                                    <div class="col-sm-6">
                                                        <div class="otzyv">
                                                            <hr>
                                                            <div class="row">
                                                                <div class="col">
                                                                    <a href="#"
                                                                       class="fw-bold purp-text h5">${ratings[index].user.username}</a>
                                                                    <br>
                                                                    <i class="star">${ratings[index].rating}</i>
                                                                    <#list 1..(ratings[index].rating) as star>
                                                                        <i class="bi bi-star-fill star"></i>
                                                                    </#list>
                                                                    <#if (5-ratings[index].rating!=0)>
                                                                        <#list 1..(5-ratings[index].rating) as emptyStar>
                                                                            <i class="bi bi-star star"></i>
                                                                        </#list>
                                                                    </#if>

                                                                </div>
                                                                <div class="col">
                                                                    <p class="text-end">${ratings[index].dateOn}</p>
                                                                </div>
                                                            </div>
                                                            <p>${ratings[index].comment}</p>
                                                        </div>
                                                    </div>
                                                </#list>
                                            <#else>
                                                <#list ratings as c>
                                                    <div class="col-sm-6">
                                                        <div class="otzyv">
                                                            <hr>
                                                            <div class="row">
                                                                <div class="col">
                                                                    <a href="#"
                                                                       class="fw-bold purp-text h5">${c.user.username}</a>
                                                                    <br>
                                                                    <i class="star">${c.rating}</i>
                                                                    <#list 1..(c.rating) as star>
                                                                        <i class="bi bi-star-fill star"></i>
                                                                    </#list>
                                                                    <#if (5-c.rating!=0)>
                                                                        <#list 1..(5-c.rating) as emptyStar>
                                                                            <i class="bi bi-star star"></i>
                                                                        </#list>
                                                                    </#if>

                                                                </div>
                                                                <div class="col">
                                                                    <p class="text-end">${c.dateOn}</p></div>
                                                            </div>
                                                            <p>${c.comment}</p>
                                                        </div>
                                                    </div>
                                                </#list>
                                            </#if>
                                        </div>
                                        <#if (ratings?size>2) >
                                            <div class="collapse" id="collapse-reviews-block">
                                                <div class="row mb-4">
                                                    <#list 2..(ratings?size-1) as index>
                                                        <div class="col-sm-6">
                                                            <div class="otzyv">
                                                                <hr>
                                                                <div class="row">
                                                                    <div class="col">
                                                                        <a href="#"
                                                                           class="fw-bold purp-text h5">${ratings[index].user.username}</a>
                                                                        <br>
                                                                        <i class="star">${ratings[index].rating}</i>
                                                                        <#list 1..(ratings[index].rating) as star>
                                                                            <i class="bi bi-star-fill star"></i>
                                                                        </#list>
                                                                        <#if (5-ratings[index].rating!=0)>
                                                                            <#list 1..(5-ratings[index].rating) as emptyStar>
                                                                                <i class="bi bi-star star"></i>
                                                                            </#list>
                                                                        </#if>

                                                                    </div>
                                                                    <div class="col">
                                                                        <p class="text-end">${ratings[index].dateOn}</p>
                                                                    </div>
                                                                </div>
                                                                <p>${ratings[index].comment}</p>
                                                            </div>
                                                        </div>
                                                    </#list>
                                                </div>
                                            </div>
                                            <a class="btn btn-primary seeallreviewsbut" data-bs-toggle="collapse"
                                               href="#collapse-reviews-block" role="button" aria-expanded="false"
                                               aria-controls="collapse-reviews-block">See all reviews</a>
                                        </#if>

                                    </#if>

                                </div>

                            </div>
                        </div>

                        <#if studentProgress??>
                            <#if (studentProgress>=10)>
                                <div class="add-reviews" id="add-reviews">
                                    <form method="POST" action="/course/review" modelAttribute="reviewForm">
                                        <input name="comment" required type="text" class="comments-input"
                                               placeholder="Comment...">
                                        <input name="stars" required hidden id="commentStars">
                                        <input name="userId" hidden value="${user.id}">
                                        <input name="courseId" hidden value="${course.id}">
                                        <#if _csrf??>
                                            <input type="hidden" name="${(_csrf.parameterName)!'csrf'}"
                                                   value="${(_csrf.token)!'--no-token--'}"/>
                                        </#if>
                                        <button type="submit" class="comments-btn"><i class="bi bi-send"></i></button>
                                    </form>
                                    <div class="star-rating text-center">
                                        <p class="text-center text-secondary fw-bolder fs-5 mb-0">Rating</p>
                                        <button class="star-btn">&#9734</button>
                                        <button class="star-btn">&#9734</button>
                                        <button class="star-btn">&#9734</button>
                                        <button class="star-btn">&#9734</button>
                                        <button class="star-btn">&#9734</button>
                                        <p class="current-rating text-center fw-bold">0 of 5</p>
                                    </div>
                                </div>
                            </#if>
                        </#if>


                        <div class="more-course mt-3 mb-5">
                            <hr>
                            <h2 class="teacher-name mt-4">More course from ${course.teacher.username}</h2>

                            <div class="tab-pane fade active show" id="more-course-teacher" role="tabpanel"
                                 aria-labelledby="more-course-teacher-tab">
                                <div class="cources-block">
                                    <#if moreCourses?size!=0>
                                        <div class="row mb-4">

                                            <#if (moreCourses?size>2)>
                                                <#list 0..1 as index>
                                                    <div class="col-sm-6">
                                                        <div class="card popular-cources shadow p-3 bg-white rounded">
                                                            <img class="rounded"
                                                                 src="${coursesPath}${moreCourses[index].thumbNailPath}"
                                                                 alt="">
                                                            <div class="py-3"><a
                                                                        class="prog-btn my-3 rounded  px-2 py-1"
                                                                        href="#">${moreCourses[index].category.name}</a>
                                                            </div>
                                                            <h4 class="text-black fw-bold">${moreCourses[index].name}</h4>

                                                            <p class="text-secondary fw-bolder">${moreCourses[index].users?size}
                                                                Students</p>

                                                            <div class="btn-price d-flex justify-content-between">
                                                                <a class="purp_button rounded text-white fw-bolder p-2"
                                                                   href="#">Start
                                                                    learning</a>
                                                                <span class="fw-bolder purp-text  text-center">Free $0</span>
                                                            </div>

                                                        </div>
                                                    </div>
                                                </#list>
                                            <#else>
                                                <#list moreCourses as mc>
                                                    <div class="col-sm-6">
                                                        <div class="card popular-cources shadow p-3 bg-white rounded">
                                                            <img class="rounded"
                                                                 src="${coursesPath}${mc.thumbNailPath}"
                                                                 alt="">
                                                            <div class="py-3"><a
                                                                        class="prog-btn my-3 rounded  px-2 py-1"
                                                                        href="#">${mc.category.name}</a></div>
                                                            <h4 class="text-black fw-bold">${mc.name}</h4>

                                                            <p class="text-secondary fw-bolder">${mc.users?size}
                                                                Students</p>

                                                            <div class="btn-price d-flex justify-content-between">
                                                                <a class="purp_button rounded text-white fw-bolder p-2"
                                                                   href="#">Start
                                                                    learning</a>
                                                                <span class="fw-bolder purp-text  text-center">Free $0</span>
                                                            </div>

                                                        </div>
                                                    </div>
                                                </#list>
                                            </#if>
                                        </div>
                                        <#if (moreCourses?size>2) >
                                            <div class="collapse" id="collapse-cources-block">
                                                <div class="row mb-4">
                                                    <#list 2..(moreCourses?size-1) as index>
                                                        <div class="col-sm-6">
                                                            <div class="card popular-cources shadow p-3 bg-white rounded">
                                                                <img class="rounded"
                                                                     src="${coursesPath}${moreCourses[index].thumbNailPath}"
                                                                     alt="">
                                                                <div class="py-3"><a
                                                                            class="prog-btn my-3 rounded  px-2 py-1"
                                                                            href="#">${moreCourses[index].category.name}</a>
                                                                </div>
                                                                <h4 class="text-black fw-bold">${moreCourses[index].name}</h4>

                                                                <p class="text-secondary fw-bolder">${moreCourses[index].users?size}
                                                                    Students</p>

                                                                <div class="btn-price d-flex justify-content-between">
                                                                    <a class="purp_button rounded text-white fw-bolder p-2"
                                                                       href="#">Start
                                                                        learning</a>
                                                                    <span class="fw-bolder purp-text  text-center">Free $0</span>
                                                                </div>

                                                            </div>
                                                        </div>
                                                    </#list>
                                                </div>
                                            </div>
                                            <a class="btn btn-primary seeallcourcesbut" data-bs-toggle="collapse"
                                               href="#collapse-cources-block" role="button" aria-expanded="false"
                                               aria-controls="collapse-cources-block">See all reviews</a>
                                        </#if>

                                    </#if>

                                </div>

                            </div>
                        </div>

                    </div>

                    <div class="col-4 course-card">
                        <p class="course-price mb-0">Free 0$</p>
                        <hr>
                        <div class="course-rating text-center mt-2 mb-3">
                            <i class="star">${course.ratingScore?string["0.#"]}</i>
                            <#list 1..(course.ratingScore?floor) as star>
                                <i class="bi bi-star-fill star"></i>
                            </#list>
                            <#if (5-course.ratingScore?floor!=0)>
                                <#list 1..(5-course.ratingScore?floor) as emptyStar>
                                    <i class="bi bi-star star"></i>
                                </#list>
                            </#if>
                        </div>
                        <#if studentProgress??>
                            <div class="progress mt-3 mb-3" id="progress-t">
                                <div class="progress-bar" id="progress" role="progressbar"
                                     style="width: ${studentProgress}%;"
                                     aria-valuemax="100">${studentProgress}%
                                </div>
                            </div>
                        <#else>
                            <button type="submit" class="roll-in-btn mx-auto" id="roll-in">Roll in</button>
                        </#if>


                        <div class="card-info">
                            <p>The course includes</p>
                            <ul>
                                <li>${chaptersQty} lessons</li>
                                <li>${chaptersQty} tests</li>
                            </ul>
                        </div>
                        <a href="#course-program" class="course-program-btn ">Course program</a>

                    </div>
                </div>

            </div>
        </div>
    </main>


</@main.renderWith>