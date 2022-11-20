<#import "partials/main.ftlh" as main />

<@main.renderWith title="Calopsia | Main"
scripts=["/js/script.js"]
styles=["/css/style.css"]>
<#assign security=JspTaglibs["http://www.springframework.org/security/tags"]/>

    <main>

        <div class="main-block d-flex align-items-center ">
            <div class="container">
                <div class="col-lg-6 text-c">
                    <h1 class="hero-text text-size text-start">
                        Anywhere, anytime, <br>
                        Learn what you want, <br>
                        from any device <br>
                    </h1>
                    <p class="hero-sub-text text-start fs-5 mt-3">Knowledge is the eye of desire<br> and can become the pilot of the soul</p>

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
                    <div class="col-lg-3 my-3">
                        <div class="card popular-cources shadow p-3 bg-white rounded">
                            <img class="rounded"
                                 src="https://media.istockphoto.com/photos/elearning-education-concept-learning-online-picture-id1290864946?b=1&k=20&m=1290864946&s=170667a&w=0&h=zZq7rG5McSptSIpEm9f8iTGd3Mrdkcslakr91T7qTYM="
                                 alt="">
                            <!--                            Здесь как span только я хз как и во всех других карточках тоже-->
                            <div class="py-3"><a class="design-btn my-3 rounded px-2 py-1" href="#">Design</a></div>
                            <h4 class="text-black fw-bold">Web-design</h4>

                            <p class="text-secondary fw-bolder">156 Students</p>

                            <div class="btn-price d-flex justify-content-between">
                                <a class="purp_button rounded text-white fw-bolder p-2" href="#">Start learning</a>
                                <span class="fw-bolder purp-text  text-center">Free $0</span>
                            </div>

                        </div>
                    </div>
                    <div class="col-lg-3 my-3">
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
                    <div class="col-lg-3 my-3">
                        <div class="card popular-cources shadow p-3 bg-white rounded">
                            <img class="rounded"
                                 src="https://media.istockphoto.com/photos/elearning-education-concept-learning-online-picture-id1290864946?b=1&k=20&m=1290864946&s=170667a&w=0&h=zZq7rG5McSptSIpEm9f8iTGd3Mrdkcslakr91T7qTYM="
                                 alt="">
                            <div class="py-3"><a class="motion-btn my-3 rounded  px-2 py-1" href="#">Motion-Design</a>
                            </div>
                            <h4 class="text-black fw-bold">Adobe Premiere Pro </h4>

                            <p class="text-secondary fw-bolder">156 Students</p>

                            <div class="btn-price d-flex justify-content-between">
                                <a class="purp_button rounded text-white fw-bolder p-2" href="#">Start learning</a>
                                <span class="fw-bolder purp-text  text-center">Free $0</span>
                            </div>

                        </div>
                    </div>
                    <div class="col-lg-3 my-3">
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
                    <div class="col-lg-3 my-3">
                        <div class="card popular-cources shadow p-3 bg-white rounded">
                            <img class="rounded"
                                 src="https://media.istockphoto.com/photos/elearning-education-concept-learning-online-picture-id1290864946?b=1&k=20&m=1290864946&s=170667a&w=0&h=zZq7rG5McSptSIpEm9f8iTGd3Mrdkcslakr91T7qTYM="
                                 alt="">
                            <div class="py-3"><a class="prog-btn my-3 rounded  px-2 py-1 " href="#">Back-end
                                    developer</a></div>
                            <h4 class="text-black fw-bold">Web-design</h4>

                            <p class="text-secondary fw-bolder">156 Students</p>

                            <div class="btn-price d-flex justify-content-between">
                                <a class="purp_button rounded text-white fw-bolder p-2" href="#">Start learning</a>
                                <span class="fw-bolder purp-text  text-center">Free $0</span>
                            </div>

                        </div>
                    </div>
                    <div class="col-lg-3 my-3 ">
                        <div class="card popular-cources shadow  p-3 bg-white rounded">
                            <img class="rounded"
                                 src="https://media.istockphoto.com/photos/elearning-education-concept-learning-online-picture-id1290864946?b=1&k=20&m=1290864946&s=170667a&w=0&h=zZq7rG5McSptSIpEm9f8iTGd3Mrdkcslakr91T7qTYM="
                                 alt="">
                            <div class="py-3"><a class="motion-btn my-3 rounded  px-2 py-1" href="#">Motion-Design</a>
                            </div>
                            <h4 class="text-black fw-bold">Adobe Premiere Pro </h4>

                            <p class="text-secondary fw-bolder">156 Students</p>

                            <div class="btn-price d-flex justify-content-between">
                                <a class="purp_button rounded text-white fw-bolder p-2" href="#">Start learning</a>
                                <span class="fw-bolder purp-text  text-center">Free $0</span>
                            </div>

                        </div>
                    </div>
                    <div class="col-lg-3 my-3">
                        <div class="card popular-cources shadow p-3 bg-white rounded">
                            <img class="rounded"
                                 src="https://media.istockphoto.com/photos/elearning-education-concept-learning-online-picture-id1290864946?b=1&k=20&m=1290864946&s=170667a&w=0&h=zZq7rG5McSptSIpEm9f8iTGd3Mrdkcslakr91T7qTYM="
                                 alt="">
                            <div class="py-3"><a class="design-btn my-3 rounded  px-2 py-1" href="#">Design</a></div>
                            <h4 class="text-black fw-bold">Web-design</h4>

                            <p class="text-secondary fw-bolder">156 Students</p>

                            <div class="btn-price d-flex justify-content-between">
                                <a class="purp_button rounded text-white fw-bolder p-2" href="#">Start learning</a>
                                <span class="fw-bolder purp-text  text-center">Free $0</span>
                            </div>

                        </div>
                    </div>
                    <div class="col-lg-3 my-3">
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
            <div class="text-center">
                <button class="fw-bolder view-all text-center mt-5 mx-auto py-3 px-5" href="#">View All</button>
            </div>
        </div>
        </div>

        <div id="carouselExampleIndicators" class="carousel slide students-block" data-bs-ride="carousel"
             data-bs-touch="true" data-bs-interval="5000">
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0"
                        class="active indi-button" aria-current="true" aria-label="Slide 1"></button>
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1"
                        class="indi-button" aria-label="Slide 2"></button>
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2"
                        class="indi-button" aria-label="Slide 3"></button>
            </div>
            <div class="container">
                <div class="col-12 pt-5">
                    <h2 class="fw-bold text-white mb-0 fs-2">Our student voice</h2>
                    <hr class="hr">
                </div>
            </div>
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <div class="container mb-5 pb-5">
                        <div class="row d-flex justify-content-center">

                            <div class="col col-sm-12 col-md-6 text-c">

                                <p class="fw-bold text-white mb-3 mt-0 fs-5">“Excellent progression of material with...”
                                </p>


                                <p class="text-white mb-5 fs-5">Excellent progression of material with clear examples.
                                    <br>
                                    Format allows for replay and review for topics that require greater reinforcement.
                                    <br>
                                    Chapter sections are sized about right to learning and testing purpouses.
                                </p>

                                <p class="fw-bold text-white fs-5">Aidar Toktorbaev</p>
                                <p class="text-white fs-5">Bishkek , Kyrgyzstan</p>

                            </div>

                            <div class="col col-sm-12 col-md-6 text-center">
                                <img class="image-student"
                                     src="https://static8.depositphotos.com/1207999/1027/i/600/depositphotos_10275300-stock-photo-business-man-avatar-profile.jpg"
                                     alt="" srcset="">
                            </div>

                        </div>
                    </div>
                </div>
                <div class="carousel-item">
                    <div class="container mb-5 pb-5">
                        <div class="row d-flex justify-content-center">

                            <div class="col col-sm-12 col-md-6 text-c">

                                <p class="fw-bold text-white mb-3 mt-0 fs-5">“Excellent progression of material with...”
                                </p>


                                <p class="text-white mb-5 fs-5">Excellent progression of material with clear examples.
                                    <br>
                                    Format allows for replay and review for topics that require greater reinforcement.
                                    <br>
                                    Chapter sections are sized about right to learning and testing purpouses.
                                </p>

                                <p class="fw-bold text-white fs-5">Aidar Toktorbaev</p>
                                <p class="text-white fs-5">Bishkek , Kyrgyzstan</p>

                            </div>

                            <div class="col col-sm-12 col-md-6 text-center">
                                <img class="image-student"
                                     src="https://static8.depositphotos.com/1207999/1027/i/600/depositphotos_10275300-stock-photo-business-man-avatar-profile.jpg"
                                     alt="" srcset="">
                            </div>

                        </div>
                    </div>
                </div>
                <div class="carousel-item">
                    <div class="container mb-5 pb-5">
                        <div class="row d-flex justify-content-center">

                            <div class="col col-sm-12 col-md-6 text-c">

                                <p class="fw-bold text-white mb-3 mt-0 fs-5">“Excellent progression of material with...”
                                </p>


                                <p class="text-white mb-5 fs-5">Excellent progression of material with clear examples.
                                    <br>
                                    Format allows for replay and review for topics that require greater reinforcement.
                                    <br>
                                    Chapter sections are sized about right to learning and testing purpouses.
                                </p>

                                <p class="fw-bold text-white fs-5">Aidar Toktorbaev</p>
                                <p class="text-white fs-5">Bishkek , Kyrgyzstan</p>

                            </div>

                            <div class="col col-sm-12 col-md-6 text-center">
                                <img class="image-student"
                                     src="https://static8.depositphotos.com/1207999/1027/i/600/depositphotos_10275300-stock-photo-business-man-avatar-profile.jpg"
                                     alt="" srcset="">
                            </div>

                        </div>
                    </div>
                </div>
            </div>

        </div>


    </main>

    <footer>

    </footer>
</@main.renderWith>