<#import "partials/main.ftlh" as main />

<@main.renderWith title="Calopsia | Sign"
scripts=["/js/sign.js"]
styles=["/css/style.css","/css/sign.css"]
footer="false">
    <#assign security=JspTaglibs["http://www.springframework.org/security/tags"]/>


    <#if error??>
        <#if error>
            <div class="alert alert-danger alert-dismissible fade show " role="alert">
                <strong>Error!</strong> Wrong email and password
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>

        </#if>
    </#if>
    <div class="container <#if register??><#if register>right-panel-active</#if></#if>" id="container" >

        <div class="form-container sign-up-container">
            <form action="/register" method="post"  role="form" modelAttribute="registerForm">
                <h2>Create Account</h2>
                <div class="social-container">
                    <a href="#" class="social"><i class="bi bi-google"></i></a>
                    <a href="#" class="social"><i class="bi bi-telegram"></i></a>
                </div>
                <span>or use your email for registration</span>
                <input name="username" type="text" class="rounded" placeholder="Username" minlength="1" />
                <input name="email" type="email" class="rounded" placeholder="Email" minlength="1"/>
                <input name="password" type="password" class="rounded" placeholder="Password" minlength="8"/>
                <#if _csrf??>
                    <input type="hidden" name="${(_csrf.parameterName)!'csrf'}"
                           value="${(_csrf.token)!'--no-token--'}"/>
                </#if>
                <button type="submit">Sign Up</button>
            </form>
        </div>
        <div class="form-container sign-in-container">
            <form action="/login" method="post"  role="form">
                <h2>Sign in</h2>
                <div class="social-container">
                    <a href="#" class="social"><i class="bi bi-google"></i></a>
                    <a href="#" class="social"><i class="bi bi-telegram"></i></a>
                </div>
                <span>or use your account</span>
                <input type="email" name="username" class="rounded" placeholder="Email" />
                <input type="password" name="password" class="rounded" placeholder="Password" />
                <a href="#">Forgot your password?</a>
                <#if _csrf??>
                    <input type="hidden" name="${(_csrf.parameterName)!'csrf'}"
                           value="${(_csrf.token)!'--no-token--'}"/>
                </#if>
                <button type="submit">Sign In</button>
            </form>
        </div>
        <div class="overlay-container">
            <div class="overlay">
                <div class="overlay-panel overlay-left">
                    <h2>Welcome Back!</h2>
                    <p class="text-white">To keep connected with us please login with your personal info</p>
                    <button class="ghost" id="signIn">Sign In</button>
                </div>
                <div class="overlay-panel overlay-right">
                    <h2>Hello, Friend!</h2>
                    <p>Enter your personal details and start journey with us</p>
                    <button class="ghost" id="signUp">Sign Up</button>
                </div>
            </div>
        </div>
    </div>


</@main.renderWith>