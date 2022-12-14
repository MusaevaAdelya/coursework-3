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
        <div class="container">
            <div class="row">
                <div class="col-lg-9">
                    <div class="d-lg-none">
                        <img class="rounded img-fluid"
                             src="https://media.istockphoto.com/photos/elearning-education-concept-learning-online-picture-id1290864946?b=1&k=20&m=1290864946&s=170667a&w=0&h=zZq7rG5McSptSIpEm9f8iTGd3Mrdkcslakr91T7qTYM="
                             alt="">
                    </div>
                    <div class="row">
                        <div class="col-lg-8">
                            <h2 class="text-bold">Adobe Premiere Pro</h2>
                            <div class="py-1">
                                <a class="motion-btn my-3 rounded  px-2 py-1" href="#">Motion-Design</a>
                                <a class="prog-btn my-3 rounded  px-2 py-1" href="#">Back-end developer</a>
                                <a class="motion-btn my-3 rounded  px-2 py-1" href="#">Motion-Design</a>
                            </div>
                            <br>
                            <p class="text-start">The modern JavaScript course for everyone! Master JavaScript with
                                projects,
                                challenges and theory. Many courses in one!</p>

                            <div>
                                <p class="text-bold purp-text h4">Initial requirements</p>
                                <ul class="text-capitalize">
                                    <li>strong english skills</li>
                                    <li>strong english skills</li>
                                    <li>strong english skills</li>
                                    <li>strong english skills</li>
                                    <li>strong english skills</li>
                                </ul>
                            </div>
                        </div>

                    </div>


                    <hr>


                    <div class="container mt-5 px-5 py-3 skills rounded text-center">
                        <p class="h4 text-start mb-3 purp-text my-2">What you will learn</p>
                        <div class="row row-cols-lg-2 row-cols-1">
                            <div class="col text-start">
                                <li>Become an advanced, confident, and modern JavaScript developer from scratch</li>
                            </div>
                            <div class="col text-start">
                                <li>Become an advanced, confident, and modern JavaScript developer from scratch</li>
                            </div>
                            <div class="col text-start">
                                <li>Become an advanced, confident, and modern JavaScript developer from scratch</li>
                            </div>
                            <div class="col text-start">
                                <li>Become an advanced, confident, and modern JavaScript developer from scratch</li>
                            </div>
                            <div class="col text-start">
                                <li>Become an advanced, confident, and modern JavaScript developer from scratch</li>
                            </div>
                            <div class="col text-start">
                                <li>Become an advanced, confident, and modern JavaScript developer from scratch</li>
                            </div>
                            <div class="col text-start">
                                <li>Become an advanced, confident, and modern JavaScript developer from scratch</li>
                            </div>
                        </div>
                    </div>


                    <br>
                    <hr>
                    <p class="h4 purp-text mt-3">Course program</p>
                    <p>21 sections • 320 lectures </p>
                    <div class="accordion" id="accordionPanelsStayOpenExample">
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="panelsStayOpen-headingOne">
                                <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                        data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true"
                                        aria-controls="panelsStayOpen-collapseOne">
                                    Welcome, Welcome, Welcome!
                                </button>
                            </h2>
                            <div id="panelsStayOpen-collapseOne" class="accordion-collapse collapse show"
                                 aria-labelledby="panelsStayOpen-headingOne">
                                <div class="accordion-body">
                                    <ul>
                                        <li>gg</li>
                                        <li>gg</li>
                                        <li>gg</li>
                                        <li>gg</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="panelsStayOpen-headingTwo">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                        data-bs-target="#panelsStayOpen-collapseTwo" aria-expanded="false"
                                        aria-controls="panelsStayOpen-collapseTwo">
                                    JavaScript Fundamentals – Part 1
                                </button>
                            </h2>
                            <div id="panelsStayOpen-collapseTwo" class="accordion-collapse collapse"
                                 aria-labelledby="panelsStayOpen-headingTwo">
                                <div class="accordion-body">
                                    <ul>
                                        <li>gg</li>
                                        <li>gg</li>
                                        <li>gg</li>
                                        <li>gg</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="panelsStayOpen-headingThree">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                        data-bs-target="#panelsStayOpen-collapseThree" aria-expanded="false"
                                        aria-controls="panelsStayOpen-collapseThree">
                                    JavaScript Fundamentals – Part 2
                                </button>
                            </h2>
                            <div id="panelsStayOpen-collapseThree" class="accordion-collapse collapse"
                                 aria-labelledby="panelsStayOpen-headingThree">
                                <div class="accordion-body">
                                    <ul>
                                        <li>gg</li>
                                        <li>gg</li>
                                        <li>gg</li>
                                        <li>gg</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="container mt-5">
                        <div class="row">
                            <div class="col-lg-8">
                                <a href="#" class="h3 purp-text teacher_name mb-4">Jonas Schmedtmann</a>
                                <br>
                                <a class="motion-btn rounded px-2 py-1 mt-4" href="#">Teacher</a>
                                <br>
                                <br>
                                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Accusantium ad assumenda
                                    commodi consectetur, ea eos illo, minima minus odio omnis perspiciatis, possimus
                                    quia
                                    repellat sed sequi sint tempore vel voluptatem?</p>
                            </div>
                            <div class="col-lg-4">
                                <img src="/img/Erbol.jpg" class="img-fluid rounded">
                            </div>
                        </div>
                    </div>


                    <hr>
                    <p class="h4 purp-text mt-5">Course rating: <b>4,7</b></p>
                    <div class="container">
                        <div class="row row-cols-lg-2 row-cols-1">
                            <div class="col">
                                <div class="otzyv">
                                    <hr>
                                    <div class="row">
                                        <div class="col">
                                            <a href="#" class="fw-bold purp-text h5">Blake L M.</a>
                                            <br>
                                            <i class="star">4.5</i>
                                            <i class="bi bi-star-fill star"></i>
                                            <i class="bi bi-star-fill star"></i>
                                            <i class="bi bi-star-fill star"></i>
                                            <i class="bi bi-star-half star"></i>
                                            <i class="bi bi-star star"></i>
                                        </div>
                                        <div class="col">
                                            <p class="text-end">20.02.22</p></div>
                                    </div>
                                    <p>Tl;dr: This course is great, I highly recommend it for anyone either completely
                                        unfamiliar, or even with some experience, with JavaScript that wants a comprehensive
                                        foundation of knowledge that they can be confident will</p>
                                </div>
                            </div>
                            <div class="col">
                                <div class="otzyv">
                                    <hr>
                                    <div class="row">
                                        <div class="col">
                                            <a href="#" class="fw-bold purp-text h5">Blake L M.</a>
                                            <br>
                                            <i class="star">4.5</i>
                                            <i class="bi bi-star-fill star"></i>
                                            <i class="bi bi-star-fill star"></i>
                                            <i class="bi bi-star-fill star"></i>
                                            <i class="bi bi-star-half star"></i>
                                            <i class="bi bi-star star"></i>
                                        </div>
                                        <div class="col">
                                            <p class="text-end">20.02.22</p></div>
                                    </div>
                                    <p>Tl;dr: This course is great, I highly recommend it for anyone either completely
                                        unfamiliar, or even with some experience, with JavaScript that wants a comprehensive
                                        foundation of knowledge that they can be confident will</p>
                                </div>
                            </div>
                            <div class="col">
                                <div class="otzyv">
                                    <hr>
                                    <div class="row">
                                        <div class="col">
                                            <a href="#" class="fw-bold purp-text h5">Blake L M.</a>
                                            <br>
                                            <i class="star">4.5</i>
                                            <i class="bi bi-star-fill star"></i>
                                            <i class="bi bi-star-fill star"></i>
                                            <i class="bi bi-star-fill star"></i>
                                            <i class="bi bi-star-half star"></i>
                                            <i class="bi bi-star star"></i>
                                        </div>
                                        <div class="col">
                                            <p class="text-end">20.02.22</p></div>
                                    </div>
                                    <p>Tl;dr: This course is great, I highly recommend it for anyone either completely
                                        unfamiliar, or even with some experience, with JavaScript that wants a comprehensive
                                        foundation of knowledge that they can be confident will</p>
                                </div>
                            </div>
                            <div class="col">
                                <div class="otzyv">
                                    <hr>
                                    <div class="row">
                                        <div class="col">
                                            <a href="#" class="fw-bold purp-text h5">Blake L M.</a>
                                            <br>
                                            <i class="star">4.5</i>
                                            <i class="bi bi-star-fill star"></i>
                                            <i class="bi bi-star-fill star"></i>
                                            <i class="bi bi-star-fill star"></i>
                                            <i class="bi bi-star-half star"></i>
                                            <i class="bi bi-star star"></i>
                                        </div>
                                        <div class="col">
                                            <p class="text-end">20.02.22</p></div>
                                    </div>
                                    <p>Tl;dr: This course is great, I highly recommend it for anyone either completely
                                        unfamiliar, or even with some experience, with JavaScript that wants a comprehensive
                                        foundation of knowledge that they can be confident will</p>
                                </div>
                            </div>
                            <div class="col">
                                <div class="otzyv">
                                    <hr>
                                    <div class="row">
                                        <div class="col">
                                            <a href="#" class="fw-bold purp-text h5">Blake L M.</a>
                                            <br>
                                            <i class="star">4.5</i>
                                            <i class="bi bi-star-fill star"></i>
                                            <i class="bi bi-star-fill star"></i>
                                            <i class="bi bi-star-fill star"></i>
                                            <i class="bi bi-star-half star"></i>
                                            <i class="bi bi-star star"></i>
                                        </div>
                                        <div class="col">
                                            <p class="text-end">20.02.22</p></div>
                                    </div>
                                    <p>Tl;dr: This course is great, I highly recommend it for anyone either completely
                                        unfamiliar, or even with some experience, with JavaScript that wants a comprehensive
                                        foundation of knowledge that they can be confident will</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <br>


                    <br>
                    <hr>
                    <p class="h4 purp-text">More courses from Jonas Schmedtmann</p>
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-4 mt-3">
                                <div class="card popular-cources shadow p-3 bg-white rounded">
                                    <img class="rounded"
                                         src="https://media.istockphoto.com/photos/elearning-education-concept-learning-online-picture-id1290864946?b=1&k=20&m=1290864946&s=170667a&w=0&h=zZq7rG5McSptSIpEm9f8iTGd3Mrdkcslakr91T7qTYM="
                                         alt="">
                                    <div class="py-3"><a class="prog-btn my-3 rounded  px-2 py-1" href="#">Back-end
                                            developer</a></div>
                                    <h4 class="text-black fw-bold">Web-design</h4>

                                    <p class="text-secondary fw-bolder">156 Students</p>

                                    <div class="btn-price d-flex justify-content-between">
                                        <a class="purp_button rounded text-white fw-bolder p-2" href="#">Start
                                            learning</a>
                                        <span class="fw-bolder purp-text  text-center">Free $0</span>
                                    </div>

                                </div>
                            </div>
                            <div class="col-lg-4 mt-3">
                                <div class="card popular-cources shadow p-3 bg-white rounded">
                                    <img class="rounded"
                                         src="https://media.istockphoto.com/photos/elearning-education-concept-learning-online-picture-id1290864946?b=1&k=20&m=1290864946&s=170667a&w=0&h=zZq7rG5McSptSIpEm9f8iTGd3Mrdkcslakr91T7qTYM="
                                         alt="">
                                    <div class="py-3"><a class="prog-btn my-3 rounded  px-2 py-1" href="#">Back-end
                                            developer</a></div>
                                    <h4 class="text-black fw-bold">Web-design</h4>

                                    <p class="text-secondary fw-bolder">156 Students</p>

                                    <div class="btn-price d-flex justify-content-between">
                                        <a class="purp_button rounded text-white fw-bolder p-2" href="#">Start
                                            learning</a>
                                        <span class="fw-bolder purp-text  text-center">Free $0</span>
                                    </div>

                                </div>
                            </div>
                            <div class="col-lg-4 mt-3">
                                <div class="card popular-cources shadow p-3 bg-white rounded">
                                    <img class="rounded"
                                         src="https://media.istockphoto.com/photos/elearning-education-concept-learning-online-picture-id1290864946?b=1&k=20&m=1290864946&s=170667a&w=0&h=zZq7rG5McSptSIpEm9f8iTGd3Mrdkcslakr91T7qTYM="
                                         alt="">
                                    <div class="py-3"><a class="prog-btn my-3 rounded  px-2 py-1" href="#">Back-end
                                            developer</a></div>
                                    <h4 class="text-black fw-bold">Web-design</h4>

                                    <p class="text-secondary fw-bolder">156 Students</p>

                                    <div class="btn-price d-flex justify-content-between">
                                        <a class="purp_button rounded text-white fw-bolder p-2" href="#">Start
                                            learning</a>
                                        <span class="fw-bolder purp-text  text-center">Free $0</span>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                    <br>
                    <br>
                    <div class="d-sm-block d-md-none sticky-bottom bg-white">
                        <p class="fw-bolder price text-center mt-3 h1">Beginner</p>
                        <div class="row justify-content-center">
                            <button class="buy-btn text-center rounded text-white mb-3 fw-bolder py-1" href="#">Roll In
                            </button>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 d-none d-lg-block info-block">
                    <div class="sticky-top-block">
                        <img class="img-fluid rounded"
                             src="https://media.istockphoto.com/photos/elearning-education-concept-learning-online-picture-id1290864946?b=1&k=20&m=1290864946&s=170667a&w=0&h=zZq7rG5McSptSIpEm9f8iTGd3Mrdkcslakr91T7qTYM="
                             alt="">
                        <p class="fw-bolder price mx-auto h2 text-center my-3">Beginner</p>
                        <div class="row justify-content-end">
                            <a class="buy-btn mx-auto w-75 rounded text-white fw-bolder py-1 text-center" href="#">Roll In</a>
                        </div>

                        <div class="row mt-3 px-4 text-end">
                            <div class="col-12 mb-4">
                                <i class="star">4.5</i>
                                <i class="bi bi-star-fill star"></i>
                            </div>
                            <div class="col-12">
                                <p>157 599 оценок</p>
                            </div>
                            <div class="col-12">
                                <p>707 028 студента</p>
                            </div>
                        </div>
                        <div class="rounded ">


                            <div class="rounded p-3 mt-2 text-end info-list">
                                <h5>
                                    The course includes
                                </h5>
                                <ul class="h5">
                                    <li>
                                        <b>52</b> lessons
                                    </li>
                                    <li>
                                        <b>178</b> tests
                                    </li>
                                </ul>
                                <br>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </main>


</@main.renderWith>