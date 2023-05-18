<#import "partials/main.ftlh" as main />

<@main.renderWith title="Calopsia | Main"
scripts=["/js/script.js"]
styles=["/css/style.css"]>
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
                        <li class="nav-item"><a class="nav-link text-black active" href="/">Home</a></li>
                        <li class="nav-item"><a class="nav-link text-black " href="/courses">All courses</a></li>
                        <li class="nav-item"><a class="nav-link text-black" href="#">Market</a></li>
                        <li class="nav-item"><a class="nav-link text-black" href="#">Contacts</a></li>
                        <li class="nav-item"><a class="nav-link text-black" href="#">About us</a></li>
                        <@security.authorize access="isAuthenticated()">
                            <#if user.role == "ADMIN">
                                <li class="nav-item"><a class="nav-link text-black" href="/admin/users">Admin panel</a></li>
                            </#if>
                        </@security.authorize>
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
        <div class="main-block d-flex align-items-center">
            <div class="container">
                <div class="col-lg-6 text-c">
                    <h1 class="hero-text text-size text-start">
                        Anywhere, anytime, <br>
                        Learn what you want, <br>
                        from any device <br>
                    </h1>
                    <div class="w-75">
                        <p class="hero-sub-text text-start fs-5 mt-3">“Yesterday is history, tomorrow is a mystery, but
                            today is a gift. That is why it is called the present.”</p>
                        <p class="hero-sub-text text-end italic fs-6">- Master Oogway</p>
                    </div>


                    <div class="input-group mb-3 mt-5 search-input">
                        <i class="b"></i>
                        <input type="text" class="form-control input-main-page border-0" aria-label="searchInput"
                               placeholder="Course titles or keywords">
                        <button class="btn btn-outline-secondary dropdown-toggle btn-categories" type="button"
                                data-bs-toggle="dropdown" aria-expanded="false">Categories
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="#">1</a></li>
                            <li><a class="dropdown-item" href="#">2</a></li>
                            <li><a class="dropdown-item" href="#">3</a></li>
                        </ul>
                        <button class="btn btn-outline-secondary btn-main text-white" type="button" id="button-addon2">
                            Search
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <div class="courses-block mt-5 py-5">
            <div class="container">
                <h2 class="text-center"><b>Our most popular courses</b></h2>
                <hr class="hr mx-auto mb-5">

                <div class="row">
                    <#if courses??>
                        <#list courses as course>
                            <div class="col-lg-3 my-3">
                                <div class="card popular-cources shadow p-3 bg-white rounded">
                                    <img class="rounded"
                                         src="${coursesPath}${course.thumbNailPath}"
                                         alt="">
                                    <div class="py-3"><a class="design-btn my-3 rounded  px-2 py-1"
                                                         href="#">${course.category.name}</a>
                                    </div>
                                    <h4 class="text-black fw-bold">${course.name}</h4>

                                    <p class="text-secondary fw-bolder">${course.users?size} Students</p>

                                    <div class="btn-price d-flex justify-content-between">
                                        <a class="purp_button rounded text-white fw-bolder p-2"
                                           href="/course/${course.id}">Start
                                            learning</a>
                                        <span class="fw-bolder purp-text  text-center"><i
                                                    class="bi bi-star-fill text-warning"></i>${course.ratingScore?string["0.#"]}</span>
                                    </div>

                                </div>
                            </div>
                        </#list>
                    </#if>
                </div>
            </div>
            <div class="text-center mt-5">
                <a class="fw-bolder view-all text-center mt-5 mx-auto py-3 px-5" href="/courses">View All</a>
            </div>
        </div>
        </div>
        <div class="students-block py-5">
            <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel" data-bs-touch="true"
                 data-bs-interval="5000">
                <div class="carousel-indicators">
                    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0"
                            class="active indi-button" aria-current="true" aria-label="Slide 1"></button>
                    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1"
                            class="indi-button" aria-label="Slide 2"></button>
                    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2"
                            class="indi-button" aria-label="Slide 3"></button>
                </div>
                <div class="container">
                    <div class="col-12">
                        <h2 class="fw-bold text-white mb-0 fs-2">Our student voice</h2>
                        <hr class="hr-wt">
                    </div>
                </div>
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <div class="container mb-2 pb-5">
                            <div class="row d-flex justify-content-center">

                                <div class="col col-sm-12 col-md-6 text-c">

                                    <p class="fw-bold text-white mb-3 mt-0 fs-5">“Excellent progression of material
                                        with...”</p>


                                    <p class="text-white mb-5 fs-5">Excellent progression of material with clear
                                        examples.
                                        <br>
                                        Format allows for replay and review for topics that require greater
                                        reinforcement.
                                        <br>
                                        Chapter sections are sized about right to learning and testing purpouses.</p>

                                    <p class="fw-bold text-white fs-5">Ilya Ugai</p>
                                    <p class="text-white fs-5">Bishkek , Kyrgyzstan</p>

                                </div>

                                <div class="col col-sm-12 col-md-6 text-center">
                                    <img class="image-student"
                                         src="/img/student1.jpg"
                                         alt="" srcset="">
                                </div>

                            </div>
                        </div>
                    </div>
                    <div class="carousel-item">
                        <div class="container mb-5 pb-5">
                            <div class="row d-flex justify-content-center">

                                <div class="col col-sm-12 col-md-6 text-c">

                                    <p class="fw-bold text-white mb-3 mt-0 fs-5">“Excellent progression of material
                                        with...”</p>


                                    <p class="text-white mb-5 fs-5">Excellent progression of material with clear
                                        examples.
                                        <br>
                                        Format allows for replay and review for topics that require greater
                                        reinforcement.
                                        <br>
                                        Chapter sections are sized about right to learning and testing purpouses.</p>

                                    <p class="fw-bold text-white fs-5">Aidar Toktorbaev</p>
                                    <p class="text-white fs-5">Bishkek , Kyrgyzstan</p>

                                </div>

                                <div class="col col-sm-12 col-md-6 text-center">
                                    <img class="image-student"
                                         src="/img/student2.jpg"
                                         alt="" srcset="">
                                </div>

                            </div>
                        </div>
                    </div>
                    <div class="carousel-item">
                        <div class="container mb-5 pb-5">
                            <div class="row d-flex justify-content-center">

                                <div class="col col-sm-12 col-md-6 text-c">

                                    <p class="fw-bold text-white mb-3 mt-0 fs-5">“Excellent progression of material
                                        with...”</p>


                                    <p class="text-white mb-5 fs-5">Excellent progression of material with clear
                                        examples.
                                        <br>
                                        Format allows for replay and review for topics that require greater
                                        reinforcement.
                                        <br>
                                        Chapter sections are sized about right to learning and testing purpouses.</p>

                                    <p class="fw-bold text-white fs-5">Nikon</p>
                                    <p class="text-white fs-5">Bishkek , Kyrgyzstan</p>

                                </div>

                                <div class="col col-sm-12 col-md-6 text-center">
                                    <img class="image-student"
                                         src="/img/student3.jpg"
                                         alt="" srcset="">
                                </div>

                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>

    </main>



</@main.renderWith>