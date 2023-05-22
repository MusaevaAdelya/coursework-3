<#import "partials/main.ftlh" as main />

<#assign extraScriptAfterMarkup>
    <script>
        $(document).ready(function () {
            <#if review??>
            <#if review="success">
            Swal.fire({
                icon: 'success',
                title: 'Erfolg',
                text: 'Ihre Bewertung wurde erfolgreich zum Kurs "${course.name}" hinzugef?gt.',
            })
            </#if>
            </#if>

        })

    </script>
</#assign>

<@main.renderWith title="Calopsia | Kurs"
scripts=["/js/script.js","/js/course_de.js"]
styles=["/css/style.css","/css/course.css"]
extraScriptAfter=extraScriptAfterMarkup>
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
                        <li class="nav-item"><a class="nav-link text-black " href="/">Startseite</a></li>
                        <li class="nav-item"><a class="nav-link text-black active" href="/courses">Alle Kurse</a></li>
                        <li class="nav-item"><a class="nav-link text-black" href="#">?ber uns</a></li>
                    </ul>
                    <@security.authorize access="! isAuthenticated()">
                        <ul class="navbar-nav ms-auto d-sm-inline py-4 py-lg-0 second">
                            <li class="menu-separator nav-item ">.</li>
                            <li class="nav-item d-sm-inline header-button"><a
                                        class="nav-link d-sm-inline text-black text-bold"
                                        href="/login">Anmeldung</a>
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
                                        href="#">Abmeldung
                                </button>
                            </div>

                        </form>
                    </@security.authorize>

                </div>
            </div>
        </nav>
    </header>

    <main style="padding-top: 72px">
        <!-- Tutor Course Top Info Start -->
        <div class="tutor-course-top-info section-padding-01 bg-color-11 ">
            <div class="container custom-container">

                <div class="row">
                    <div class="col-lg-8">

                        <!-- Tutor Course Top Info Start -->
                        <div class="tutor-course-top-info__content">
                            <div class="tutor-course-top-info__badges">
                                <a class="design-btn my-3 rounded px-2 py-1"
                                   href="#"><#if course.category??>${course.category.name}</#if></a>
                                <a class="sale-btn my-3 rounded px-2 py-1"><#if course.level??>${course.level}</#if></a>
                            </div>
                            <h1 class="tutor-course-top-info__title"><#if course.name??>${course.name}</#if></h1>
                            <div class="tutor-course-top-info__meta">
                                <div class="tutor-course-top-info__meta-instructor">
                                    <div class="instructor-name"><#if course.teacher.username??>${course.teacher.username}</#if></div>
                                </div>
                                <div class="tutor-course-top-info__meta-update">Letzte Aktualisierung <#if course.dateOn?has_content>${course.dateOn.toString()?datetime.iso?time?string("HH:mm dd MM yyyy")}</#if></div>
                            </div>
                            <div class="tutor-course-top-info__meta">
                                <div class="tutor-course-top-info__meta-rating">

                                    <div class="rating-average"><strong>${course.ratingScore!"0"}</strong> /5</div>
                                    <div class="rating-star">
                                        <#list 1..course.ratingScore?int as i>
                                            <i class="bi bi-star-fill star"></i>
                                        </#list>
                                    </div>
                                    <div class="rating-count">${course.ratingScore!"0"}</div>

                                </div>
                                <div class="tutor-course-top-info__meta-action"><i
                                            class="meta-icon bi bi-person-fill"></i> <#if course.users?has_content>
                                        ${course.users?size}
                                    <#else>
                                        0 bereits eingeschrieben
                                    </#if>
                                    bereits
                                    eingeschrieben
                                </div>
                            </div>
                        </div>
                        <!-- Tutor Course Top Info End -->

                    </div>
                </div>

            </div>
        </div>
        <!-- Tutor Course Top Info End -->

        <!-- Tutor Course Main content Start -->
        <div class="tutor-course-main-content section-padding-01 sticky-parent" style="position: relative;">
            <div class="container custom-container">

                <div class="row gy-10">
                    <div class="col-lg-8">

                        <!-- Tutor Course Main Segment Start -->
                        <div class="tutor-course-main-segment">

                            <!-- Tutor Course Segment Start -->
                            <div class="tutor-course-segment">
                                <h4 class="tutor-course-segment__title">Kursvoraussetzungen</h4>

                                <#--                                <!-- Tutor Course Segment Prerequisites Start &ndash;&gt;-->
                                <#--                                <div class="tutor-course-segment__prerequisites">-->
                                <#--&lt;#&ndash;                                    <div class="tutor-course-segment__prerequisites-warning">&ndash;&gt;-->
                                <#--&lt;#&ndash;                                        <i class="fas fa-exclamation-triangle"></i>&ndash;&gt;-->
                                <#--&lt;#&ndash;                                        Please note that this course has the following prerequisites which must be completed before it can be accessed&ndash;&gt;-->
                                <#--&lt;#&ndash;                                    </div>&ndash;&gt;-->
                                <#--                                    <ul class="tutor-course-segment__prerequisites-list">-->
                                <#--                                        <li>-->
                                <#--                                            <a class="prerequisites-item" href="#">-->
                                <#--                                                <div class="prerequisites-item__title">-->
                                <#--                                                    Basic Python &amp; MVC Skills-->
                                <#--                                                </div>-->
                                <#--                                            </a>-->
                                <#--                                        </li>-->
                                <#--                                    </ul>-->

                                <#--                                    <#list r >-->
                                <#--                                </div>-->
                                <#--                                <!-- Tutor Course Segment Prerequisites End &ndash;&gt;-->

                            </div>
                            <!-- Tutor Course Segment End -->

                            <!-- Tutor Course Segment Start -->
                            <div class="tutor-course-segment">
                                <h4 class="tutor-course-segment__title">?ber diesen Kurs</h4>

                                <!-- Tutor Course Segment Content Wrapper Start -->
                                <div class="tutor-course-segment__content-wrap">
                                    <p>${course.description!""}</p>
                                </div>
                                <!-- Tutor Course Segment Content Wrapper End -->

                                <!-- Tutor Course Segment Tags Start -->
                                <#--                                <div class="tutor-course-segment__tags">-->
                                <#--                                    <div class="tutor-course-segment__tags-title">-->
                                <#--                                        <i class="fas  fa-tags"></i>-->
                                <#--                                    </div>-->
                                <#--                                    <div class="tutor-course-segment__tags-list">-->
                                <#--                                        <a href="#"> back-end,</a>-->
                                <#--                                        <a href="#">python,</a>-->
                                <#--                                        <a href="#">django,</a>-->
                                <#--                                        <a href="#">hard</a>-->
                                <#--                                    </div>-->
                                <#--                                </div>-->
                                <!-- Tutor Course Segment Tags End -->

                            </div>
                            <!-- Tutor Course Segment End -->

                            <!-- Tutor Course Segment Start -->
                            <div class="tutor-course-segment benefits-wrap">
                                <h4 class="tutor-course-segment__title">Lernziele</h4>

                                <!-- Tutor Course Segment Benefits Items Start -->
                                <div class="tutor-course-segment__benefits-items">
                                    <#if course.skills?has_content >
                                        <#list course.skills as item>
                                            <div class="tutor-course-segment__benefit-item">
                                                <div class="tutor-course-segment__benefit-content">
                                                    <i class="bi bi-check"></i>
                                                    <span class="benefit-text">${item}</span>
                                                </div>
                                            </div>
                                        </#list>
                                    </#if>

                                </div>
                                <!-- Tutor Course Segment Benefits Items End -->

                            </div>
                            <!-- Tutor Course Segment End -->

                            <!-- Tutor Course Segment Start -->
                            <div class="tutor-course-segment">
                                <h4 class="tutor-course-segment__title">Anforderungen</h4>


                                <!-- Tutor Course Segment Requirements Items Start -->
                                <div class="tutor-course-segment__requirements-content">
                                    <ul class="tutor-course-segment__list-style-01">
                                        <#if course.requirements?has_content>
                                            <#list course.requirements as c>
                                                <li>${c}</li>
                                            </#list>
                                        </#if>
                                    </ul>
                                </div>
                                <!-- Tutor Course Segment Requirements Items End -->
                            </div>
                            <!-- Tutor Course Segment End -->

                            <!-- Tutor Course Segment Start -->
                            <#--                            <div class="tutor-course-segment audience-wrap">-->
                            <#--                                <h4 class="tutor-course-segment__title">Target Audience</h4>-->

                            <#--                                <!-- Tutor Course Segment Requirements Items Start &ndash;&gt;-->
                            <#--                                <div class="tutor-course-segment__audience-content">-->
                            <#--                                    <ul class="tutor-course-segment__list-style-02">-->
                            <#--                                        <li>Geniuses</li>-->
                            <#--                                        <li>Are so</li>-->
                            <#--                                        <li>Very tired.</li>-->
                            <#--                                    </ul>-->
                            <#--                                </div>-->
                            <#--                                <!-- Tutor Course Segment Requirements Items End &ndash;&gt;-->
                            <#--                            </div>-->
                            <!-- Tutor Course Segment End -->

                            <!-- Tutor Course Segment Start -->
                            <div class="tutor-course-segment">

                                <div class="tutor-course-segment__header">
                                    <h4 class="tutor-course-segment__title">Lehrplan</h4>

                                    <div class="tutor-course-segment__lessons-duration">
                                        <span class="tutor-course-segment__lessons"><#if course.courseSections?has_content>${course.courseSections?size}</#if></span>
                                        <#--                                        <span class="tutor-course-segment__duration">15h 15m</span>-->
                                    </div>
                                </div>

                                <div class="course-curriculum accordion">

                                    <#if course.courseSections?has_content>
                                        <#list course.courseSections as section>
                                            <div class="accordion-item">
                                                <button class="accordion-button" data-bs-toggle="collapse"
                                                        data-bs-target="#collapse${section.id}"><i
                                                            class="tutor-icon"></i>${section.title!''}</button>
                                                <div id="collapse${section.id}" class="accordion-collapse collapse show"
                                                     data-bs-parent="#accordionCourse">

                                                    <div class="course-curriculum__lessons">

                                                        <#if section.chapters?has_content>
                                                            <#list section.chapters as chapter>
                                                                <div class="course-curriculum__lesson">
                                                    <span class="course-curriculum__title">
                                                    <i class="bi bi-files-alt"></i>
                                                    ${chapter.title!''}
                                                </span>

                                                                </div>
                                                            </#list>
                                                        </#if>

                                                    </div>
                                                </div>
                                            </div>
                                        </#list>
                                    </#if>


                                </div>

                            </div>
                            <!-- Tutor Course Segment End -->

                            <!-- Tutor Course Segment Start -->
                            <div class="tutor-course-segment">
                                <h4 class="tutor-course-segment__title">Deine Lehrerin</h4>

                                <div class="tutor-course-segment__instructor">
                                    <div class="tutor-instructor">
                                        <div class="tutor-instructor__avatar">
                                            <img src="${avatarPath}${course.teacher.avatar!""}" alt="instructor" width="200"
                                                 height="246">
                                        </div>
                                        <div class="tutor-instructor__instructor-info">
                                            <a class="tutor-instructor__name" href="#"><h4
                                                        class="tutor-instructor__name">${course.teacher.username!""}</h4>
                                            </a>
                                            <div class="tutor-instructor__meta">
                                                <span><i class="bi bi-play-circle"></i> ${course.teacher.createdCourses?size!""}</span>
                                                <#--                                                <span><i class="fas fa-comment-alt"></i> 4 Reviews</span>-->
                                                <#--                                                <span><i class="fas fa-user"></i> 73 Students</span>-->
                                            </div>
                                            <div class="tutor-instructor__meta">
                                                <div>
                                                    ${course.teacher.about!""}
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Tutor Course Segment End -->

                            <!-- Tutor Course Segment Start -->
                            <div class="tutor-course-segment">
                                <h4 class="tutor-course-segment__title">Studentisches Feedback</h4>


                                <div class="tutor-course-segment__feedback">
                                    <div class="tutor-course-segment__reviews-average">
                                        <div class="count"></div>
                                        <div class="reviews-rating-star">
                                            <div class="rating-star">
                                                <#list 1..course.ratingScore?int as i>
                                                    <i class="bi bi-star-fill star"></i>
                                                </#list>
                                            </div>
                                        </div>
                                        <div class="rating-total">${ratings?size!"0"} Bewertungen</div>
                                    </div>
                                </div>
                            </div>
                            <!-- Tutor Course Segment End -->

                            <!-- Tutor Course Segment Start -->
                            <div class="tutor-course-segment">
                                <h4 class="tutor-course-segment__title">Rezensionen <span class="count">${ratings?size!"0"}</span>
                                </h4>

                                <div class="tutor-course-segment__review-commnet">
                                    <ul class="comment-list-02">
                                        <#if ratings?has_content>
                                            <#list ratings as rating>
                                                <li>
                                                    <div class="comment-item-02">
                                                        <div class="comment-item-02__header">
                                                            <div class="comment-item-02__author">
                                                                <img src="${avatarPath}${rating.user.avatar!""}" alt="Avatar" width="52"
                                                                     height="52">
                                                            </div>
                                                            <div class="comment-item-02__info">
                                                                <h6 class="comment-item-02__name"><a href="#">${rating.user.username!""}</a>
                                                                </h6>
                                                                <p class="comment-item-02__date"><#if rating.dateOn?has_content>${rating.dateOn}</#if></p>
                                                            </div>
                                                        </div>
                                                        <div class="comment-item-02__body">

                                                            <div>
                                                                <#list 1..rating.rating as i>
                                                                    <i class="bi bi-star-fill star"></i>
                                                                </#list>
                                                            </div>

                                                            <p>${rating.comment!""}</p>

                                                        </div>
                                                    </div>
                                                </li>
                                            </#list>
                                        </#if>

                                    </ul>
                                </div>
                            </div>
                            <!-- Tutor Course Segment End -->

                            <!-- Tutor Course Segment Start -->
                            <div class="tutor-course-segment">
                                <h4 class="tutor-course-segment__title">Eine Bewertung schreiben</h4>

                                <div class="tutor-course-segment__reviews">
                                    <button class="tutor-course-segment__btn btn btn-primary btn-hover-secondary"
                                            data-bs-toggle="collapse" data-bs-target="#collapseForm">Schreiben Sie eine Bewertung
                                    </button>

                                    <div class="collapse" id="collapseForm">
                                        <!-- Comment Form Start -->
                                        <div class="comment-form">
                                            <#if studentProgress?has_content>
                                                <#if (studentProgress>=10)>

                                                    <form method="POST" action="/course/review" modelAttribute="reviewForm">
                                                        <input name="comment" required type="text" class="comments-input"
                                                               placeholder="Kommentar...">
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
                                                        <p class="text-center text-secondary fw-bolder fs-5 mb-0">Bewertung</p>
                                                        <button class="star-btn">&#9734</button>
                                                        <button class="star-btn">&#9734</button>
                                                        <button class="star-btn">&#9734</button>
                                                        <button class="star-btn">&#9734</button>
                                                        <button class="star-btn">&#9734</button>
                                                        <p class="current-rating text-center fw-bold">0 of 5</p>
                                                    </div>

                                                </#if>
                                            </#if>
                                        </div>
                                        <!-- Comment Form End -->
                                    </div>
                                </div>
                            </div>
                            <!-- Tutor Course Segment End -->

                        </div>
                        <!-- Tutor Course Main Segment End -->

                    </div>
                    <div class="col-lg-4">

                        <div class="sidebar-sticky" style="">
                            <!-- Tutor Course Sidebar Start -->
                            <div class="tutor-course-sidebar">

                                <!-- Tutor Course Price Preview Start -->
                                <div class="tutor-course-price-preview">
                                    <div class="tutor-course-price-preview__thumbnail">
                                        <div class="ratio ratio-16x9">
                                            <img src="${coursesPath}${course.thumbNailPath!""}" alt="">
                                        </div>
                                    </div>
                                    <div class="tutor-course-price-preview__price">
                                        <div class="tutor-course-price">
                                            <span class="sale-price">${course.coins!"Free"}</span>
                                            <#--                                                        <span-->
                                            <#--                                                                class="separator">.00</span></span>-->

                                        </div>
                                        <#--                                        <div class="tutor-course-price-badge">39% off</div>-->
                                    </div>
                                    <div class="tutor-course-price-preview__meta">
                                        <ul class="tutor-course-meta-list">
                                            <li>
                                                <div class="label"><i class="bi bi-sliders-h"></i> Ebene</div>
                                                <div class="value">${course.level!""}</div>
                                            </li>
                                            <#--                                            <li>-->
                                            <#--                                                <div class="label"><i class="bi bi-clock"></i> Category</div>-->
                                            <#--                                                <div class="value">${course.category.name!""}</div>-->
                                            <#--                                            </li>-->
                                            <li>
                                                <div class="label"><i class="bi bi-play-circle"></i> Vorlesungen
                                                </div>
                                                <div class="value">${course.courseSections?size!"0"} Vortr?ge</div>
                                            </li>
                                            <li>
                                                <div class="label"><i class="bi bi-tag"></i> Kategorie</div>
                                                <div class="value"><a href="#">${course.category.name!""}</a></div>
                                            </li>
                                            <#--                                            <li>-->
                                            <#--                                                <div class="label"><i class="fas fa-globe"></i> Language</div>-->
                                            <#--                                                <div class="value">Russian</div>-->
                                            <#--                                            </li>-->
                                        </ul>
                                    </div>
                                    <#--                                    <div class="tutor-course-segment">-->
                                    <#--                                        <h4 class="tutor-course-segment__title">Material Includes</h4>-->

                                    <#--                                        <ul class="tutor-course-segment__list-style-01">-->
                                    <#--                                            <li>Videos</li>-->
                                    <#--                                            <li>Booklets</li>-->
                                    <#--                                        </ul>-->
                                    <#--                                    </div>-->
                                    <div class="tutor-course-price-preview__btn">

                                        <a class="btn btn-primary btn-hover-secondary w-100 p-3" href="/course/${course.id}/content/${course.courseSections[0].chapters[0].id}"><i
                                                    class="bi bi-bag"></i> Lernen beginnen
                                        </a>

                                    </div>
                                </div>
                                <!-- Tutor Course Price Preview End -->


                                <!-- Sidebar Widget Start -->
                                <div class="sidebar-widget">
                                    <h3 class="sidebar-widget__title">Verwandte Kurse</h3>

                                    <div class="sidebar-widget__course">

                                        <#if course.teacher.createdCourses?has_content>
                                            <#list course.teacher.createdCourses as courses>
                                                <div class="sidebar-widget__course-item">
                                                    <div class="sidebar-widget__course-thumbnail">
                                                        <a href=""><img src="${coursesPath}${courses.thumbNailPath!""}" alt="Courses"
                                                                        width="120"
                                                                        height="72"></a>
                                                    </div>
                                                    <div class="sidebar-widget__course-content">
                                                        <h4 class="sidebar-widget__course-title"><a href="">${courses.name!""}</a></h4>
                                                        <div class="sidebar-widget__course-price">
                                                        </div>
                                                    </div>
                                                </div>
                                            </#list>
                                        </#if>

                                    </div>
                                </div>
                                <!-- Sidebar Widget End -->

                            </div>
                            <!-- Tutor Course Sidebar End -->
                        </div>

                    </div>
                </div>

            </div>
        </div>
        <!-- Tutor Course Main content End -->
    </main>


</@main.renderWith>