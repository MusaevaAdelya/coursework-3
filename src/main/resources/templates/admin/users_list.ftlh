<#import "../partials/main.ftlh" as main />




<@main.renderWith title="Calopsia | Admin"
scripts=["/js/script.js", "/js/admin.js"]
styles=["/css/admin.css", "/css/style.css"]>
    <#assign security=JspTaglibs["http://www.springframework.org/security/tags"]/>

    <main id="page-top" xmlns="http://www.w3.org/1999/html">

        <!-- Page Wrapper -->
        <div id="wrapper">

            <!-- Sidebar -->
            <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

                <!-- Sidebar - Brand -->
                <a class="sidebar-brand d-flex align-items-center justify-content-center" href="index.html">
                    <img class="fas fa-fw" src="img/calopsia_logo_c.svg"></img>

                    <div class="sidebar-brand-text mx-3">Calopsia</div>
                </a>

                <!-- Divider -->
                <hr class="sidebar-divider my-0">

                <!-- Nav Item - Dashboard -->
                <li class="nav-item">
                    <a class="nav-link" href="/admin">
                        <i class="fas fa-fw fa-tachometer-alt"></i>
                        <span>Dashboard</span></a>
                </li>

                <!-- Divider -->
                <hr class="sidebar-divider">

                <!-- Heading -->
                <div class="sidebar-heading">
                    Menu
                </div>

                <!-- Nav Item - Pages Menu -->
                <li class="nav-item active">
                    <a class="nav-link" href="/admin/users">
                        <i class="fas fa-fw fa-user"></i>
                        <span>Users</span></a>
                </li>

                <!-- Nav Item - Pages Menu -->
                <li class="nav-item">
                    <a class="nav-link" href="/admin/courses">
                        <i class="fas fa-fw fa-layer-group"></i>
                        <span>Courses</span></a>
                </li>

                <!-- Nav Item - Pages Menu -->
                <li class="nav-item">
                    <a class="nav-link" href="categories.html">
                        <i class="fas fa-fw fa-bars"></i>
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
                                    <i class="fas fa-search fa-fw"></i>
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
                                                    <i class="fas fa-search fa-sm"></i>
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
                                        <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
                                        Settings
                                    </a>
                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                                        <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
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
                        <h1 class="h3 mb-4 text-gray-800">Users</h1>
                        <!-- DataTales Example -->
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">All users</h6>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                        <thead>
                                        <tr>
                                            <th>Username</th>
                                            <th>Email</th>
                                            <th>Role</th>
                                            <th>Created</th>
                                            <th>Studying</th>
                                            <th>Balance</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                        </thead>
                                        <tfoot>
                                        <tr>
                                            <th>Username</th>
                                            <th>Email</th>
                                            <th>Role</th>
                                            <th>Created</th>
                                            <th>Studying</th>
                                            <th>Balance</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                        </tfoot>
                                        <tbody>
                                        <#if users??>
                                            <#list users as user>
                                                <tr>
                                                    <td>${user.username}</td>
                                                    <td>${user.email}</td>
                                                    <td>${user.role}</td>
                                                    <#if user.createdCourses?size != 0>
                                                        <td>${user.createdCourses?size}</td>
                                                    <#else>
                                                        <td>0</td>
                                                    </#if>
                                                    <#if user.studyingCourses?size != 0>
                                                        <td>${user.studyingCourses?size}</td>
                                                    <#else>
                                                        <td>0</td>
                                                    </#if>
                                                    <td>${user.coins}$</td>
                                                    <#if user.enabled>
                                                        <td class="text-success">Active</td>
                                                    <#else>
                                                        <td class="text-danger">Blocked</td>
                                                    </#if>
                                                    <td>
                                                        <button type="button" data-bs-toggle="modal"
                                                                data-user-email="${user.email}"
                                                                data-bs-target="#profile-modal"
                                                                class="openUserModalBtn btn btn-primary btn-icon-split btn-sm">
                                                <span class="icon text-white-50">
                                                    <i class="bi-pen"></i>
                                                </span>
                                                            <span class="text">Edit</span>
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
                    <!-- /.container-fluid -->
                </div>
                <!-- End of Main Content -->


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
            <i class="fas fa-angle-up"></i>
        </a>

        <!-- ModalUser -->
        <div class="modal fade" id="profile-modal" tabindex="-1" aria-labelledby="profile-modal-title"
             aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <form id="userForm" method="POST" action="/admin/userUpdate" modelAttribute="newUserData"
                          enctype="multipart/form-data">
                        <#if _csrf??>
                            <input type="hidden" name="${(_csrf.parameterName)!'csrf'}"
                                   value="${(_csrf.token)!'--no-token--'}"/>
                        </#if>
                        <div class="modal-header">
                            <h5 class="modal-title" id="profile-modal-title">User Settings</h5>
                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <ul class="user_settings_tabs nav nav-tabs">
                                <li class="nav-item">
                                    <a class="nav-link active" data-bs-toggle="tab" href="#profile">Settings</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" data-bs-toggle="tab" href="#created-courses">Created Courses</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" data-bs-toggle="tab" href="#studying-courses">Learning
                                        Courses</a>
                                </li>
                            </ul>
                            <!-- Содержимое вкладок -->
                            <div class="tab-content pt-4">
                                <!-- Вкладка "Профиль" -->
                                <div class="tab-pane fade show active" id="profile">
                                    <div class="row">
                                        <div class="col-6 form-group">
                                            <label for="username">Username</label>
                                            <input type="text" class="form-control text-dark font-weight-bolder"
                                                   id="username" value="${user.username}" placeholder="Username"
                                                   name="newUsername">
                                        </div>
                                        <div class="col-6 form-group">
                                            <label for="email">Email</label>
                                            <input type="email" class="form-control text-dark font-weight-bolder"
                                                   name="newEmail"
                                                   id="email" value="${user.email}" placeholder="Email">
                                            <input type="hidden" id="originalEmail" name="originalEmail"
                                                   value="${user.email}">

                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="role">Role</label>
                                        <select class="form-control text-dark font-weight-bolder" id="role"
                                                name="newRole">
                                            <option value="ADMIN">Admin</option>
                                            <option value="USER">User</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="balance">Balance</label>
                                        <input type="text" class="form-control  text-dark font-weight-bolder"
                                               name="newBalance"
                                               id="balance" placeholder="0" value="600$">
                                    </div>
                                    <div class="form-group">
                                        <label for="status">Status</label>
                                        <select class="form-control text-dark font-weight-bolder" id="status"
                                                name="newStatus">
                                            <option value="Active" type="text">Active</option>
                                            <option value="Blocked" type="text">Blocked</option>
                                        </select>
                                    </div>
                                </div>

                                <!-- Вкладка "Созданные курсы" -->
                                <div class="tab-pane fade show" id="created-courses">
                                    <div class="filter-bar mb-4">
                                        <label for="created-courses-filter">Filter:</label>
                                        <select class="form-control" id="created-courses-filter">
                                            <option value="ALL">All</option>
                                            <option value="ACCEPTED">Active</option>
                                            <option value="MODERATION">Moderation</option>
                                            <option value="DECLINED">Declined</option>
                                        </select>
                                    </div>
                                    <div class="course-list">
                                        <div class="row" id="created_course-list">
                                            <#if user.createdCourses??>
                                                <#list user.createdCourses as courses>
                                                    <div class="col-md-4">
                                                        <a href="#" class="text-decoration-none">
                                                            <div class="course">
                                                                <div class="course-image">
                                                                    <img src="${coursesPath}${courses.thumbNailPath}"
                                                                         alt="Курс 1">
                                                                </div>
                                                                <div class="course-info">
                                                                    <h3>${courses.name}</h3>
                                                                    <p>${courses.status}</p>
                                                                </div>
                                                            </div>
                                                        </a>
                                                    </div>
                                                </#list>
                                            </#if>
                                        </div>
                                    </div>
                                </div>

                                <!-- Вкладка "Изучаемые курсы" -->
                                <div class="tab-pane fade" id="studying-courses">
                                    <div class="filter-bar mb-4">
                                        <label for="studying-courses-filter">Filter:</label>
                                        <select class="form-control" id="studying-courses-filter">
                                            <option value="ALL">All</option>
                                            <option value="learning">Learning</option>
                                            <option value="finished">Finished</option>
                                        </select>
                                    </div>
                                    <div class="course-list">
                                        <div class="row" id="studying_course-list">
                                            <#if user.studyingCourses??>
                                                <#list user.studyingCourses as courses>
                                                    <div class="col-md-4">
                                                        <a href="#" class="text-decoration-none">
                                                            <div class="course">
                                                                <div class="course-image">
                                                                    <img src="${coursesPath}${courses.thumbNailPath}"
                                                                         alt="Курс 1">
                                                                </div>
                                                                <div class="course-info">
                                                                    <h3>${courses.name}</h3>
                                                                    <p>${courses.status}</p>
                                                                </div>
                                                            </div>
                                                        </a>
                                                    </div>
                                                </#list>
                                            </#if>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button class="btn saveUserBtn btn-primary" type="submit" data-bs-dismiss="modal"
                                    data-user-email="${user.email}">Save
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- End of ModalUser -->

        <!-- Logout Modal-->
        <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
             aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
                    <div class="modal-footer">
                        <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                        <a class="btn btn-primary" href="login.html">Logout</a>
                    </div>
                </div>
            </div>
        </div>

    </main>


</@main.renderWith>