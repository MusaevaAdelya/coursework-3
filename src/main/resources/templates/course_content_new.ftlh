<#import "partials/main.ftlh" as main />

<#if currentChapter.text??>
    <#assign extraScriptAfterMarkup>
        <script>

            var decodeEntities = (function () {
                // this prevents any overhead from creating the object each time
                var element = document.createElement('div');

                function decodeHTMLEntities(str) {
                    if (str && typeof str === 'string') {
                        // strip script/html tags
                        str = str.replace(/<script[^>]*>([\S\s]*?)<\/script>/gmi, '');
                        str = str.replace(/<\/?\w(?:[^"'>]|"[^"]*"|'[^']*')*>/gmi, '');
                        element.innerHTML = str;
                        str = element.textContent;
                        element.textContent = '';
                    }

                    return str;
                }

                return decodeHTMLEntities;
            })();

            $(document).ready(function () {
                let decodedContent = decodeEntities("${currentChapter.text}")
                let content = document.createElement("div");
                content.innerHTML = decodedContent

                $("#mainContent").append(content)
            })
        </script>
    </#assign>
</#if>



<@main.renderWith title="Calopsia | Course"
scripts=["/js/script.js","/js/course-materials.js"]
styles=["/css/style.css","/css/course-materials.css"]
extraScriptAfter=extraScriptAfterMarkup footer="false">
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
        <div class="docs-wrapper">
            <div id="docs-sidebar" class="docs-sidebar">
                <div class="p-3">
                    <h5>Course name</h5>
                    <p>Progress: 3/23</p>
                    <div class="progress" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                        <div class="progress-bar" style="width: 25%"></div>
                    </div>
                    <hr>
                </div>
                <nav id="docs-nav" class="docs-nav navbar">
                    <ul class="section-items list-unstyled nav flex-column pb-3">
                        <li class="nav-item section-title"><a class="nav-link scrollto active" href="#section"><span
                                        class="theme-icon-holder me-2"><b>1</b></span>Introduction</a></li>
                        <li class="nav-item section-item passed"><a class="nav-link scrollto" href="#item-1-1">Section Item
                                1.1</a></li>
                        <li class="nav-item section-item"><a class="nav-link scrollto" href="#item-1-2">Section Item 1.2</a>
                        </li>
                        <li class="nav-item section-item"><a class="nav-link scrollto" href="#item-1-3">Section Item 1.3</a>
                        </li>
                        <li class="nav-item section-item"><a class="nav-link scrollto" href="#item-1-4">Section Item 1.4</a>
                        </li>
                        <li class="nav-item section-item"><a class="nav-link scrollto" href="#item-1-5">Section Item 1.5</a>
                        </li>
                        <li class="nav-item section-item test"><i class="fa fa-file-pen"></i><a class="nav-link scrollto"
                                                                                                href="#test-1"><i class="bi bi-file-text"></i> Final Test</a></li>
                    </ul>
                    <ul class="section-items list-unstyled nav flex-column pb-3">
                        <li class="nav-item section-title"><a class="nav-link scrollto active" href="#OTHERPAGE"><span
                                        class="theme-icon-holder me-2"><b>2</b></span>Secondary</a></li>
                        <li class="nav-item section-item passed"><a class="nav-link scrollto" href="#OTHERPAGE">Section Item
                                2.1</a></li>
                        <li class="nav-item section-item"><a class="nav-link scrollto" href="#OTHERPAGE">Section Item
                                2.2</a>
                        </li>
                        <li class="nav-item section-item"><a class="nav-link scrollto" href="#OTHERPAGE">Section Item
                                2.3</a>
                        </li>
                        <li class="nav-item section-item"><a class="nav-link scrollto" href="#OTHERPAGE">Section Item
                                2.4</a>
                        </li>
                        <li class="nav-item section-item"><a class="nav-link scrollto" href="#OTHERPAGE">Section Item
                                2.5</a>
                        </li>
                        <li class="nav-item section-item test"><i class="fa fa-file-pen"></i><a class="nav-link scrollto"
                                                                                                href="#OTHERPAGE"><i class="bi bi-file-text"></i> Final Test</a></li>
                    </ul>
                    <ul class="section-items list-unstyled nav flex-column pb-3">
                        <li class="nav-item section-title"><a class="nav-link scrollto active" href="#OTHERPAGE"><span
                                        class="theme-icon-holder me-2"><b>3</b></span>Thirdy</a></li>
                        <li class="nav-item section-item passed"><a class="nav-link scrollto" href="#OTHERPAGE">Section Item
                                3.1</a></li>
                        <li class="nav-item section-item"><a class="nav-link scrollto" href="#OTHERPAGE">Section Item
                                3.2</a>
                        </li>
                        <li class="nav-item section-item"><a class="nav-link scrollto" href="#OTHERPAGE">Section Item
                                3.3</a>
                        </li>
                        <li class="nav-item section-item"><a class="nav-link scrollto" href="#OTHERPAGE">Section Item
                                3.4</a>
                        </li>
                        <li class="nav-item section-item"><a class="nav-link scrollto" href="#OTHERPAGE">Section Item
                                3.5</a>
                        </li>
                        <li class="nav-item section-item test"><i class="fa fa-file-pen"></i><a class="nav-link scrollto"
                                                                                                href="#OTHERPAGE"><i class="bi bi-file-text"></i> Final Test</a></li>
                    </ul>

                </nav><!--//docs-nav-->
            </div><!--//docs-sidebar-->
            <div class="docs-content">
                <div class="container">
                    <article class="docs-article" id="section">
                        <header class="docs-header">
                            <h1 class="docs-heading">Introduction <span class="docs-time">Last updated: 2023-05-15</span>
                            </h1>
                            <section class="docs-intro">
                                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque finibus condimentum nisl
                                    id
                                    vulputate. Praesent aliquet varius eros interdum suscipit. Donec eu purus sed nibh
                                    convallis
                                    bibendum quis vitae turpis. Duis vestibulum diam lorem, vitae dapibus nibh facilisis a.
                                    Fusce in malesuada odio.</p>
                            </section><!--//docs-intro-->
                        </header>
                        <section class="docs-section" id="item-1-1">
                            <h2 class="section-heading">Section Item 1.1</h2>
                            <p>Vivamus efficitur fringilla ullamcorper. Cras condimentum condimentum mauris, vitae facilisis
                                leo. Aliquam sagittis purus nisi, at commodo augue convallis id. </p>
                            <p>Code Example: <code>npm install &lt;package&gt;</code></p>
                            <h5>Unordered List Examples:</h5>
                            <ul>
                                <li><strong class="me-1">HTML5:</strong> <code>&lt;div id="foo"&gt;</code></li>
                                <li><strong class="me-1">CSS:</strong> <code>#foo { color: red }</code></li>
                                <li><strong class="me-1">JavaScript:</strong>
                                    <code>console.log(&#x27;#foo\bar&#x27;);</code>
                                </li>
                            </ul>
                            <h5>Ordered List Examples:</h5>
                            <ol>
                                <li>Download lorem ipsum dolor sit amet.</li>
                                <li>Click ipsum faucibus venenatis.</li>
                                <li>Configure fermentum malesuada nunc.</li>
                                <li>Deploy donec non ante libero.</li>
                            </ol>



                        </section><!--//section-->
                        <section class="docs-section">
                            <h2 class="section-heading">Test</h2>
                            <p>Vivamus efficitur fringilla ullamcorper. Cras condimentum condimentum mauris, vitae facilisis
                                leo. Aliquam sagittis purus nisi, at commodo augue convallis id. Sed interdum turpis quis
                                felis
                                bibendum imperdiet. Mauris pellentesque urna eu leo gravida iaculis. In fringilla odio in
                                felis
                                ultricies porttitor. Donec at purus libero. Vestibulum libero orci, commodo nec arcu sit
                                amet,
                                commodo sollicitudin est. Vestibulum ultricies malesuada tempor.</p>
                            <div class="container border p-4 mb-5">
                                <div class="row">
                                    <div class="col-12">
                                        <p class="fw-bold">1. Which of the following sentences is correct</p>
                                        <div><input type="radio" name="box" id="one"> <input type="radio" name="box"
                                                                                             id="two">
                                            <input type="radio" name="box" id="three"> <input type="radio" name="box"
                                                                                              id="four">
                                            <label for="one" class="box first">
                                                <div class="course"><span class="circle"></span> <span class="subject"> When
													its raining ,people's umbrella are all you're going to see from
													above </span>
                                                </div>
                                            </label> <label for="two" class="box second">
                                                <div class="course"><span class="circle"></span> <span class="subject"> When
													its raining,people's umbrella are all your going to see from above
												</span>
                                                </div>
                                            </label> <label for="three" class="box third">
                                                <div class="course"><span class="circle"></span> <span class="subject"> When
													its raining,peoples umbrella's are all you're going to see from
													above </span>
                                                </div>
                                            </label> <label for="four" class="box forth">
                                                <div class="course"><span class="circle"></span> <span class="subject"> None
													of the above </span>
                                                </div>
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-12 mt-4">
                                        <div class="d-flex justify-content-end">
                                            <button class="btn btn-primary px-4 py-2 fw-bold"> Continue</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section><!--//section-->

                    </article>
                </div>
            </div>
        </div>
    </main>



</@main.renderWith>