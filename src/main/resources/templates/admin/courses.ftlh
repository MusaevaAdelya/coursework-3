<#import "../partials/main.ftlh" as main />

<@main.renderWith title="Calopsia | Admin"
scripts=["/js/script.js", "/js/admin.js"]
styles=["/css/style.css","/css/admin.css"]>
    <#assign security=JspTaglibs["http://www.springframework.org/security/tags"]/>


    <main>
        <!-- Page Wrapper -->
        <div id="wrapper">

            <!-- Sidebar -->
            <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

                <!-- Sidebar - Brand -->
                <a class="sidebar-brand d-flex align-items-center justify-content-center" href="/">
                    <#--                    <img class="bis bi-fw" src="/img/calopsia_logo_c.svg"></img>-->
                    <img class="fas fa-fw" src="/img/calopsia_logo_c.svg" alt="">

                    <div class="sidebar-brand-text mx-3">Calopsia</div>
                </a>

                <!-- Divider -->
                <hr class="sidebar-divider my-0">

                <!-- Nav Item - Dashboard -->
                <li class="nav-item active">
                    <a class="nav-link" href="/admin">
                        <i class="bi bi-speedometer2"></i>
                        <span>Dashboard</span></a>
                </li>

                <!-- Divider -->
                <hr class="sidebar-divider">

                <!-- Heading -->
                <div class="sidebar-heading">
                    Menu
                </div>

                <!-- Nav Item - Pages Menu -->
                <li class="nav-item">
                    <a class="nav-link" href="/admin/users">
                        <i class="bis bi bi-people"></i>
                        <span>Users</span></a>
                </li>

                <!-- Nav Item - Pages Menu -->
                <li class="nav-item">
                    <a class="nav-link" href="/admin/courses">
                        <i class="bi bi-stack"></i>
                        <span>Courses</span></a>
                </li>

                <!-- Nav Item - Pages Menu -->
                <li class="nav-item">
                    <a class="nav-link" href="/admin/categories">
                        <i class="bi bi-bar-chart-steps"></i>
                        <span>Categories</span></a>
                </li>


                <!-- Divider -->
                <hr class="sidebar-divider d-none d-md-block">

                <!-- Sidebar Toggler (Sidebar) -->
                <div class="text-center d-none d-md-inline">
                    <button class="rounded-circle border-0" id="sidebarToggle"></button>
                </div>
            </ul>
            <!-- End of Sidebar -->

            <!-- Content Wrapper -->
            <div id="content-wrapper" class="d-flex flex-column">

                <!-- Main Content -->
                <div id="content">

                    <!-- Topbar -->
                    <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                        <!-- Sidebar Toggle (Topbar) -->
                        <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                            <i class="fa fa-bars"></i>
                        </button>

                        <!-- Topbar Navbar -->
                        <ul class="navbar-nav ml-auto">

                            <!-- Nav Item - Search Dropdown (Visible Only XS) -->
                            <li class="nav-item dropdown no-arrow d-sm-none">
                                <a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button"
                                   data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <i class="bis bi-search fa-fw"></i>
                                </a>
                                <!-- Dropdown - Messages -->
                                <div class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
                                     aria-labelledby="searchDropdown">
                                    <form class="form-inline mr-auto w-100 navbar-search">
                                        <div class="input-group">
                                            <input type="text" class="form-control bg-light border-0 small"
                                                   placeholder="Search for..." aria-label="Search"
                                                   aria-describedby="basic-addon2">
                                            <div class="input-group-append">
                                                <button class="btn btn-primary" type="button">
                                                    <i class="bis bi-search fa-sm"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </li>


                            <div class="topbar-divider d-none d-sm-block"></div>

                            <!-- Nav Item - User Information -->
                            <li class="nav-item dropdown no-arrow">
                                <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                                   data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <span class="mr-2 d-none d-lg-inline text-gray-600 small">Musaeva Adelya</span>
                                    <img class="img-profile rounded-circle"
                                         src="img/undraw_profile.svg">
                                </a>
                                <!-- Dropdown - User Information -->
                                <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                     aria-labelledby="userDropdown">
                                    <a class="dropdown-item" href="#">
                                        <i class="bis bi-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
                                        Settings
                                    </a>
                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                                        <i class="bis bi-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                        Logout
                                    </a>
                                </div>
                            </li>

                        </ul>

                    </nav>
                    <!-- End of Topbar -->

                    <!-- Begin Page Content -->
                    <div class="container-fluid">

                        <!-- Page Heading -->
                        <h1 class="h3 mb-4 text-gray-800">Courses</h1>

                        <ul class="nav nav-pills pills-courses mb-3" id="pills-tab" role="tablist">
                            <li class="nav-item shadow mr-3" role="presentation">
                                <button class="nav-link active" id="pills-home-tab" data-bs-toggle="pill"
                                        data-bs-target="#pills-active" type="button" role="tab"
                                        aria-controls="pills-active" aria-selected="true">Active
                                </button>
                            </li>
                            <li class="nav-item shadow mr-3" role="presentation">
                                <button class="nav-link" id="pills-profile-tab" data-bs-toggle="pill"
                                        data-bs-target="#pills-moderating" type="button" role="tab"
                                        aria-controls="pills-moderating" aria-selected="false">Moderating
                                </button>
                            </li>
                            <li class="nav-item shadow mr-3" role="presentation">
                                <button class="nav-link" id="pills-contact-tab" data-bs-toggle="pill"
                                        data-bs-target="#pills-deleted" type="button" role="tab"
                                        aria-controls="pills-deleted" aria-selected="false">Deleted
                                </button>
                            </li>
                        </ul>
                        <div class="tab-content" id="pills-tabContent">
                            <div class="tab-pane fade show active" id="pills-active" role="tabpanel"
                                 aria-labelledby="pills-home-tab">
                                <div class="card shadow mb-4">
                                    <div class="card-header py-3">
                                        <h6 class="m-0 font-weight-bold text-primary">Active courses</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-bordered" id="activeTable" width="100%"
                                                   cellspacing="0">
                                                <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Name</th>
                                                    <th>Status</th>
                                                    <th>Teacher</th>
                                                    <th>Rating</th>
                                                    <th>Category</th>
                                                    <th>Date of creation</th>
                                                    <th>Action</th>
                                                </tr>
                                                </thead>
                                                <tfoot>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Name</th>
                                                    <th>Status</th>
                                                    <th>Teacher</th>
                                                    <th>Rating</th>
                                                    <th>Category</th>
                                                    <th>Date of creation</th>
                                                    <th>Action</th>
                                                </tr>
                                                </tfoot>
                                                <tbody id="activeCoursesList">
                                                <#if activeCourses??>
                                                    <#list activeCourses as course>
                                                        <tr>
                                                            <td>${course.id}</td>
                                                            <td>${course.name}</td>
                                                            <td>
                                                                <button type="button" data-bs-toggle="modal"
                                                                        data-bs-target="#success-modal"
                                                                        data-course-id="${course.id}"
                                                                        class="deleteCourseFromActive btn btn-success btn-sm">
                                                                    <span class="text">Active</span>
                                                                </button>
                                                            </td>
                                                            <td>${course.teacher.username}</td>
                                                            <td>
                                                <span class="icon text-warning">
                                                    <i class="bis bi-star"></i>
                                                </span>${course.ratingScore}
                                                            </td>
                                                            <td>${course.category.name}</td>
<#--                                                            <td>${course.dateOn.dayOfMonth}-${course.dateOn.monthValue}-->
<#--                                                                -${course.dateOn.year}</td>-->
                                                            <td>
                                                                <button type="button" data-bs-toggle="modal"
                                                                        data-bs-target="#profile-modal"
                                                                        data-course-id="${course.id}"
                                                                        class="openCourseModalBtn btn btn-info btn-icon-split btn-sm">
                                                <span class="icon text-white-50">
                                                    <i class="bi bi-eye"></i>
                                                </span>
                                                                    <span class="text">See details</span>
                                                                </button>
                                                            </td>
                                                        </tr>
                                                    </#list>
                                                </#if>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="pills-moderating" role="tabpanel"
                                 aria-labelledby="pills-profile-tab">
                                <div class="card shadow mb-4">
                                    <div class="card-header py-3">
                                        <h6 class="m-0 font-weight-bold text-primary">Moderating courses</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-bordered" id="moderatingTable" width="100%"
                                                   cellspacing="0">
                                                <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Name</th>
                                                    <th>Status</th>
                                                    <th>Teacher</th>
                                                    <th>Category</th>
                                                    <th>Date of creation</th>
                                                    <th>Action</th>
                                                </tr>
                                                </thead>
                                                <tfoot>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Name</th>
                                                    <th>Status</th>
                                                    <th>Teacher</th>
                                                    <th>Category</th>
                                                    <th>Date of creation</th>
                                                    <th>Action</th>
                                                </tr>
                                                </tfoot>
                                                <tbody id="moderCoursesList">
                                                <#if moderatingCourses??>
                                                    <#list moderatingCourses as course>
                                                        <tr>
                                                            <td>${course.id}</td>
                                                            <td>${course.name}</td>
                                                            <td>
                                                                <button type="button" data-toggle="modal"
                                                                        data-target="#success-modal"
                                                                        data-course-id="${course.id}"
                                                                        class="btn btn-warning btn-sm">
                                                                    <span class="text">Moderating</span>
                                                                </button>
                                                            </td>
                                                            <td>${course.teacher.username}</td>
                                                            <td>${course.category.name}</td>
<#--                                                            <td>${course.dateOn.dayOfMonth}-${course.dateOn.monthValue}-->
<#--                                                                -${course.dateOn.year}</td>-->
                                                            <td>
                                                                <button type="button" data-bs-toggle="modal"
                                                                        data-bs-target="#profile-modal"
                                                                        data-course-id="${course.id}"
                                                                        class="openCourseModalBtn btn btn-info btn-icon-split btn-sm">
                                                                    <span class="text"><i class="bis bi-eye"></i></span>
                                                                </button>
                                                                <button type="button" data-bs-toggle="modal"
                                                                        data-bs-target="#success-modal"
                                                                        data-course-id="${course.id}"
                                                                        class="activeCourseFromDeleted btn btn-success btn-icon-split btn-sm">
                                                    <span class="text">
                                                        <i class="bis bi-check"></i>
                                                    </span>
                                                                </button>
                                                                <button type="button" data-bs-toggle="modal"
                                                                        data-bs-target="#success-modal"
                                                                        data-course-id="${course.id}"
                                                                        class="deleteCourseFromActive btn btn-danger btn-icon-split btn-sm">
                                                                    <span class="text"><i
                                                                                class="bis bi-trash"></i></span>
                                                                </button>
                                                            </td>
                                                        </tr>
                                                    </#list>
                                                </#if>

                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="pills-deleted" role="tabpanel"
                                 aria-labelledby="pills-contact-tab">
                                <div class="card shadow mb-4">
                                    <div class="card-header py-3">
                                        <h6 class="m-0 font-weight-bold text-primary">Deleted courses</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-bordered" id="deletedTable" width="100%"
                                                   cellspacing="0">
                                                <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Name</th>
                                                    <th>Status</th>
                                                    <th>Teacher</th>
                                                    <th>Rating</th>
                                                    <th>Category</th>
                                                    <th>Date of creation</th>
                                                    <th>Action</th>
                                                </tr>
                                                </thead>
                                                <tfoot>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Name</th>
                                                    <th>Status</th>
                                                    <th>Teacher</th>
                                                    <th>Rating</th>
                                                    <th>Category</th>
                                                    <th>Date of creation</th>
                                                    <th>Action</th>
                                                </tr>
                                                </tfoot>
                                                <tbody id="deletedCoursesList">
                                                <#if declinedCourses??>
                                                    <#list declinedCourses as course>
                                                        <tr>
                                                            <td>${course.id}</td>
                                                            <td>${course.name}</td>
                                                            <td>
                                                                <button type="button" data-bs-toggle="modal"
                                                                        data-bs-target="#success-modal"
                                                                        data-course-id="${course.id}"
                                                                        class="activeCourseFromDeleted btn btn-danger btn-sm">
                                                                    <span class="text">Deleted</span>
                                                                </button>
                                                            </td>
                                                            <td>${course.teacher.username}</td>
                                                            <td>
                                                <span class="icon text-warning">
                                                    <i class="bis bi-star"></i>
                                                </span>${course.ratingScore}
                                                            </td>
                                                            <td>${course.category.name}</td>
<#--                                                            <td>${course.dateOn.dayOfMonth}-${course.dateOn.monthValue}-->
<#--                                                                -${course.dateOn.year}</td>-->
                                                            <td>
                                                                <button type="button" data-bs-toggle="modal"
                                                                        data-bs-target="#profile-modal"
                                                                        data-course-id="${course.id}"
                                                                        class="openCourseModalBtn btn btn-info btn-icon-split btn-sm">
                                                <span class="icon text-white-50">
                                                    <i class="bi bi-eye"></i>
                                                </span>
                                                                    <span class="text">See details</span>
                                                                </button>
                                                            </td>
                                                        </tr>
                                                    </#list>
                                                </#if>

                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    <!-- /.container-fluid -->
                </div>
                <!-- End of Main Content -->


                <!-- Modal Success -->
                <div class="modal fade" id="success-modal" tabindex="-1" role="dialog"
                     aria-labelledby="exampleModalLabel"
                     aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="success-modal-label">Are you sure?</h5>
                                <button class="close" type="button" data-bs-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">×</span>
                                </button>
                            </div>
                            <div class="modal-body">Do you really want to do this?</div>
                            <div class="modal-footer">
                                <a class="btn btn-primary" data-bs-dismiss="modal" id="modalSuccessButton">Yes</a>
                                <button class="btn btn-secondary" type="button" data-bs-dismiss="modal">Cancel</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- End of Modal Success -->

                <!-- Modal Course Info -->
                <div class="modal fade" id="profile-modal" tabindex="-1" role="dialog"
                     aria-labelledby="profile-modal-title" aria-hidden="true">
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="profile-modal-title">Course Settings</h5>
                                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <ul class="user_settings_tabs nav nav-tabs">
                                    <li class="nav-item">
                                        <a class="nav-link active" data-bs-toggle="tab" href="#course-info">Info</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" data-bs-toggle="tab" href="#students-on-course">Students</a>
                                    </li>
                                </ul>

                                <!-- tabs content -->
                                <div class="tab-content pt-4">
                                    <!-- Tab "Info" -->
                                    <div class="tab-pane fade show active" id="course-info">
                                        <div class="row">
                                            <div class="col-12">
                                                <h2 id="courseName">Course Name</h2>
                                            </div>
                                        </div>
                                        <hr>
                                        <div class="row">
                                            <div class="col-md-4">
                                                <img src="https://picsum.photos/200/150?random=1" alt="Course Image"
                                                     class="img-fluid rounded mb-3" id="courseImage">
                                            </div>
                                            <div class="col-md-4">
                                                <p class="card-text" id="teacher"><b>Teacher:</b> John Doe</p>
                                                <p class="card-text" id="category"><b>Category:</b> Category 1</p>
                                                <p class="card-text" id="coins"><b>Coins:</b> 10 <i
                                                            class="bi bi-coins text-warning"></i></p>
                                                <p class="card-text" id="status"><b>Status:</b>
                                                    <text class="text-success">Active</text>
                                                </p>
                                                <p class="card-text" id="createdOn"><b>Created on:</b> 2022-01-01</p>
                                                <p class="card-text" id="rating"><b>Rating:</b> <i
                                                            class="bi bi-star text-warning"></i> 4.5</p>
                                            </div>
                                            <div class="col-md-4">
                                                <h5 class="card-text font-weight-bold">Course Sections:</h5>
                                                <ul class="list-unstyled" id="sections">
                                                    <li>Section 1</li>
                                                    <li>Section 2</li>
                                                    <li>Section 3</li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Tab "Students" -->
                                    <div class="tab-pane fade show" id="students-on-course">
                                        <div class="table table-responsive ">
                                            <table class="table table-bordered" id="studentsTable" width="100%"
                                                   cellspacing="0">
                                                <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Name</th>
                                                    <th>Date of entry</th>
                                                    <th>Action</th>
                                                </tr>
                                                </thead>
                                                <tfoot>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Name</th>
                                                    <th>Date of entry</th>
                                                    <th>Action</th>
                                                </tr>
                                                </tfoot>
                                                <tbody id="course-users">
                                                <tr>
                                                    <td>1</td>
                                                    <td>Aidar T.</td>
                                                    <td>03.04.2023</td>
                                                    <td>
                                                        <button type="button"
                                                                class="btn btn-danger btn-icon-split btn-sm">
                                                    <span class="icon text-white-50">
                                                        <i class="bis bi-trash"></i>
                                                    </span>
                                                            <span class="text">Dismiss</span>
                                                        </button>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>2</td>
                                                    <td>Nikolay G.</td>
                                                    <td>03.04.2023</td>
                                                    <td>
                                                        <button type="button"
                                                                class="btn btn-danger btn-icon-split btn-sm">
                                                    <span class="icon text-white-50">
                                                        <i class="bis bi-trash"></i>
                                                    </span>
                                                            <span class="text">Dismiss</span>
                                                        </button>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>3</td>
                                                    <td>Adelya M.</td>
                                                    <td>03.04.2023</td>
                                                    <td>
                                                        <button type="button"
                                                                class="delete-user-from-course btn btn-danger btn-icon-split btn-sm"
                                                                data-user-id="1">
                                                    <span class="icon text-white-50">
                                                        <i class="bis bi-trash"></i>
                                                    </span>
                                                            <span class="text">Dismiss</span>
                                                        </button>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>4</td>
                                                    <td>Ilya Y.</td>
                                                    <td>03.04.2023</td>
                                                    <td>
                                                        <button type="button"
                                                                class="btn btn-danger btn-icon-split btn-sm">
                                                    <span class="icon text-white-50">
                                                        <i class="bis bi-trash"></i>
                                                    </span>
                                                            <span class="text">Dismiss</span>
                                                        </button>
                                                    </td>
                                                </tr>

                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- End of Modal Course Info -->

                <!-- Footer -->
                <footer class="sticky-footer bg-white">
                    <div class="container my-auto">
                        <div class="copyright text-center my-auto">
                            <span>Copyright &copy; Calopsia 2023</span>
                        </div>
                    </div>
                </footer>
                <!-- End of Footer -->

            </div>
            <!-- End of Content Wrapper -->

        </div>
        <!-- End of Page Wrapper -->

        <!-- Scroll to Top Button-->
        <a class="scroll-to-top rounded" href="#page-top">
            <i class="bis bi-angle-up"></i>
        </a>

    </main>
</@main.renderWith>