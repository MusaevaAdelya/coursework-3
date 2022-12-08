<#import "partials/main.ftlh" as main />

<#assign extraStyleMarkup>

</#assign>

<@main.renderWith title="Calopsia | Catalog"
scripts=["/js/script.js","/js/catalog.js"]
styles=["/css/style.css","/css/catalog.css"]
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
                        <li class="nav-item"><a class="nav-link text-black active" href="/">Home</a></li>
                        <li class="nav-item"><a class="nav-link text-black " href="">All courses</a></li>
                        <li class="nav-item"><a class="nav-link text-black" href="#">Market</a></li>
                        <li class="nav-item"><a class="nav-link text-black" href="#">Contacts</a></li>
                        <li class="nav-item"><a class="nav-link text-black" href="#">About us</a></li>
                    </ul>
                    <@security.authorize access="! isAuthenticated()">
                        <ul class="navbar-nav ms-auto d-sm-inline py-4 py-lg-0 second">
                            <li class="menu-separator nav-item ">.</li>
                            <li class="nav-item d-sm-inline header-button"><a
                                        class="nav-link d-sm-inline text-black text-bold"
                                        href="#">Login</a>
                            </li>
                            <li class="nav-item d-sm-inline header-button"><a
                                        class="nav-link d-sm-inline text-black header-button-purp"
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

    <main class="pt-top">

        <div class="courses container">
            <button class="filter-menu-button filter-menu d-lg-none fixed-top" type="button" data-bs-toggle="offcanvas"
                    data-bs-target="#small-filter" aria-controls="small-filter">
                <i class="bi bi-filter"></i>
            </button>
            <div class="row">

                <form action="/courses" method="get" role="form" modelAttribute="catalogForm">
                    <!--            Начало фильтра-->
                    <div class="col-lg-3 pt-3 h-75  d-sm-none d-md-none d-lg-block filter-menu-none">


                        <!--                Поиск по ключевому слову-->

                        <div class="input-group search-input container mb-3">
                            <i class="b"></i>
                            <input type="text" class="form-control input-main-page border-0" aria-label="searchInput"
                                   placeholder="Course titles or keywords">
                            <button class="btn btn-outline-secondary btn-main text-white" type="button"
                                    id="button-addon2">
                                Search
                            </button>
                        </div>
                        <!--                Конец поиска-->

                        <!--                По диапазону цены -->

                        <div class="wrapper">
                            <p class="text-center text-secondary fw-bolder fs-5">Price</p>
                            <div class="price-input">
                                <!--                        Минимальное поле ввода-->
                                <div class="field">
                                    <span>Min</span>
                                    <input type="number" class="input-min" value="0">
                                </div>
                                <div class="separator">-</div>
                                <!--                        Максимальное поле ввода-->
                                <div class="field">
                                    <span>Max</span>
                                    <input type="number" class="input-max" value="1000">
                                </div>
                            </div>
                            <!--                    Конец полей ввода-->

                            <!--                    Начало слайдера-->
                            <div class="slider">
                                <div class="progress-filter"></div>
                            </div>
                            <div class="range-input">
                                <input type="range" class="range-min" min="0" max="1000" value="0" step="10">
                                <input type="range" class="range-max" min="0" max="1000" value="999" step="10">
                            </div>
                        </div>
                        <!--                Конец слайдера-->
                        <!--Конец диапазона цены-->


                        <!--                Сортировка по рейтингу-->

                        <div class="wrapper mt-2">
                            <p class="text-center text-secondary fw-bolder fs-5">Rating</p>

                            <div class="star-rating text-center">
                                <button class="star">&#9734</button>
                                <button class="star">&#9734</button>
                                <button class="star">&#9734</button>
                                <button class="star">&#9734</button>
                                <button class="star">&#9734</button>
                            </div>

                            <p class="current-rating text-center fw-bold">0 of 5</p>
                        </div>
                        <!--        Конец сортировки по рейтингу -->

                        <!--                Уровни сложности-->
                        <div class="wrapper mt-2">
                            <p class="text-center text-secondary fw-bolder fs-5">Levels</p>

                            <div class="levels">
                                <div class="row">
                                    <div class="col">
                                        <div class="level-checkbox">
                                            <input type="checkbox" id="AllLevel" value="AllLevel"
                                                   class="checkbox-level">
                                            <label class="label-level" for="AllLevel">All level</label>
                                        </div>
                                        <div class="level-checkbox">
                                            <input type="checkbox" id="Expert" value="Expert" class="checkbox-level">
                                            <label class="label-level" for="Expert">Expert</label>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="level-checkbox">
                                            <input type="checkbox" id="Intermediate" value="Intermediate"
                                                   class="checkbox-level">
                                            <label class="label-level" for="Intermediate">Intermediate</label>
                                        </div>
                                        <div class="level-checkbox">
                                            <input type="checkbox" id="Beginner" value="Beginner"
                                                   class="checkbox-level">
                                            <label class="label-level" for="Beginner">Beginner</label>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>

                        <!--                Конец уровни сложности-->


                        <!--                Новый , Популярный , Лучший-->
                        <div class="wrapper mt-2">
                            <p class="text-center text-secondary fw-bolder fs-5">Sort by</p>
                            <div class="sort-by">
                                <div class="row">
                                    <div class="col">
                                        <div class="sort-radio">
                                            <input type="radio" id="New" value="New" class="radio-sort" name="sort">
                                            <label class="sort-label" for="New">New</label>
                                        </div>
                                        <div class="sort-radio">
                                            <input type="radio" id="Popular" value="Popular" class="radio-sort"
                                                   name="sort">
                                            <label class="sort-label" for="Popular">Popular</label>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="sort-radio">
                                            <input type="radio" id="Top" value="Top" class="radio-sort" name="sort">
                                            <label class="sort-label" for="Top">Top</label>
                                        </div>
                                        <div class="sort-radio">
                                            <input type="radio" id="All" value="All" class="radio-sort" name="sort">
                                            <label class="sort-label " for="All">All</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!--                Конец-->

                        <!--            Фильтр по бесплатное и платное-->
                        <div class="wrapper mt-2">
                            <p class="text-center text-secondary fw-bolder fs-5">Categories</p>
                            <div class="free-or-paid text-center">
                                <div class="radio">
                                    <input type="radio" name="free-paid" id="free" value="free" class="radio-input">
                                    <label for="free" class="radio-label">Free</label>
                                    <input type="radio" name="free-paid" id="all" value="all" class="radio-input">
                                    <label for="all" class="radio-label">All</label>
                                    <input type="radio" name="free-paid" id="paid" value="paid" class="radio-input">
                                    <label for="paid" class="radio-label">Paid</label>
                                </div>
                            </div>


                            <!--                Конец фильтра бесплатное и платное-->


                            <!--                Выпадающий список-->

                            <div class="filter-categories mt-3 ">
                                <div class="accordion" id="accordionExample">
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="headingOne">
                                            <button class="accordion-button collapsed" type="button"
                                                    data-bs-toggle="collapse"
                                                    data-bs-target="#collapseOne" aria-expanded="true"
                                                    aria-controls="collapseOne">
                                                <input type="checkbox" name="design" id="headerBtn1"
                                                       class="headerBtnCheckbox">
                                                Design
                                            </button>
                                        </h2>
                                        <div id="collapseOne" class="accordion-collapse collapse"
                                             aria-labelledby="headingOne"
                                             data-bs-parent="#accordionExample">
                                            <div class="accordion-body">
                                                <ul class="ul-checkbox" id="id-ul-check">
                                                    <li>
                                                        <input type="checkbox">
                                                        <label>Подкатегория</label>
                                                    </li>
                                                    <li>
                                                        <input type="checkbox">
                                                        <label>Подкатегория</label>
                                                    </li>
                                                    <li>
                                                        <input type="checkbox">
                                                        <label>Подкатегория</label>
                                                        <ul class="ul-checkbox">
                                                            <li><input type="checkbox">
                                                                <label>Подподкатегория</label>
                                                            </li>
                                                            <li><input type="checkbox">
                                                                <label>Подподкатегория</label>
                                                            </li>
                                                            <li><input type="checkbox">
                                                                <label>Подподкатегория</label>
                                                            </li>
                                                        </ul>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="headingTwo">
                                            <button class="accordion-button collapsed" type="button"
                                                    data-bs-toggle="collapse"
                                                    data-bs-target="#collapseTwo" aria-expanded="false"
                                                    aria-controls="collapseTwo">
                                                <input type="checkbox" name="Back" id="headerBtn2"
                                                       class="headerBtnCheckbox">
                                                Back-end developer
                                            </button>
                                        </h2>
                                        <!--                                <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo"-->
                                        <!--                                     data-bs-parent="#accordionExample">-->
                                        <!--                                    <div class="accordion-body">-->
                                        <!--                                        <ul class="ul-checkbox" id="id-ul-check">-->
                                        <!--                                            <li><input type="checkbox">-->
                                        <!--                                                <label>Подкатегория</label>-->
                                        <!--                                            </li>-->
                                        <!--                                            <li><input type="checkbox">-->
                                        <!--                                                <label>Подкатегория</label>-->
                                        <!--                                            </li>-->
                                        <!--                                            <li><input type="checkbox">-->
                                        <!--                                                <label>Подкатегория</label>-->
                                        <!--                                            </li>-->
                                        <!--                                        </ul>-->
                                        <!--                                    </div>-->
                                        <!--                                </div>-->
                                    </div>
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="headingThree">
                                            <button class="accordion-button collapsed" type="button"
                                                    data-bs-toggle="collapse"
                                                    data-bs-target="#collapseThree" aria-expanded="false"
                                                    aria-controls="collapseThree">
                                                <input type="checkbox" name="motion" id="headerBtn3"
                                                       class="headerBtnCheckbox">
                                                Motion-Design
                                            </button>
                                        </h2>
                                        <div id="collapseThree" class="accordion-collapse collapse"
                                             aria-labelledby="headingThree" data-bs-parent="#accordionExample">
                                            <div class="accordion-body">
                                                <ul class="ul-checkbox" id="id-ul-check">
                                                    <li><input type="checkbox">
                                                        <label>Подкатегория</label>
                                                    </li>
                                                    <li><input type="checkbox">
                                                        <label>Подкатегория</label>
                                                    </li>
                                                    <li><input type="checkbox">
                                                        <label>Подкатегория</label>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="headingFour">
                                            <button class="accordion-button collapsed" type="button"
                                                    data-bs-toggle="collapse"
                                                    data-bs-target="#collapseFour" aria-expanded="false"
                                                    aria-controls="collapseFour">
                                                <input type="checkbox" name="Math" id="headerBtn4"
                                                       class="headerBtnCheckbox">
                                                Math
                                            </button>
                                        </h2>
                                        <div id="collapseFour" class="accordion-collapse collapse"
                                             aria-labelledby="headingFour"
                                             data-bs-parent="#accordionExample">
                                            <div class="accordion-body">
                                                <ul class="ul-checkbox" id="id-ul-check">
                                                    <li><input type="checkbox">
                                                        <label>Подкатегория</label>
                                                    </li>
                                                    <li><input type="checkbox">
                                                        <label>Подкатегория</label>
                                                    </li>
                                                    <li><input type="checkbox">
                                                        <label>Подкатегория</label>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>

                        <div class="text-center">
                            <button type="submit" class="filter-search-btn mt-3">Search</button>
                        </div>

                    </div>
                </form>


                <!--            Конец фильтра-->

                <!--            Блок с курсами-->
                <div class="col ">

                    <div class="row">
                        <div class="col-lg-4 my-3">
                            <div class="card popular-cources shadow p-3 bg-white rounded">
                                <img class="rounded"
                                     src="https://media.istockphoto.com/photos/elearning-education-concept-learning-online-picture-id1290864946?b=1&k=20&m=1290864946&s=170667a&w=0&h=zZq7rG5McSptSIpEm9f8iTGd3Mrdkcslakr91T7qTYM="
                                     alt="">
                                <div class="py-3"><a class="design-btn my-3 rounded px-2 py-1" href="#">Design</a></div>
                                <h4 class="text-black fw-bold">Web-design</h4>

                                <p class="text-secondary fw-bolder">156 Students</p>

                                <div class="btn-price d-flex justify-content-between">
                                    <a class="purp_button rounded text-white fw-bolder p-2" href="#">Start learning</a>
                                    <span class="fw-bolder purp-text  text-center">Free $0</span>
                                </div>

                            </div>
                        </div>
                        <div class="col-lg-4 my-3">
                            <div class="card popular-cources shadow p-3 bg-white rounded">
                                <img class="rounded"
                                     src="https://media.istockphoto.com/photos/elearning-education-concept-learning-online-picture-id1290864946?b=1&k=20&m=1290864946&s=170667a&w=0&h=zZq7rG5McSptSIpEm9f8iTGd3Mrdkcslakr91T7qTYM="
                                     alt="">
                                <div class="py-3"><a class="prog-btn my-3 rounded  px-2 py-1" href="#">Back-end
                                        developer</a></div>
                                <h4 class="text-black fw-bold">Web-design</h4>

                                <p class="text-secondary fw-bolder">156 Students</p>

                                <div class="btn-price d-flex justify-content-between">
                                    <a class="purp_button rounded text-white fw-bolder p-2" href="#">Start learning</a>
                                    <span class="fw-bolder purp-text  text-center">Free $0</span>
                                </div>

                            </div>
                        </div>
                        <div class="col-lg-4 my-3">
                            <div class="card popular-cources shadow p-3 bg-white rounded">
                                <img class="rounded"
                                     src="https://media.istockphoto.com/photos/elearning-education-concept-learning-online-picture-id1290864946?b=1&k=20&m=1290864946&s=170667a&w=0&h=zZq7rG5McSptSIpEm9f8iTGd3Mrdkcslakr91T7qTYM="
                                     alt="">
                                <div class="py-3"><a class="motion-btn my-3 rounded  px-2 py-1"
                                                     href="#">Motion-Design</a>
                                </div>
                                <h4 class="text-black fw-bold">Adobe Premiere Pro </h4>

                                <p class="text-secondary fw-bolder">156 Students</p>

                                <div class="btn-price d-flex justify-content-between">
                                    <a class="purp_button rounded text-white fw-bolder p-2" href="#">Start learning</a>
                                    <span class="fw-bolder purp-text  text-center">Free $0</span>
                                </div>

                            </div>
                        </div>
                        <div class="col-lg-4 my-3">
                            <div class="card popular-cources shadow p-3 bg-white rounded">
                                <img class="rounded"
                                     src="https://media.istockphoto.com/photos/elearning-education-concept-learning-online-picture-id1290864946?b=1&k=20&m=1290864946&s=170667a&w=0&h=zZq7rG5McSptSIpEm9f8iTGd3Mrdkcslakr91T7qTYM="
                                     alt="">
                                <div class="py-3"><a class="prog-btn my-3 rounded  px-2 py-1" href="#">Back-end
                                        developer</a></div>
                                <h4 class="text-black fw-bold">Web-design</h4>

                                <p class="text-secondary fw-bolder">156 Students</p>

                                <div class="btn-price d-flex justify-content-between">
                                    <a class="purp_button rounded text-white fw-bolder p-2" href="#">Start learning</a>
                                    <span class="fw-bolder purp-text  text-center">Free $0</span>
                                </div>

                            </div>
                        </div>
                        <div class="col-lg-4 my-3">
                            <div class="card popular-cources shadow p-3 bg-white rounded">
                                <img class="rounded"
                                     src="https://media.istockphoto.com/photos/elearning-education-concept-learning-online-picture-id1290864946?b=1&k=20&m=1290864946&s=170667a&w=0&h=zZq7rG5McSptSIpEm9f8iTGd3Mrdkcslakr91T7qTYM="
                                     alt="">
                                <div class="py-3"><a class="prog-btn my-3 rounded  px-2 py-1" href="#">Back-end
                                        developer</a></div>
                                <h4 class="text-black fw-bold">Web-design</h4>

                                <p class="text-secondary fw-bolder">156 Students</p>

                                <div class="btn-price d-flex justify-content-between">
                                    <a class="purp_button rounded text-white fw-bolder p-2" href="#">Start learning</a>
                                    <span class="fw-bolder purp-text  text-center">Free $0</span>
                                </div>

                            </div>
                        </div>
                        <div class="col-lg-4 my-3">
                            <div class="card popular-cources shadow p-3 bg-white rounded">
                                <img class="rounded"
                                     src="https://media.istockphoto.com/photos/elearning-education-concept-learning-online-picture-id1290864946?b=1&k=20&m=1290864946&s=170667a&w=0&h=zZq7rG5McSptSIpEm9f8iTGd3Mrdkcslakr91T7qTYM="
                                     alt="">
                                <div class="py-3"><a class="prog-btn my-3 rounded  px-2 py-1" href="#">Back-end
                                        developer</a></div>
                                <h4 class="text-black fw-bold">Web-design</h4>

                                <p class="text-secondary fw-bolder">156 Students</p>

                                <div class="btn-price d-flex justify-content-between">
                                    <a class="purp_button rounded text-white fw-bolder p-2" href="#">Start learning</a>
                                    <span class="fw-bolder purp-text  text-center">Free $0</span>
                                </div>

                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-4 my-3">
                            <div class="card popular-cources shadow p-3 bg-white rounded">
                                <img class="rounded"
                                     src="https://media.istockphoto.com/photos/elearning-education-concept-learning-online-picture-id1290864946?b=1&k=20&m=1290864946&s=170667a&w=0&h=zZq7rG5McSptSIpEm9f8iTGd3Mrdkcslakr91T7qTYM="
                                     alt="">
                                <div class="py-3"><a class="design-btn my-3 rounded px-2 py-1" href="#">Design</a></div>
                                <h4 class="text-black fw-bold">Web-design</h4>

                                <p class="text-secondary fw-bolder">156 Students</p>

                                <div class="btn-price d-flex justify-content-between">
                                    <a class="purp_button rounded text-white fw-bolder p-2" href="#">Start learning</a>
                                    <span class="fw-bolder purp-text  text-center">Free $0</span>
                                </div>

                            </div>
                        </div>
                        <div class="col-lg-4 my-3">
                            <div class="card popular-cources shadow p-3 bg-white rounded">
                                <img class="rounded"
                                     src="https://media.istockphoto.com/photos/elearning-education-concept-learning-online-picture-id1290864946?b=1&k=20&m=1290864946&s=170667a&w=0&h=zZq7rG5McSptSIpEm9f8iTGd3Mrdkcslakr91T7qTYM="
                                     alt="">
                                <div class="py-3"><a class="prog-btn my-3 rounded  px-2 py-1" href="#">Back-end
                                        developer</a></div>
                                <h4 class="text-black fw-bold">Web-design</h4>

                                <p class="text-secondary fw-bolder">156 Students</p>

                                <div class="btn-price d-flex justify-content-between">
                                    <a class="purp_button rounded text-white fw-bolder p-2" href="#">Start learning</a>
                                    <span class="fw-bolder purp-text  text-center">Free $0</span>
                                </div>

                            </div>
                        </div>
                        <div class="col-lg-4 my-3">
                            <div class="card popular-cources shadow p-3 bg-white rounded">
                                <img class="rounded"
                                     src="https://media.istockphoto.com/photos/elearning-education-concept-learning-online-picture-id1290864946?b=1&k=20&m=1290864946&s=170667a&w=0&h=zZq7rG5McSptSIpEm9f8iTGd3Mrdkcslakr91T7qTYM="
                                     alt="">
                                <div class="py-3"><a class="motion-btn my-3 rounded  px-2 py-1"
                                                     href="#">Motion-Design</a>
                                </div>
                                <h4 class="text-black fw-bold">Adobe Premiere Pro </h4>

                                <p class="text-secondary fw-bolder">156 Students</p>

                                <div class="btn-price d-flex justify-content-between">
                                    <a class="purp_button rounded text-white fw-bolder p-2" href="#">Start learning</a>
                                    <span class="fw-bolder purp-text  text-center">Free $0</span>
                                </div>

                            </div>
                        </div>
                        <div class="col-lg-4 my-3">
                            <div class="card popular-cources shadow p-3 bg-white rounded">
                                <img class="rounded"
                                     src="https://media.istockphoto.com/photos/elearning-education-concept-learning-online-picture-id1290864946?b=1&k=20&m=1290864946&s=170667a&w=0&h=zZq7rG5McSptSIpEm9f8iTGd3Mrdkcslakr91T7qTYM="
                                     alt="">
                                <div class="py-3"><a class="prog-btn my-3 rounded  px-2 py-1" href="#">Back-end
                                        developer</a></div>
                                <h4 class="text-black fw-bold">Web-design</h4>

                                <p class="text-secondary fw-bolder">156 Students</p>

                                <div class="btn-price d-flex justify-content-between">
                                    <a class="purp_button rounded text-white fw-bolder p-2" href="#">Start learning</a>
                                    <span class="fw-bolder purp-text  text-center">Free $0</span>
                                </div>

                            </div>
                        </div>
                        <div class="col-lg-4 my-3">
                            <div class="card popular-cources shadow p-3 bg-white rounded">
                                <img class="rounded"
                                     src="https://media.istockphoto.com/photos/elearning-education-concept-learning-online-picture-id1290864946?b=1&k=20&m=1290864946&s=170667a&w=0&h=zZq7rG5McSptSIpEm9f8iTGd3Mrdkcslakr91T7qTYM="
                                     alt="">
                                <div class="py-3"><a class="prog-btn my-3 rounded  px-2 py-1" href="#">Back-end
                                        developer</a></div>
                                <h4 class="text-black fw-bold">Web-design</h4>

                                <p class="text-secondary fw-bolder">156 Students</p>

                                <div class="btn-price d-flex justify-content-between">
                                    <a class="purp_button rounded text-white fw-bolder p-2" href="#">Start learning</a>
                                    <span class="fw-bolder purp-text  text-center">Free $0</span>
                                </div>

                            </div>
                        </div>
                        <div class="col-lg-4 my-3">
                            <div class="card popular-cources shadow p-3 bg-white rounded">
                                <img class="rounded"
                                     src="https://media.istockphoto.com/photos/elearning-education-concept-learning-online-picture-id1290864946?b=1&k=20&m=1290864946&s=170667a&w=0&h=zZq7rG5McSptSIpEm9f8iTGd3Mrdkcslakr91T7qTYM="
                                     alt="">
                                <div class="py-3"><a class="prog-btn my-3 rounded  px-2 py-1" href="#">Back-end
                                        developer</a></div>
                                <h4 class="text-black fw-bold">Web-design</h4>

                                <p class="text-secondary fw-bolder">156 Students</p>

                                <div class="btn-price d-flex justify-content-between">
                                    <a class="purp_button rounded text-white fw-bolder p-2" href="#">Start learning</a>
                                    <span class="fw-bolder purp-text  text-center">Free $0</span>
                                </div>

                            </div>
                        </div>
                    </div>

                </div>
                <!--            Конец-->
            </div>
        </div>
        </div>


        <div class="offcanvas offcanvas-start filter-menu" data-bs-scroll="false" tabindex="-1" id="small-filter"
             aria-labelledby="small-filterLabel">
            <div class="offcanvas-header">
                <h5 class="offcanvas-title" id="small-filterLabel">Filter</h5>
                <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas"
                        aria-label="Close"></button>
            </div>
            <div class="offcanvas-body">
                <div class="input-group search-input container mb-3">
                    <i class="b"></i>
                    <input type="text" class="form-control input-main-page border-0" aria-label="searchInput"
                           placeholder="Course titles or keywords">
                    <button class="btn btn-outline-secondary btn-main text-white" type="button" id="button-addon2">
                        Search
                    </button>
                </div>
                <!--                Конец поиска-->

                <!--                По диапазону цены -->

                <div class="wrapper">
                    <p class="text-center text-secondary fw-bolder fs-5">Price</p>
                    <div class="price-input">
                        <!--                        Минимальное поле ввода-->
                        <div class="field">
                            <span>Min</span>
                            <input type="number" class="input-min" value="0">
                        </div>
                        <div class="separator">-</div>
                        <!--                        Максимальное поле ввода-->
                        <div class="field">
                            <span>Max</span>
                            <input type="number" class="input-max" value="10000">
                        </div>
                    </div>
                    <!--                    Конец полей ввода-->

                    <!--                    Начало слайдера-->
                    <div class="slider">
                        <div class="progress-filter"></div>
                    </div>
                    <div class="range-input">
                        <input type="range" class="range-min" min="0" max="10000" value="0" step="100">
                        <input type="range" class="range-max" min="0" max="10000" value="9999" step="100">
                    </div>
                </div>
                <!--                Конец слайдера-->
                <!--Конец диапазона цены-->


                <!--                Сортировка по рейтингу-->

                <div class="wrapper mt-2">
                    <p class="text-center text-secondary fw-bolder fs-5">Rating</p>

                    <div class="star-rating text-center">
                        <button class="star">&#9734</button>
                        <button class="star">&#9734</button>
                        <button class="star">&#9734</button>
                        <button class="star">&#9734</button>
                        <button class="star">&#9734</button>
                    </div>

                    <p class="current-rating text-center fw-bold">0 of 5</p>
                </div>
                <!--        Конец сортировки по рейтингу -->

                <!--                Уровни сложности-->
                <div class="wrapper mt-2">
                    <p class="text-center text-secondary fw-bolder fs-5">Levels</p>

                    <div class="levels">
                        <div class="row">
                            <div class="col">
                                <div class="level-checkbox">
                                    <input type="checkbox" id="AllLevel" value="AllLevel" class="checkbox-level">
                                    <label class="label-level" for="AllLevel">All level</label>
                                </div>
                                <div class="level-checkbox">
                                    <input type="checkbox" id="Expert" value="Expert" class="checkbox-level">
                                    <label class="label-level" for="Expert">Expert</label>
                                </div>
                            </div>
                            <div class="col">
                                <div class="level-checkbox">
                                    <input type="checkbox" id="Intermediate" value="Intermediate"
                                           class="checkbox-level">
                                    <label class="label-level" for="Intermediate">Intermediate</label>
                                </div>
                                <div class="level-checkbox">
                                    <input type="checkbox" id="Beginner" value="Beginner" class="checkbox-level">
                                    <label class="label-level" for="Beginner">Beginner</label>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>

                <!--                Конец уровни сложности-->


                <!--                Новый , Популярный , Лучший-->
                <div class="wrapper mt-2">
                    <p class="text-center text-secondary fw-bolder fs-5">Sort by</p>
                    <div class="sort-by">
                        <div class="row">
                            <div class="col">
                                <div class="sort-radio">
                                    <input type="radio" id="New" value="New" class="radio-sort" name="sort">
                                    <label class="sort-label" for="New">New</label>
                                </div>
                                <div class="sort-radio">
                                    <input type="radio" id="Popular" value="Popular" class="radio-sort" name="sort">
                                    <label class="sort-label" for="Popular">Popular</label>
                                </div>
                            </div>
                            <div class="col">
                                <div class="sort-radio">
                                    <input type="radio" id="Top" value="Top" class="radio-sort" name="sort">
                                    <label class="sort-label" for="Top">Top</label>
                                </div>
                                <div class="sort-radio">
                                    <input type="radio" id="None" value="None" class="radio-sort" name="sort">
                                    <label class="sort-label " for="None">None</label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!--                Конец-->

                <div class="wrapper mt-2">
                    <p class="text-center text-secondary fw-bolder fs-5">Categories</p>
                    <div class="free-or-paid text-center">
                        <div class="radio">
                            <input type="radio" name="free-paid" id="free" value="free" class="radio-input">
                            <label for="free" class="radio-label">Free</label>
                            <input type="radio" name="free-paid" id="all" value="all" class="radio-input">
                            <label for="all" class="radio-label">All</label>
                            <input type="radio" name="free-paid" id="paid" value="paid" class="radio-input">
                            <label for="paid" class="radio-label">Paid</label>
                        </div>
                    </div>


                    <!--                Конец фильтра бесплатное и платное-->


                    <!--                Выпадающий список-->

                    <!--                конец выпадающего списка-->
                </div>

                <div class="text-center">
                    <button type="submit" class="filter-search-btn mt-3">Search</button>
                </div>
            </div>
        </div>


    </main>


</@main.renderWith>