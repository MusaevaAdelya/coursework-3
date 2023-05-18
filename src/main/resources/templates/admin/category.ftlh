<#import "../partials/main.ftlh" as main />

<#assign extraScriptAfterMarkup>
    <script>
        $(document).ready(function () {
            // инициализация Nestable
            $('.dd').nestable({
                maxDepth: 10,
                dragElement: '.dd-handle',
                preventVoidMoves: false,
            });
            $('.dd-btn, button').on('mousedown', function (e) {
                e.stopPropagation();
            });

        });


    </script>
</#assign>


<@main.renderWith title="Calopsia | Admin"
scripts=["/js/script.js", "/js/admin.js"]
styles=["/css/style.css","/css/admin.css"] extraScriptAfter=extraScriptAfterMarkup>
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
                        <h1 class="h3 mb-4 text-gray-800">Categories</h1>

                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">Categories</h5>
                                <div class="row">
                                    <div class="col-md-3">
                                        <form>
                                            <div class="form-group">
                                                <label for="categoryName">Name:</label>
                                                <input type="text" class="form-control" id="categoryName"
                                                       placeholder="Enter category name">
                                            </div>
                                            <button id="add-item" class="btn btn-primary">Add Category</button>
                                        </form>
                                    </div>
                                    <div class="col-md-9">
                                        <div class="nestable-list-group" data-drag="false">
                                            <#macro renderCategory category>
                                                <li class="dd-item" data-category-id="${category.categoryDto.id}">
                                                    <button class="dd-collapse" data-action="collapse" type="button">
                                                        Collapse
                                                    </button>
                                                    <button class="dd-expand" data-action="expand" type="button">
                                                        Expand
                                                    </button>
                                                    <div class="dd-handle">
                                                        <div class="dd-handle-container d-flex">
                                                            <span>${category.categoryDto.name}</span>
                                                            <span class="buttons">
                    <#if category.categoryDto.id != 1>
                        <button class="deleteCategoryBtn btn dd-btn btn-danger btn-sm ml-2"
                                data-bs-toggle="modal"
                                data-category-id=${category.categoryDto.id}
                                data-bs-target="#deleteModal">
                            <i class="bi bi-trash"></i>
                        </button>
                    </#if>
                    <button class="editCategoryNameBtn btn dd-btn btn-info btn-sm ml-2"
                            data-bs-toggle="modal"
                            data-category-id=${category.categoryDto.id}
                            data-bs-target="#editModal">
                        <i class="bi bi-pen"></i>
                    </button>
                </span>
                                                        </div>
                                                    </div>
                                                    <#if category.children?has_content>
                                                        <ol class="dd-list">
                                                            <#list category.children as child>
                                                                <@renderCategory category=child />
                                                            </#list>
                                                        </ol>
                                                    </#if>
                                                </li>
                                            </#macro>

                                            <#macro renderCategories categories>
                                                <#list categories as category>
                                                    <@renderCategory category=category />
                                                </#list>
                                            </#macro>

                                            <div class="dd" id="nestable">
                                                <ol class="dd-list">
                                                    <@renderCategories categories=categories />
                                                </ol>
                                            </div>
                                        </div>
                                    </div>
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
            <i class="bis bi-angle-up"></i>
        </a>

        <!-- Delete Modal -->
        <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel"
             aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="deleteModalLabel">Delete Category</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        Are you sure you want to delete this category?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="button" class="deleteConfirmBtn btn btn-sm btn-danger">Delete</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Edit Modal -->
        <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel"
             aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editModalLabel">Edit Category Name</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form>
                            <div class="form-group">
                                <label for="editCategoryName">Name:</label>
                                <input type="text" class="form-control" id="editCategoryName"
                                       placeholder="Enter new category name">
                            </div>
                            <button type="submit" class="saveNewCategoryNameBtn btn btn-primary" data-category-id="0">Save Changes</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>


    </main>
</@main.renderWith>