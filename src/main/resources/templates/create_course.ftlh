<#import "partials/main.ftlh" as main />

<#assign extraStyleMarkup>
    <style>
        .accordion-header button {
            color: black !important;
            font-weight: normal !important;
        }
    </style>
</#assign>

<@main.renderWith title="Calopsia | Create Course"
scripts=["/js/script.js","/js/create_course.js","/js/profile.js"]
styles=["/css/style.css","/css/create_courses.css",
"/css/progress-style.css", "/css/catalog.css","/css/profile.css"]
extrastyle=extraStyleMarkup footer="false">
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

    <main class="container-fluid min-vh-100-minus-header pt-nav">
        <div class="categories-create flex-shrink-0 p-3 scrollarea" style="width: 280px">
            <img src="${coursesPath}DEFAULT.png" class="img-fluid rounded img-course w-100" alt=""/>
            <div class="mt-2">
                <!-- Здесь статусы курса, показываться будет один из них -->
                <!-- <span class="status-course success my-3 rounded px-2 py-1" >Published</span> -->
                <span class="status-course gray my-3 rounded px-2 py-1">Archive</span>
                <!-- <span class="status-course alert my-3 rounded px-2 py-1" >Error</span> -->
            </div>
            <a href="/" class="d-flex pb-3 mt-2 link-dark text-decoration-none">
                <span class="fs-5 fw-semibold">Course name</span>
            </a>
            <a name="" id="" class="btn btn-outline-primary mb-3 btn-max-width" href="#" role="button">Publish</a>
            <ul class="list-unstyled ps-0 pt-2 border-top">
                <h5>Menu</h5>
                <li class="mb-1">
                    <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
                            data-bs-toggle="collapse" data-bs-target="#home-collapse" aria-expanded="true">
                        Settings
                    </button>
                    <div class="collapse show" id="home-collapse">
                        <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                            <li>
                                <a data-content="#content-description" href="#"
                                   class="link-dark create-menu-link d-inline-flex text-decoration-none rounded">Description</a>
                            </li>
                            <li>
                                <a data-content="#content-content" href="#"
                                   class="link-dark create-menu-link d-inline-flex text-decoration-none rounded">Content</a>
                            </li>
                        </ul>
                    </div>
                </li>
            </ul>
        </div>

        <div class="col p-3 shadow bg-white scrollarea categories-create">
            <form method="POST" action="/course/create" enctype="multipart/form-data"
                  modelAttribute="createCourseData" id="createCourseForm">

                <#if _csrf??>
                    <input type="hidden" name="${(_csrf.parameterName)!'csrf'}"
                           value="${(_csrf.token)!'--no-token--'}"/>
                </#if>

                <div id="content-description" class="content-create hide">
                    <h2>Description</h2>
                    <hr/>

                    <div class="mb-3">
                        <label for="formFile" class="form-label">Course picture</label>
                        <div class="image-upload">

                            <label for="formFile">
                                <img class="border shadow" src="${coursesPath}DEFAULT.png" id="blah"/>
                            </label>
                            <input name="image" id="formFile" type="file" onchange="readURL(this);"/>

                        </div>
                    </div>
                    <div class="mb-3 form-floating">
                        <input name="name" type="text" class="form-control" id="courseNameInput" placeholder="Example name"/>
                        <label for="courseNameInput" class="form-label">Name</label>
                    </div>
                    <div class="mb-3">
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
                                                <input type="radio" name="category"
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
                                                                    <input type="radio" name="category"
                                                                           value="${parent.categoryDto.id}">
                                                                    <label>${parent.categoryDto.name}</label>
                                                                    <#if parent.children??>
                                                                        <#if parent.children?size!=0>
                                                                            <ul class="ul-checkbox">
                                                                                <#list parent.children as child>
                                                                                    <li><input type="radio"
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
                    <div class="mb-3">
                        <label for="shortDescInput" class="form-label">Short Description</label>
                        <textarea name="description" type="text" class="form-control" id="shortDescInput"
                                  placeholder="Enter Something"></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="selectLevel" class="form-label">Select Difficulty</label>
                        <select name="level" id="selectLevel" class="form-select" aria-label="Default select example">
                            <option selected value="AllLevels">All levels</option>
                            <option value="Beginner">Beginner</option>
                            <option value="Intermediate">Intermediate</option>
                            <option value="Expert">Expert</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="shortDescInput" class="form-label">Enter what students will learn</label>
                        <textarea name="skills" type="text" class="form-control" id="shortDescInput" rows="5" placeholder="Enter the skills acquired by students who completed the course.

Each skill on a new line:
Good reading
PHP / MySQL"></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="requirementsInput" class="form-label">Enter initial requirements</label>
                        <textarea name="req" type="text" class="form-control" id="requirementsInput" rows="5"
                                  placeholder="Enter requirements for students.

Each on a new line:
Good reading
PHP / MySQL"></textarea>
                    </div>


                </div>
                <div id="content-content" class="content-create">
                    <h2>Content</h2>
                    <hr/>
                    <div class="list-group w-auto ">
                        <div class="list-group-item module-item">
                            <div href="#" class="list-group-item list-group-item-action d-flex gap-3 py-3"
                                 aria-current="true">
                                <div class="fs-3">1</div>
                                <div class="d-flex gap-2 w-100 justify-content-between">
                                    <div class="w-50">
                                        <div class="mb-3">
                                            <input type="text" name="module" class="form-control fs-5 module-class" id="courseNameInput"
                                                   placeholder="Module name" value="Module 1"/>
                                        </div>
                                    </div>
                                    <div>

                                        <button data-item="module" class="btn remove-item" type="button">
                                            <i class="bi bi-trash3 text-danger"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="list-group mb-4 ps-5">
                                <a href="#" class="list-group-item list-group-item-action d-flex gap-3 py-3"
                                   aria-current="true">
                                    <div class="d-flex gap-2 w-100 justify-content-between">
                                        <div class="w-50">
                                            <div class="mb-3">
                                                <input type="text" name="lesson" class="form-control fs-5 lesson-class" id="courseNameInput"
                                                       placeholder="Lesson name"/>

                                            </div>
                                        </div>
                                        <div>
                                            <button class="btn btn-primary" type="button">
                                                Edit
                                            </button>
                                            <button data-item="lesson" class="btn remove-item" type="button">
                                                <i class="bi bi-trash3 text-danger"></i>
                                            </button>
                                        </div>
                                    </div>
                                </a>

                                <a data-item="lesson" href="#"
                                   class="list-group-item list-group-item-action d-flex gap-3 py-3 add-lesson"
                                   aria-current="true">
                                    <div class="fs-3">Add lesson</div>
                                </a>
                            </div>
                        </div>

                        <a href="#" class="list-group-item list-group-item-action d-flex gap-3 py-3 add-module"
                           aria-current="true">
                            <div class="fs-3">Add Module</div>
                        </a>
                    </div>

                    <button type="submit" class="btn btn-primary mt-5" id="courseSubmit">Submit</button>
                </div>
            </form>
        </div>
    </main>


</@main.renderWith>