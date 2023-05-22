<#import "partials/main.ftlh" as main />

<#assign extraScriptBeforerMarkup>
    <script>

        anychart.onDocumentReady(async function () {
            // set chart theme
            anychart.theme('monochrome');

            let activity = await fetch("/profile/get-activity/${user.id}")
            let activityJson = await activity.json()
            console.log(activityJson)


            var dataset = anychart.data.set(activityJson);
            var mapping = dataset.mapAs({
                x: 'date',
                value: 'count'
            });
            var chart = anychart.calendar(mapping);

            chart.background('#fff');

            chart.months()
                .stroke(false)
                .noDataStroke(false);

            chart.days()
                .spacing(5)
                .stroke(false)
                .noDataStroke(false)
                .noDataFill('#f2f2f2')
                .noDataHatchFill(false);

            chart.colorRange(false);

            var customColorScale = anychart.scales.ordinalColor();
            customColorScale.ranges([
                {less: 2},
                {from: 3, to: 5},
                {greater: 6},
            ]);

            customColorScale.colors(["#7786ff", "#3f59ff","#1d3cff" ]);

            // Set color scale.
            chart.colorScale(customColorScale);

            chart.tooltip()
                .format('{%count} courses');

            chart.listen('chartDraw', function () {
                document.getElementById('container').style.height = chart.getActualHeight() + 'px';
            });

            chart.container('activity-chart');
            chart.draw();
        });

    </script>
</#assign>

<#assign extraScriptAfterMarkup>
    <script>
        // seeallcourcesbut
        $(document).ready(function () {
            $('.seeallcourcesbut').html('See all courses');
            $('.seeallcourcesbut').click(function () {
                if ($(this).text() == 'See all courses') {
                    $(this).html('Hide all courses');
                } else {
                    $(this).html('See all courses');
                }
            })

            <#if invalidData??>
            Swal.fire({
                icon: 'error',
                title: 'Invalid Data',
                text: '${invalidData}',
            })
            </#if>
        });

        function readURL(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    $('#blah')
                        .attr('src', e.target.result);
                };

                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</#assign>

<@main.renderWith title="Calopsia | Profile"
scripts=["/js/script.js"]
styles=["/css/style.css","/css/profile.css","/css/progress-style.css"]
extraScriptAfter=extraScriptAfterMarkup extraScriptBefore=extraScriptBeforerMarkup>
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
                        <@security.authorize access="isAuthenticated()">
                            <#if user.role == "ADMIN">
                                <li class="nav-item"><a class="nav-link text-black" href="/admin/users">Admin-Bereich</a></li>
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
    <div class="modal modal-lg fade" id="settingsProfileModal" data-bs-backdrop="static" aria-hidden="true"
         aria-labelledby="titleModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="titleModal">Profileinstellungen</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form method="POST" action="/profile/edit" enctype="multipart/form-data"
                      modelAttribute="newProfileData">
                    <#if _csrf??>
                        <input type="hidden" name="${(_csrf.parameterName)!'csrf'}"
                               value="${(_csrf.token)!'--no-token--'}"/>
                    </#if>

                    <div class="modal-body p-4">
                        <div class="row">
                            <div class="mb-3">
                                <label for="formFile" class="form-label">Profilbild</label>
                                <div class="image-upload">

                                    <label for="formFile">
                                        <img class="border shadow" src="${avatarPath}${user.avatar}" id="blah"/>
                                    </label>
                                    <input name="newAvatar" id="formFile" type="file" onchange="readURL(this);"/>

                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="username" class="form-label">der Name</label>
                                <input name="newUsername" type="text" value="${user.username}" class="form-control"
                                       id="username">
                            </div>
                            <div class="mb-3">
                                <label for="about" class="form-label">Über</label>
                                <textarea name="newAbout" type="text" class="form-control"
                                          id="about"><#if user.about??>${user.about}</#if>
                                </textarea>
                            </div>
                            <div class="mb-3">
                                <label for="newPass" class="form-label">Neues Passwort</label>
                                <input name="newPassword" type="password" class="form-control" id="newPass">
                            </div>
                            <div class="mb-3">
                                <label for="renewPass" class="form-label">Passwort wiederholen</label>
                                <input name="newPasswordRepeat" type="password" class="form-control" id="renewPass">
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-secondary btn-close" data-bs-dismiss="modal" aria-label="Close">
                            Änderungen verwerfen
                        </button>
                        <button class="btn btn-primary btn-close" type="submit" data-bs-dismiss="modal"
                                aria-label="Close">speichern
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <main class="min-vh-100">
        <div class="container">
            <div class="row profile-info">
                <div class="col-md-3 col-sm-12 profile-img  h-25 shadow">
                    <img src="${avatarPath}${user.avatar}" class="border" alt="">
                    <div class="info text-start mt-3">
                        <h5 class="name">${user.username}</h5>
                        <p class="desc text-muted">${user.about!''}</p>
                        <#--                        <div class="subs">-->
                        <#--                            <p><i class="bi bi-people-fill"></i> 2 subscribers</p>-->
                        <#--                        </div>-->
                        <#--                        <a href="#" class="btn btn-primary btn-max-width">-->
                        <#--                            Follow-->
                        <#--                        </a>-->
                        <!-- <a href="#" class="btn btn-secondary btn-max-width">
                        Unfollow
                     </a> -->
                    </div>
                </div>
                <div class="col pt-3 ms-md-3 mt-sm-3 mt-md-0 ms-sm-0 profile-info shadow">
                    <div class="sticky-top d-block">
                        <ul class="nav nav-tabs sticky-top" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active" id="prof-stats-tab" data-bs-toggle="tab"
                                   data-bs-target="#prof-stats" type="button" role="tab" aria-controls="nav-home"
                                   aria-selected="true">Überblick</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="prof-stud-activity-tab" data-bs-toggle="tab"
                                   data-bs-target="#prof-stud-activity" type="button" role="tab"
                                   aria-controls="nav-home" aria-selected="true">Studentische Aktivitäten</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="prof-teach-activity-tab" data-bs-toggle="tab"
                                   data-bs-target="#prof-teach-activity" type="button" role="tab"
                                   aria-controls="nav-profile" aria-selected="false">Lehrer Aktivitäten</a>
                            </li>

                            <li class="nav-item ms-auto">
                                <a class="nav-link" data-bs-toggle="modal" href="#settingsProfileModal" role="button"><i
                                            class="bi bi-gear-fill"></i></a>
                            </li>
                        </ul>
                    </div>
                    <div class="tab-content p-3 " id="nav-tabContent">
                        <div class="tab-pane fade active show" id="prof-stats" role="tabpanel"
                             aria-labelledby="prof-stats-tab">
                            <div id="activity-chart" class="mt-5 border px-3">
                                <div class="text-chart m-2">Aktivität im letzten Jahr</div>
                            </div>
                            <div class="statistic-chart w-100 d-flex border justify-content-center py-3 px-4">
                                <div>
                                    <dt class="activity-graph__counter-val">${solvedQty}</dt>
                                    <dd class="activity-graph__counter-descr">Gelöst</dd>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="prof-stud-activity" role="tabpanel"
                             aria-labelledby="prof-stud-activity-tab">
                            <h3>Current Courses</h3>
                            <hr>
                            <div class="cources-block">
                                <#if user.studyingCourses?size!=0>
                                    <div class="row mb-4">
                                        <#if (user.studyingCourses?size>2)>
                                            <#list 0..1 as index>
                                                <div class="col-sm-6">
                                                    <div class="card curCources-card">
                                                        <div class="card-body">
                                                            <img src="${coursesPath}${user.studyingCourses[index].thumbNailPath}"
                                                                 class="img-fluid rounded" alt="">
                                                            <h4 class="card-title mt-4">${user.studyingCourses[index].name}</h4>
                                                            <p class="card-text">${user.studyingCourses[index].description!''}</p>
                                                            <div class="d-flex justify-content-between">
                                                                <a href="#" class="btn btn-primary">Weiter
                                                                    lernen</a>
                                                                <div class="progress-circle <#if (user.studyingCourses[index].percent>=50)>over50</#if> p${user.studyingCourses[index].percent}">
                                                                    <span>${user.studyingCourses[index].percent}%</span>
                                                                    <div class="left-half-clipper">
                                                                        <div class="first50-bar"></div>
                                                                        <div class="value-bar"></div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </#list>
                                        <#else>
                                            <#list user.studyingCourses as c>
                                                <div class="col-sm-6">
                                                    <div class="card curCources-card">
                                                        <div class="card-body">
                                                            <img src="${coursesPath}${c.thumbNailPath}"
                                                                 class="img-fluid rounded" alt="">
                                                            <h4 class="card-title mt-4">${c.name}</h4>
                                                            <p class="card-text">${c.description!''}</p>
                                                            <div class="d-flex justify-content-between">
                                                                <a href="#" class="btn btn-primary">Weiter
                                                                    lernen</a>
                                                                <div class="progress-circle <#if (c.percent>=50)>over50</#if> p${c.percent}">
                                                                    <span>${c.percent}%</span>
                                                                    <div class="left-half-clipper">
                                                                        <div class="first50-bar"></div>
                                                                        <div class="value-bar"></div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </#list>
                                        </#if>


                                    </div>
                                    <#if (user.studyingCourses?size>2) >
                                        <div class="collapse" id="collapse-cources-block">
                                            <div class="row mb-4">

                                                <#list 2..(user.studyingCourses?size-1) as index>
                                                    <div class="col-sm-6" style="margin-bottom:1.5rem">
                                                        <div class="card curCources-card">
                                                            <div class="card-body">
                                                                <img src="${coursesPath}${user.studyingCourses[index].thumbNailPath}"
                                                                     class="img-fluid rounded" alt="">
                                                                <h4 class="card-title mt-4">${user.studyingCourses[index].name}</h4>
                                                                <p class="card-text">${user.studyingCourses[index].description!''}</p>
                                                                <div class="d-flex justify-content-between">
                                                                    <a href="#" class="btn btn-primary">Weiter
                                                                        lernen</a>
                                                                    <div class="progress-circle <#if (user.studyingCourses[index].percent>=50)>over50</#if> p${user.studyingCourses[index].percent}">
                                                                        <span>${user.studyingCourses[index].percent}%</span>
                                                                        <div class="left-half-clipper">
                                                                            <div class="first50-bar"></div>
                                                                            <div class="value-bar"></div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </#list>

                                            </div>
                                        </div>
                                        <a class="btn btn-primary seeallcourcesbut" data-bs-toggle="collapse"
                                           href="#collapse-cources-block"
                                           role="button" aria-expanded="false" aria-controls="collapse-cources-block">
                                            See all courses
                                        </a>
                                    </#if>

                                <#else>
                                    <img src="/img/not_found_cat.jpg"
                                         style="width:100%;height:45vh; margin:0 auto; object-fit: contain">
                                </#if>

                            </div>

                        </div>
                        <div class="tab-pane fade" id="prof-teach-activity" role="tabpanel"
                             aria-labelledby="prof-teach-activity-tab">
                            <div class="header-teacher-activity">
                                <h3>Erstellte Kurse</h3>
                                <a class="create-course" href="course/create">Kurs erstellen</a>
                            </div>
                            <hr>
                            <div class="cources-block">
                                <#if user.createdCourses?size!=0>
                                    <div class="row mb-4">

                                        <#if (user.createdCourses?size>2)>
                                            <#list 0..1 as index>
                                                <div class="col-sm-6">
                                                    <div class="card curCources-card">
                                                        <div class="card-body">
                                                            <img src="${coursesPath}${user.createdCourses[index].thumbNailPath}"
                                                                 class="img-fluid rounded" alt="">
                                                            <h4 class="card-title mt-4">${user.createdCourses[index].name}</h4>
                                                            <p class="card-text">${user.createdCourses[index].description!''}</p>
                                                            <div class="d-flex justify-content-between">
                                                                <a href="/course/${user.createdCourses[index].id}"
                                                                   class="btn btn-primary">Blick</a>
                                                                <#if user.createdCourses[index].courseSections?has_content>

                                                                    <a href="/course/${user.createdCourses[index].id}/edit/${user.createdCourses[index].courseSections[0].chapters[0].id}"
                                                                       class="btn btn-primary">Bearbeiten</a>
                                                                </#if>

                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </#list>
                                        <#else>
                                            <#list user.createdCourses as c>
                                                <div class="col-sm-6">
                                                    <div class="card curCources-card">
                                                        <div class="card-body">
                                                            <img src="${coursesPath}${c.thumbNailPath}"
                                                                 class="img-fluid rounded" alt="">
                                                            <h4 class="card-title mt-4">${c.name}</h4>
                                                            <p class="card-text">${c.description!''}</p>
                                                            <div class="d-flex justify-content-between">
                                                                <a href="/course/${c.id}"
                                                                   class="btn btn-primary">Blick</a>
                                                                <#if c.courseSections?has_content>
                                                                    <#if !c.courseSections[0].chapters?has_content>
                                                                        <a href="/course/${c.id}/edit/${c.courseSections[0].chapters[0].id}"
                                                                           class="btn btn-primary">Bearbeiten</a>
                                                                    </#if>
                                                                </#if>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </#list>
                                        </#if>


                                    </div>
                                    <#if (user.createdCourses?size>2) >
                                        <div class="collapse" id="collapse-cources-block">
                                            <div class="row mb-4">

                                                <#list 2..(user.createdCourses?size-1) as index>
                                                    <div class="col-sm-6">
                                                        <div class="card curCources-card">
                                                            <div class="card-body">
                                                                <img src="${coursesPath}${user.createdCourses[index].thumbNailPath}"
                                                                     class="img-fluid rounded" alt="">
                                                                <h4 class="card-title mt-4">${user.createdCourses[index].name}</h4>
                                                                <p class="card-text">${user.createdCourses[index].description!''}</p>
                                                                <div class="d-flex justify-content-between">
                                                                    <a href="/course/${user.createdCourses[index].id}"
                                                                       class="btn btn-primary">Blick</a>
                                                                    <#if user.createdCourses[index].courseSections?has_content>

                                                                        <a href="/course/${user.createdCourses[index].id}/edit/${user.createdCourses[index].courseSections[0].chapters[0].id}"
                                                                           class="btn btn-primary">Bearbeiten</a>

                                                                    </#if>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </#list>

                                            </div>
                                        </div>
                                        <a class="btn btn-primary seeallcourcesbut" data-bs-toggle="collapse"
                                           href="#collapse-cources-block"
                                           role="button" aria-expanded="false" aria-controls="collapse-cources-block">
                                            See all courses
                                        </a>
                                    </#if>

                                <#else>
                                    <img src="/img/not_found_cat.jpg"
                                         style="width:100%;height:45vh; margin:0 auto; object-fit: contain">
                                </#if>

                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </main>


</@main.renderWith>