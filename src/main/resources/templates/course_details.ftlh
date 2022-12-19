<#import "partials/main.ftlh" as main />

<#assign extraStyleMarkup>

</#assign>

<@main.renderWith title="Calopsia | Course"
scripts=["/js/script.js"]
styles=["/css/style.css","/css/course.css"]
extrastyle=extraStyleMarkup>
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
        <div class="container">
            <div class="row">
                <div class="col-lg-9">
                    <div class="d-lg-none">
                        <img class="rounded img-fluid"
                             src="${coursesPath}${course.thumbNailPath}"
                             alt="">
                    </div>
                    <div class="row">
                        <div class="col-lg-8">
                            <h2 class="text-bold">${course.name}</h2>
                            <div class="py-1">
                                <a class="prog-btn my-3 rounded  px-2 py-1" href="#">${course.category.name}</a>
                            </div>
                            <br>
                            <p class="text-start"><#if course.description??>${course.description}</#if></p>

                            <div>
                                <p class="text-bold purp-text h4">Initial requirements</p>
                                <ul class="text-capitalize">
                                    <#list course.requirements as r>
                                        <li>${r}</li>
                                    </#list>

                                </ul>
                            </div>
                        </div>

                    </div>


                    <hr>


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


                    <br>
                    <hr>
                    <p class="h4 purp-text mt-3">Course program</p>
                    <#if course.courseSections??>
                        <div class="accordion" id="accordionPanelsStayOpenExample">
                            <#list course.courseSections as section>
                                <div class="accordion-item">
                                    <h2 class="accordion-header" id="panelsStayOpen-heading${section.id}">
                                        <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                                data-bs-target="#panelsStayOpen-collapse${section.id}" aria-expanded="true"
                                                aria-controls="panelsStayOpen-collapse${section.id}">
                                            ${section.title}
                                        </button>
                                    </h2>
                                    <div id="panelsStayOpen-collapse${section.id}" class="accordion-collapse collapse show"
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


                    <div class="container mt-5">
                        <div class="row">
                            <div class="col-lg-8">
                                <a href="#" class="h3 purp-text teacher_name mb-4">${course.teacher.username}</a>
                                <br>
                                <a class="motion-btn rounded px-2 py-1 mt-4" href="#">Teacher</a>
                                <br>
                                <br>
                                <p>${course.teacher.about}</p>
                            </div>
                            <div class="col-lg-4">
                                <img src="${avatarPath}${course.teacher.avatar}" class="img-fluid rounded">
                            </div>
                        </div>
                    </div>


                    <hr>
                    <p class="h4 purp-text mt-5">Course rating: <b>${course.ratingScore}</b></p>
                    <div class="container">
                        <div class="row row-cols-lg-2 row-cols-1">
                            <#list ratings as rating>
                                <div class="col">
                                    <div class="otzyv">
                                        <hr>
                                        <div class="row">
                                            <div class="col">
                                                <a href="#" class="fw-bold purp-text h5">${rating.user.username}</a>
                                                <br>
                                                <i class="star">${rating.rating}</i>
                                                <#list 1..(rating.rating) as star>
                                                    <i class="bi bi-star-fill star"></i>
                                                </#list>
                                                <#list 1..(5-rating.rating) as emptyStar>
                                                    <i class="bi bi-star star"></i>
                                                </#list>

                                            </div>
                                            <div class="col">
                                                <p class="text-end">${rating.dateOn}</p>
                                            </div>
                                        </div>
                                        <p>${rating.comment}</p>
                                    </div>
                                </div>
                            </#list>
                        </div>
                    </div>
                    <br>


                    <br>
                    <hr>
                    <p class="h4 purp-text">${course.teacher.username}</p>
                    <div class="container">
                        <div class="row">
                            <#list moreCourses as mc>
                                <div class="col-lg-4 mt-3">
                                    <div class="card popular-cources shadow p-3 bg-white rounded">
                                        <img class="rounded"
                                             src="https://media.istockphoto.com/photos/elearning-education-concept-learning-online-picture-id1290864946?b=1&k=20&m=1290864946&s=170667a&w=0&h=zZq7rG5McSptSIpEm9f8iTGd3Mrdkcslakr91T7qTYM="
                                             alt="">
                                        <div class="py-3">
                                            <a class="prog-btn my-3 rounded  px-2 py-1" href="#">
                                                ${mc.category.name}
                                            </a>
                                        </div>
                                        <h4 class="text-black fw-bold">${mc.name}</h4>

                                        <p class="text-secondary fw-bolder">${mc.users?size} Students</p>

                                        <div class="btn-price d-flex justify-content-between">
                                            <a class="purp_button rounded text-white fw-bolder p-2" href="#">Start
                                                learning</a>
                                            <span class="fw-bolder purp-text  text-center">Free</span>
                                        </div>
                                    </div>
                                </div>
                            </#list>


                        </div>
                    </div>
                    <br>
                    <br>
                    <div class="d-sm-block d-md-none sticky-bottom bg-white">
                        <p class="fw-bolder price text-center mt-3 h1">${course.level}</p>
                        <div class="row justify-content-center">
                            <button class="buy-btn text-center rounded text-white mb-3 fw-bolder py-1"
                                    href="/course/${course.id}/">Roll In
                            </button>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 d-none d-lg-block info-block">
                    <div class="sticky-top-block">
                        <img class="img-fluid rounded"
                             src="${coursesPath}${course.thumbNailPath}"
                             alt="">
                        <p class="fw-bolder price mx-auto h2 text-center my-3">${course.level}</p>
                        <div class="row justify-content-end">
                            <a class="buy-btn mx-auto w-75 rounded text-white fw-bolder py-1 text-center" href="#">Roll
                                In</a>
                        </div>

                        <div class="row mt-3 px-4 text-end">
                            <div class="col-12 mb-4">
                                <i class="star">${course.ratingScore}</i>
                                <i class="bi bi-star-fill star"></i>
                            </div>
                            <div class="col-12">
                                <p>${ratings?size} оценок</p>
                            </div>
                            <div class="col-12">
                                <p>${course.users?size} студента</p>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </main>


</@main.renderWith>