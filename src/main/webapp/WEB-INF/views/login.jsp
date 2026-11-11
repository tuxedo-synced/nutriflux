<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title>Log in to your account — NutriFlux</title>

    <meta name="description"
          content="Log in to NutriFlux to access your food circularity dashboard." />

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@1,400;1,500;1,600;1,700&family=Plus+Jakarta+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;0,800;1,400;1,600&family=Space+Grotesk:wght@500;600;700&display=swap"
          rel="stylesheet">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/login.css">
</head>

<body>

<!-- ================= SITE HEADER ================= -->

<header class="site-header">
    <div class="container">

        <a href="${pageContext.request.contextPath}/home"
           class="brand-logo"
           aria-label="NutriFlux Home">

            <span class="brand-badge">n.</span>
            <span>nutriflux.</span>
        </a>

        <nav class="nav-links" aria-label="Primary Navigation">
            <a href="${pageContext.request.contextPath}/home#how-it-works"
               class="nav-link">How it works</a>

            <a href="${pageContext.request.contextPath}/home#impact"
               class="nav-link">Our impact</a>

            <a href="${pageContext.request.contextPath}/home#stories"
               class="nav-link">Stories</a>
        </nav>

        <div class="nav-actions">

            <a href="${pageContext.request.contextPath}/login"
               class="btn-pill btn-login-highlight"
               aria-current="page">

                <span>Log in</span>
            </a>

            <a href="${pageContext.request.contextPath}/register"
               class="btn-pill btn-dark">

                <span>Join the movement</span>

                <svg width="14" height="14"
                     viewBox="0 0 24 24"
                     fill="none"
                     stroke="currentColor"
                     stroke-width="2.5"
                     stroke-linecap="round"
                     stroke-linejoin="round">

                    <line x1="7" y1="17" x2="17" y2="7"></line>
                    <polyline points="7 7 17 7 17 17"></polyline>
                </svg>
            </a>

        </div>
    </div>
</header>


<main>

    <!-- ================= LOGIN SECTION ================= -->

    <section class="login-page-section">

        <div class="container">

            <div class="login-grid">

                <!-- LEFT BRAND CARD -->

                <div class="login-brand-card">

                    <div class="login-radar-arcs" aria-hidden="true">
                        <div class="radar-arc arc-1"></div>
                        <div class="radar-arc arc-2"></div>
                        <div class="radar-arc arc-3"></div>
                        <div class="radar-arc arc-4"></div>
                    </div>

                    <div class="login-brand-top">

                        <div class="brand-logo logo-light">

                            <span class="brand-badge badge-lime">n.</span>
                            <span>nutriflux.</span>

                        </div>

                    </div>

                    <div class="login-brand-body">

                        <div class="login-eyebrow-lime">
                            Your next good thing starts here
                        </div>

                        <h1 class="login-brand-heading">
                            Pick up where<br>
                            <span class="serif-italic text-lime">good</span>
                            begins.
                        </h1>

                        <p class="login-brand-sub">
                            One small connection can keep a whole lot
                            of good food in circulation.
                        </p>

                    </div>

                    <div class="login-brand-footer">

                        <span>Food Circularity</span>
                        <span>NutriFlux Loop</span>

                    </div>

                </div>


                <!-- RIGHT LOGIN FORM CARD -->

                <div class="login-form-card">

                    <div class="login-form-header">

                        <div class="eyebrow" style="margin-bottom: 0.65rem;">
                            <span>01 / Authentication</span>
                        </div>

                        <h2 class="login-form-title">
                            Log in to your account
                        </h2>

                        <p class="login-form-subtitle">
                            Select your network role to continue to your dashboard.
                        </p>

                    </div>


                    <!-- GOOGLE OAUTH -->

                    <a href="${pageContext.request.contextPath}/oauth2/authorization/google"
                       class="btn-google"
                       aria-label="Sign in with Google">

                        <svg class="google-icon"
                             viewBox="0 0 24 24"
                             aria-hidden="true">

                            <path fill="#4285F4"
                                  d="M23.745 12.27c0-.7-.06-1.4-.19-2.07H12v4.51h6.6c-.29 1.52-1.14 2.82-2.4 3.68v3.05h3.88c2.27-2.09 3.665-5.17 3.665-9.17z"/>

                            <path fill="#34A853"
                                  d="M12 24c3.24 0 5.95-1.08 7.93-2.91l-3.88-3.05c-1.08.72-2.45 1.16-4.05 1.16-3.12 0-5.77-2.1-6.72-4.93H1.25v3.15C3.26 21.36 7.33 24 12 24z"/>

                            <path fill="#FBBC05"
                                  d="M5.28 14.27c-.25-.72-.38-1.49-.38-2.27s.13-1.55.38-2.27V6.58H1.25C.45 8.18 0 9.98 0 12s.45 3.82 1.25 5.42l4.03-3.15z"/>

                            <path fill="#EA4335"
                                  d="M12 4.75c1.77 0 3.35.61 4.6 1.8l3.42-3.42C17.95 1.19 15.24 0 12 0 7.33 0 3.26 2.64 1.25 6.58l4.03 3.15c.95-2.83 3.6-4.98 6.72-4.98z"/>

                        </svg>

                        <span>Continue with Google</span>

                    </a>


                    <!-- DIVIDER -->

                    <div class="login-divider">
                        <span>Or sign in with email</span>
                    </div>


                    <!-- LOGIN FORM -->

                    <form class="auth-form"
                          action="${pageContext.request.contextPath}/process-login"
                          method="POST">

                          <input type="hidden"
                                 name="${_csrf.parameterName}"
                                 value="${_csrf.token}">

                        <!-- USERNAME / EMAIL -->

                        <div class="form-group">

                            <label for="user-email" class="form-label">
                                Email or Username
                            </label>

                            <input
                                type="text"
                                id="user-email"
                                name="userName"
                                class="form-input"
                                placeholder="name@organization.org"
                                required
                                autocomplete="username"
                            />

                        </div>


                        <!-- PASSWORD -->

                        <div class="form-group">

                            <div class="form-label-row">

                                <label for="user-password" class="form-label">
                                    Password
                                </label>

                                <a href="${pageContext.request.contextPath}/forgot-password"
                                   class="forgot-link">
                                    Forgot password?
                                </a>

                            </div>

                            <div class="input-password-wrap">

                                <input
                                    type="password"
                                    id="user-password"
                                    name="createPassword"
                                    class="form-input"
                                    placeholder="Enter your password"
                                    required
                                    autocomplete="current-password"
                                />

                                <button
                                    type="button"
                                    class="btn-toggle-password"
                                    id="togglePassword"
                                    aria-label="Show password">

                                    Show

                                </button>

                            </div>

                        </div>


                        <!-- REMEMBER ME -->

                        <div class="form-check-row">

                            <label class="custom-checkbox-wrap">

                                <input
                                    type="checkbox"
                                    name="remember"
                                    value="true"
                                    checked
                                />

                                <span class="custom-checkmark"></span>

                                <span class="checkbox-label">
                                    Keep me signed in for 30 days
                                </span>

                            </label>

                        </div>


                        <!-- SUBMIT BUTTON -->

                        <button type="submit" class="btn-submit-login">

                            <span>Sign in to NutriFlux</span>

                            <svg width="15"
                                 height="15"
                                 viewBox="0 0 24 24"
                                 fill="none"
                                 stroke="currentColor"
                                 stroke-width="2.5"
                                 stroke-linecap="round"
                                 stroke-linejoin="round">

                                <line x1="7" y1="17" x2="17" y2="7"></line>
                                <polyline points="7 7 17 7 17 17"></polyline>

                            </svg>

                        </button>

                    </form>


                    <!-- LOGIN ERROR -->

                    <%
                        String error = request.getParameter("error");
                        if (error != null) {
                    %>

                    <p class="login-error">
                        Invalid username or password. Please try again.
                    </p>

                    <%
                        }
                    %>


                    <!-- BOTTOM FOOTER -->

                    <div class="form-meta-footer">

                        <span class="encrypted-badge">

                            <span class="dot-indicator"></span>

                            <span>256-bit encrypted surplus routing</span>

                        </span>

                        <a href="#support" class="support-link">

                            <span>Help &amp; Support</span>

                            <svg width="12"
                                 height="12"
                                 viewBox="0 0 24 24"
                                 fill="none"
                                 stroke="currentColor"
                                 stroke-width="2.5"
                                 stroke-linecap="round"
                                 stroke-linejoin="round">

                                <line x1="7" y1="17" x2="17" y2="7"></line>
                                <polyline points="7 7 17 7 17 17"></polyline>

                            </svg>

                        </a>

                    </div>

                    <p class="switch-auth">
                        New to the loop?

                        <a href="${pageContext.request.contextPath}/register">
                            Create an account ↗
                        </a>
                    </p>

                </div>

            </div>

        </div>

    </section>

</main>


<!-- ================= SITE FOOTER ================= -->

<footer class="site-footer">

    <div class="container">

        <div class="footer-content">

            <div class="footer-left">

                <a href="${pageContext.request.contextPath}/home"
                   class="brand-logo"
                   aria-label="NutriFlux Home">

                    <span class="brand-badge">n.</span>
                    <span>nutriflux.</span>

                </a>

                <span class="footer-separator">|</span>

                <span class="footer-network-tag">
                    Food Circularity Network
                </span>

            </div>


            <div class="footer-right">

                <nav class="footer-legal-links"
                     aria-label="Legal Navigation">

                    <a href="#privacy">Privacy Policy</a>
                    <a href="#terms">Terms of Service</a>

                </nav>

                <div class="footer-tagline">
                    Good food. Better routes.
                </div>

            </div>

        </div>

    </div>

</footer>
<script>

    const passwordInput = document.getElementById('user-password');

    const toggleButton = document.getElementById('togglePassword');

    if (toggleButton && passwordInput) {

        toggleButton.addEventListener('click', () => {

            const isPassword =
                passwordInput.getAttribute('type') === 'password';

            passwordInput.setAttribute(
                'type',
                isPassword ? 'text' : 'password'
            );

            toggleButton.textContent = isPassword ? 'Hide' : 'Show';

            toggleButton.setAttribute(
                'aria-label',
                isPassword ? 'Hide password' : 'Show password'
            );

        });

    }

</script>

</body>
</html>
