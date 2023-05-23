<#import "partials/main.ftlh" as main />

<@main.renderWith title="Calopsia | Catalog"
scripts=["/js/script.js","/js/catalog.js"]
styles=["/css/style.css","/css/catalog.css"]>
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
                        <li class="nav-item"><a class="nav-link text-black active" href="/">Startseite</a></li>
                        <li class="nav-item"><a class="nav-link text-black " href="/courses">Alle Kurse</a></li>
                        <#--                        <li class="nav-item"><a class="nav-link text-black" href="#">Market</a></li>-->
                        <#--                        <li class="nav-item"><a class="nav-link text-black" href="#">Contacts</a></li>-->
                        <li class="nav-item"><a class="nav-link text-black" href="#">Über uns</a></li>
                        <li class="nav-item">
                            <a class=" navbar-toggler" href="#" role="button" data-bs-toggle="collapse"
                               data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown"
                               aria-expanded="false" aria-label="Toggle navigation">
                                <span class="navbar-toggler-icon"></span>
                            </a>
                            <div class="collapse navbar-collapse" id="navbarNavDropdown">
                                <ul class="navbar-nav">
                                    <li class="nav-item dropdown">
                                        <a class="text-black nav-link dropdown-toggle" href="#" role="button"
                                           data-bs-toggle="dropdown" aria-expanded="false" style="text-decoration: none">
                                            Srpachen
                                        </a>
                                        <ul class="dropdown-menu dropdown-menu-dark">
                                            <li><a class="dropdown-item" href="${url}?lang=en">EN</a></li>
                                            <li><a class="dropdown-item" href="${url}?lang=de">DE</a></li>
                                        </ul>
                                    </li>
                                </ul>
                            </div>
                        </li>
                        <@security.authorize access="isAuthenticated()">
                            <#if user.role == "ADMIN">
                                <li class="nav-item"><a class="nav-link text-black"
                                                        href="/admin/users">Admin-Bereich</a></li>
                            </#if>
                        </@security.authorize>
                    </ul>
                    <@security.authorize access="! isAuthenticated()">
                        <ul class="navbar-nav ms-auto d-sm-inline py-4 py-lg-0 second">
                            <li class="menu-separator nav-item ">.</li>
                            <li class="nav-item d-sm-inline header-button"><a
                                        class="nav-link d-sm-inline text-black text-bold"
                                        href="/login">einloggen</a>
                            </li>
                            <li class="nav-item d-sm-inline header-button"><a
                                        class="nav-link d-sm-inline text-black header-button-purp"
                                        href="/login?register=true">anmelden</a></li>
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
                                        href="#">ausloggen
                                </button>
                            </div>

                        </form>
                    </@security.authorize>

                </div>
            </div>
        </nav>
    </header>

    <main class="pt-top mb-5">

        <div class="courses container">
            <button class="filter-menu-button filter-menu d-lg-none fixed-top" type="button" data-bs-toggle="offcanvas"
                    data-bs-target="#small-filter" aria-controls="small-filter">
                <i class="bi bi-filter"></i>
            </button>
            <div class="row">


                <!--            Начало фильтра-->
                <div class="col-lg-3 pt-3 h-75  d-sm-none d-md-none d-lg-block filter-menu-none">
                    <form action="/courses" method="get" role="form" modelAttribute="catalogForm">

                        <!--                Поиск по ключевому слову-->

                        <div class="input-group search-input container mb-3">
                            <i class="b"></i>
                            <input type="text" class="form-control input-main-page border-0" aria-label="searchInput"
                                   placeholder="Kurstitel oder Schlüsselwörter" name="keywords">
                            <button class="btn btn-outline-secondary btn-main text-white" type="submit"
                                    id="button-addon2">
                                suchen
                            </button>
                        </div>
                        <!--                Конец поиска-->

                        <!--                По диапазону цены -->

                        <#--                        <div class="wrapper">-->
                        <#--                            <p class="text-center text-secondary fw-bolder fs-5">Price</p>-->
                        <#--                            <div class="price-input">-->
                        <#--                                <!--                        Минимальное поле ввода&ndash;&gt;-->
                        <#--                                <div class="field">-->
                        <#--                                    <span>Min</span>-->
                        <#--                                    <input type="number" class="input-min" value="0" name="minPrice">-->
                        <#--                                </div>-->
                        <#--                                <div class="separator">-</div>-->
                        <#--                                <!--                        Максимальное поле ввода&ndash;&gt;-->
                        <#--                                <div class="field">-->
                        <#--                                    <span>Max</span>-->
                        <#--                                    <input type="number" class="input-max" value="1000" name="maxPrice">-->
                        <#--                                </div>-->
                        <#--                            </div>-->
                        <#--                            <!--                    Конец полей ввода&ndash;&gt;-->

                        <#--                            <!--                    Начало слайдера&ndash;&gt;-->
                        <#--                            <div class="slider">-->
                        <#--                                <div class="progress-filter"></div>-->
                        <#--                            </div>-->
                        <#--                            <div class="range-input">-->
                        <#--                                <input type="range" class="range-min" min="0" max="1000" value="0" step="10">-->
                        <#--                                <input type="range" class="range-max" min="0" max="1000" value="999" step="10">-->
                        <#--                            </div>-->
                        <#--                        </div>-->
                        <!--                Конец слайдера-->
                        <!--Конец диапазона цены-->


                        <!--                Сортировка по рейтингу-->

                        <div class="wrapper mt-2">
                            <p class="text-center text-secondary fw-bolder fs-5">Bewertung</p>

                            <div class="star-rating text-center">
                                <button class="star" type="button">&#9734</button>
                                <button class="star" type="button">&#9734</button>
                                <button class="star" type="button">&#9734</button>
                                <button class="star" type="button">&#9734</button>
                                <button class="star" type="button">&#9734</button>
                            </div>

                            <p class="current-rating text-center fw-bold">0 of 5</p>
                            <input id="rating" name="rating" value="0" hidden>
                        </div>


                        <!--        Конец сортировки по рейтингу -->

                        <!--                Уровни сложности-->
                        <div class="wrapper mt-2">
                            <p class="text-center text-secondary fw-bolder fs-5">Stufen</p>

                            <div class="levels">
                                <div class="row row-cols-2">
                                    <#if levels??>
                                        <#list levels as level>
                                            <div class="col">
                                                <div class="level-checkbox">
                                                    <input type="checkbox" id="${level}" value="${level}"
                                                           class="checkbox-level" name="level">
                                                    <label class="label-level" for="${level}">
                                                        <#if level=="AllLevels">alle Niveaus<#else>${level}</#if>
                                                    </label>
                                                </div>
                                            </div>
                                        </#list>
                                    </#if>
                                </div>

                            </div>
                        </div>

                        <!--                Конец уровни сложности-->


                        <!--                Новый , Популярный , Лучший-->
                        <div class="wrapper mt-2">
                            <p class="text-center text-secondary fw-bolder fs-5">Sortieren nach</p>
                            <div class="sort-by">
                                <div class="row">
                                    <div class="col">
                                        <div class="sort-radio">
                                            <input type="radio" id="New" value="New" class="radio-sort" name="orderBy">
                                            <label class="sort-label" for="New">Neu</label>
                                        </div>
                                        <div class="sort-radio">
                                            <input type="radio" id="Popular" value="Popular" class="radio-sort"
                                                   name="orderBy">
                                            <label class="sort-label" for="Popular">Beliebt</label>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="sort-radio">
                                            <input type="radio" id="Top" value="Top" class="radio-sort" name="orderBy">
                                            <label class="sort-label" for="Top">Oberen</label>
                                        </div>
                                        <div class="sort-radio">
                                            <input type="radio" id="All" value="All" class="radio-sort" name="orderBy">
                                            <label class="sort-label " for="All">Alle</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!--                Конец-->

                        <!--            Фильтр по бесплатное и платное-->
                        <div class="wrapper mt-2">
                            <p class="text-center text-secondary fw-bolder fs-5">Kategorien</p>
                            <#--                            <div class="free-or-paid text-center">-->
                            <#--                                <div class="radio">-->
                            <#--                                    <input type="radio" name="free-paid" id="free" value="free" class="radio-input"-->
                            <#--                                           name="price">-->
                            <#--                                    <label for="free" class="radio-label">Free</label>-->
                            <#--                                    <input type="radio" name="free-paid" id="all" value="all" class="radio-input"-->
                            <#--                                           name="price">-->
                            <#--                                    <label for="all" class="radio-label">All</label>-->
                            <#--                                    <input type="radio" name="free-paid" id="paid" value="paid" class="radio-input"-->
                            <#--                                           name="price">-->
                            <#--                                    <label for="paid" class="radio-label">Paid</label>-->
                            <#--                                </div>-->
                            <#--                            </div>-->


                            <!--                Конец фильтра бесплатное и платное-->


                            <!--                Выпадающий список-->

                            <div class="filter-categories mt-3 ">
                                <div class="accordion" id="accordionExample">

                                    <#if categories??>
                                        <#list categories as grandparent>
                                            <div class="accordion-item">
                                                <h2 class="accordion-header" id="heading${grandparent.categoryDto.id}">
                                                    <button class="accordion-button collapsed" type="button"
                                                            data-bs-toggle="collapse"
                                                            data-bs-target="#collapse${grandparent.categoryDto.id}"
                                                            aria-expanded="true"
                                                            aria-controls="collapse${grandparent.categoryDto.id}">
                                                        <input type="checkbox" name="category"
                                                               id="headerBtn${grandparent.categoryDto.id}"
                                                               class="headerBtnCheckbox"
                                                               value="${grandparent.categoryDto.id}">
                                                        ${grandparent.categoryDto.name}
                                                    </button>
                                                </h2>
                                                <#if grandparent.children??>
                                                    <#if grandparent.children?size!=0>
                                                        <div id="collapse${grandparent.categoryDto.id}"
                                                             class="accordion-collapse collapse"
                                                             aria-labelledby="heading${grandparent.categoryDto.id}"
                                                             data-bs-parent="#accordionExample">
                                                            <div class="accordion-body">
                                                                <ul class="ul-checkbox" id="id-ul-check">

                                                                    <#list grandparent.children as parent>
                                                                        <li>
                                                                            <input type="checkbox" name="category"
                                                                                   value="${parent.categoryDto.id}">
                                                                            <label>${parent.categoryDto.name}</label>
                                                                            <#if parent.children??>
                                                                                <#if parent.children?size!=0>
                                                                                    <ul class="ul-checkbox">
                                                                                        <#list parent.children as child>
                                                                                            <li><input type="checkbox"
                                                                                                       name="category"
                                                                                                       value="${child.categoryDto.id}">
                                                                                                <label>${child.categoryDto.name}</label>
                                                                                            </li>
                                                                                        </#list>

                                                                                    </ul>
                                                                                </#if>
                                                                            </#if>

                                                                        </li>
                                                                    </#list>

                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </#if>
                                                </#if>

                                            </div>
                                        </#list>
                                    </#if>

                                </div>

                            </div>
                        </div>

                        <div class="text-center">
                            <button type="submit" class="filter-search-btn mt-3">suchen</button>
                        </div>
                    </form>
                </div>


                <!--            Конец фильтра-->

                <!--            Блок с курсами-->
                <div class="col-lg-9 ">


                    <#if courses??>
                        <#if courses?size!=0>
                            <div class="row row-cols-1 row-cols-lg-3">
                                <#list courses as course>

                                    <div class="col my-3">
                                        <div class="card popular-cources shadow p-3 bg-white rounded">
                                            <img class="rounded"
                                                 src="${coursesPath}${course.thumbNailPath}"
                                                 alt="">
                                            <div class="py-3"><a class="design-btn my-3 rounded px-2 py-1"
                                                                 href="#">${course.category.name}</a></div>
                                            <h4 class="text-black fw-bold">${course.name}</h4>

                                            <p class="text-secondary fw-bolder">${course.users?size} Studenten</p>

                                            <div class="btn-price d-flex justify-content-between">
                                                <a class="purp_button rounded text-white fw-bolder p-2"
                                                   href="/course/${course.id}">lernen</a>
                                                <span class="fw-bolder purp-text  text-center"><i
                                                            class="bi bi-star-fill text-warning"></i>${course.ratingScore?string["0.#"]}</span>
                                            </div>

                                        </div>
                                    </div>

                                </#list>
                            </div>
                        <#else>
                            <div class="d-flex justify-content-center align-content-center mt-5">
                                <img src="/img/no_courses_were_found.svg"
                                     alt="no courses were found"
                                     width="70%" height="70%"
                                     style="object-fit: contain; background-position: center center;">

                            </div>
                        </#if>

                    </#if>


                    <!--Pagination-->
                    <nav aria-label="Page">
                        <ul class="pagination d-flex justify-content-center py-5 mt-5">
                            <li class="page-item <#if !hasPrev>disabled</#if>">
                                <a class="page-link" href="${prevPageLink!'#'}">Vorherigen</a>
                            </li>
                            <li class="page-item <#if !hasNext>disabled</#if>">
                                <a class="page-link" href="${nextPageLink!'#'}">Nächsten</a>
                            </li>
                        </ul>
                    </nav>

                </div>
                <!--            Конец-->


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
                <form action="/courses" method="get" role="form" modelAttribute="catalogForm">

                    <!--                Поиск по ключевому слову-->

                    <div class="input-group search-input container mb-3">
                        <i class="b"></i>
                        <input type="text" class="form-control input-main-page border-0" aria-label="searchInput"
                               placeholder="Course titles or keywords" name="keywords">
                        <button class="btn btn-outline-secondary btn-main text-white" type="submit"
                                id="button-addon2">
                            suchen
                        </button>
                    </div>
                    <!--                Конец поиска-->

                    <!--                По диапазону цены -->

                    <#--                        <div class="wrapper">-->
                    <#--                            <p class="text-center text-secondary fw-bolder fs-5">Price</p>-->
                    <#--                            <div class="price-input">-->
                    <#--                                <!--                        Минимальное поле ввода&ndash;&gt;-->
                    <#--                                <div class="field">-->
                    <#--                                    <span>Min</span>-->
                    <#--                                    <input type="number" class="input-min" value="0" name="minPrice">-->
                    <#--                                </div>-->
                    <#--                                <div class="separator">-</div>-->
                    <#--                                <!--                        Максимальное поле ввода&ndash;&gt;-->
                    <#--                                <div class="field">-->
                    <#--                                    <span>Max</span>-->
                    <#--                                    <input type="number" class="input-max" value="1000" name="maxPrice">-->
                    <#--                                </div>-->
                    <#--                            </div>-->
                    <#--                            <!--                    Конец полей ввода&ndash;&gt;-->

                    <#--                            <!--                    Начало слайдера&ndash;&gt;-->
                    <#--                            <div class="slider">-->
                    <#--                                <div class="progress-filter"></div>-->
                    <#--                            </div>-->
                    <#--                            <div class="range-input">-->
                    <#--                                <input type="range" class="range-min" min="0" max="1000" value="0" step="10">-->
                    <#--                                <input type="range" class="range-max" min="0" max="1000" value="999" step="10">-->
                    <#--                            </div>-->
                    <#--                        </div>-->
                    <!--                Конец слайдера-->
                    <!--Конец диапазона цены-->


                    <!--                Сортировка по рейтингу-->

                    <div class="wrapper mt-2">
                        <p class="text-center text-secondary fw-bolder fs-5">Bewertung</p>

                        <div class="star-rating text-center">
                            <button class="star" type="button">&#9734</button>
                            <button class="star" type="button">&#9734</button>
                            <button class="star" type="button">&#9734</button>
                            <button class="star" type="button">&#9734</button>
                            <button class="star" type="button">&#9734</button>
                        </div>

                        <p class="current-rating text-center fw-bold">0 of 5</p>
                        <input id="rating" name="rating" value="0" hidden>
                    </div>


                    <!--        Конец сортировки по рейтингу -->

                    <!--                Уровни сложности-->
                    <div class="wrapper mt-2">
                        <p class="text-center text-secondary fw-bolder fs-5">Stufen</p>

                        <div class="levels">
                            <div class="row row-cols-2">
                                <#if levels??>
                                    <#list levels as level>
                                        <div class="col">
                                            <div class="level-checkbox">
                                                <input type="checkbox" id="${level}" value="${level}"
                                                       class="checkbox-level" name="level">
                                                <label class="label-level" for="${level}">
                                                    <#if level=="AllLevels">Alle Niveaus<#else>${level}</#if>
                                                </label>
                                            </div>
                                        </div>
                                    </#list>
                                </#if>


                                <#--                                <div class="col">-->
                                <#--                                    <div class="level-checkbox">-->
                                <#--                                        <input type="checkbox" id="Expert" value="Expert" class="checkbox-level"-->
                                <#--                                               name="level">-->
                                <#--                                        <label class="label-level" for="Expert">Expert</label>-->
                                <#--                                    </div>-->
                                <#--                                    <div class="level-checkbox">-->
                                <#--                                        <input type="checkbox" id="Intermediate" value="Intermediate"-->
                                <#--                                               class="checkbox-level" name="level">-->
                                <#--                                        <label class="label-level" for="Intermediate">Intermediate</label>-->
                                <#--                                    </div>-->
                                <#--                                    <div class="level-checkbox">-->
                                <#--                                        <input type="checkbox" id="Beginner" value="Beginner"-->
                                <#--                                               class="checkbox-level" name="level">-->
                                <#--                                        <label class="label-level" for="Beginner">Beginner</label>-->
                                <#--                                    </div>-->
                                <#--                                </div>-->
                            </div>

                        </div>
                    </div>

                    <!--                Конец уровни сложности-->


                    <!--                Новый , Популярный , Лучший-->
                    <div class="wrapper mt-2">
                        <p class="text-center text-secondary fw-bolder fs-5">Sortieren nach</p>
                        <div class="sort-by">
                            <div class="row">
                                <div class="col">
                                    <div class="sort-radio">
                                        <input type="radio" id="New" value="New" class="radio-sort" name="orderBy">
                                        <label class="sort-label" for="New">Neu</label>
                                    </div>
                                    <div class="sort-radio">
                                        <input type="radio" id="Popular" value="Popular" class="radio-sort"
                                               name="orderBy">
                                        <label class="sort-label" for="Popular">Beliebt</label>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="sort-radio">
                                        <input type="radio" id="Top" value="Top" class="radio-sort" name="orderBy">
                                        <label class="sort-label" for="Top">Oberen</label>
                                    </div>
                                    <div class="sort-radio">
                                        <input type="radio" id="All" value="All" class="radio-sort" name="orderBy">
                                        <label class="sort-label " for="All">Alle</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!--                Конец-->

                    <!--            Фильтр по бесплатное и платное-->
                    <div class="wrapper mt-2">
                        <p class="text-center text-secondary fw-bolder fs-5">Kategorien</p>
                        <#--                            <div class="free-or-paid text-center">-->
                        <#--                                <div class="radio">-->
                        <#--                                    <input type="radio" name="free-paid" id="free" value="free" class="radio-input"-->
                        <#--                                           name="price">-->
                        <#--                                    <label for="free" class="radio-label">Free</label>-->
                        <#--                                    <input type="radio" name="free-paid" id="all" value="all" class="radio-input"-->
                        <#--                                           name="price">-->
                        <#--                                    <label for="all" class="radio-label">All</label>-->
                        <#--                                    <input type="radio" name="free-paid" id="paid" value="paid" class="radio-input"-->
                        <#--                                           name="price">-->
                        <#--                                    <label for="paid" class="radio-label">Paid</label>-->
                        <#--                                </div>-->
                        <#--                            </div>-->


                        <!--                Конец фильтра бесплатное и платное-->


                        <!--                Выпадающий список-->

                        <div class="filter-categories mt-3 ">
                            <div class="accordion" id="accordionExample">

                                <#if categories??>
                                    <#list categories as grandparent>
                                        <div class="accordion-item">
                                            <h2 class="accordion-header" id="heading${grandparent.categoryDto.id}">
                                                <button class="accordion-button collapsed" type="button"
                                                        data-bs-toggle="collapse"
                                                        data-bs-target="#collapse${grandparent.categoryDto.id}"
                                                        aria-expanded="true"
                                                        aria-controls="collapse${grandparent.categoryDto.id}">
                                                    <input type="checkbox" name="category"
                                                           id="headerBtn${grandparent.categoryDto.id}"
                                                           class="headerBtnCheckbox"
                                                           value="${grandparent.categoryDto.id}">
                                                    ${grandparent.categoryDto.name}
                                                </button>
                                            </h2>
                                            <#if grandparent.children??>
                                                <#if grandparent.children?size!=0>
                                                    <div id="collapse${grandparent.categoryDto.id}"
                                                         class="accordion-collapse collapse"
                                                         aria-labelledby="heading${grandparent.categoryDto.id}"
                                                         data-bs-parent="#accordionExample">
                                                        <div class="accordion-body">
                                                            <ul class="ul-checkbox" id="id-ul-check">

                                                                <#list grandparent.children as parent>
                                                                    <li>
                                                                        <input type="checkbox" name="category"
                                                                               value="${parent.categoryDto.id}">
                                                                        <label>${parent.categoryDto.name}</label>
                                                                        <#if parent.children??>
                                                                            <#if parent.children?size!=0>
                                                                                <ul class="ul-checkbox">
                                                                                    <#list parent.children as child>
                                                                                        <li><input type="checkbox"
                                                                                                   name="category"
                                                                                                   value="${child.categoryDto.id}">
                                                                                            <label>${child.categoryDto.name}</label>
                                                                                        </li>
                                                                                    </#list>

                                                                                </ul>
                                                                            </#if>
                                                                        </#if>

                                                                    </li>
                                                                </#list>

                                                            </ul>
                                                        </div>
                                                    </div>
                                                </#if>
                                            </#if>

                                        </div>
                                    </#list>
                                </#if>

                            </div>

                        </div>
                    </div>

                    <div class="text-center">
                        <button type="submit" class="filter-search-btn mt-3">suchen</button>
                    </div>
                </form>
            </div>
        </div>


    </main>


</@main.renderWith>