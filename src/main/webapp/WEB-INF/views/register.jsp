<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create account — NutriFlux</title>
    <meta name="description" content="Create your NutriFlux account and join the food circularity network.">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@1,400;1,500;1,600;1,700&family=Plus+Jakarta+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;0,800;1,400;1,600&family=Space+Grotesk:wght@500;600;700&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/register.css">
</head>
<body>

<header class="site-header">
    <div class="container">
        <a href="${pageContext.request.contextPath}/home" class="brand-logo" aria-label="NutriFlux Home">
            <span class="brand-badge">n.</span>
            <span>nutriflux.</span>
        </a>

        <nav class="nav-links" aria-label="Main navigation">
            <a href="${pageContext.request.contextPath}/home#how-it-works" class="nav-link">How it works</a>
            <a href="${pageContext.request.contextPath}/home#impact" class="nav-link">Our impact</a>
            <a href="${pageContext.request.contextPath}/home#stories" class="nav-link">Stories</a>
        </nav>

        <div class="nav-actions">
            <a href="${pageContext.request.contextPath}/login" class="btn-pill btn-outline">Log in</a>
            <a href="${pageContext.request.contextPath}/register" class="btn-pill btn-dark" aria-current="page">
                <span>Join the movement</span>
                <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <line x1="7" y1="17" x2="17" y2="7"></line>
                    <polyline points="7 7 17 7 17 17"></polyline>
                </svg>
            </a>
        </div>
    </div>
</header>

<main class="register-page-section">
    <div class="container register-grid">

        <section class="register-brand-card" aria-label="NutriFlux introduction">
            <div class="register-brand-top">
                <a href="${pageContext.request.contextPath}/home" class="brand-logo logo-light" aria-label="NutriFlux Home">
                    <span class="brand-badge badge-lime">n.</span>
                    <span>nutriflux.</span>
                </a>
            </div>

            <div class="register-radar-arcs" aria-hidden="true">
                <span class="register-radar-arc arc-1"></span>
                <span class="register-radar-arc arc-2"></span>
                <span class="register-radar-arc arc-3"></span>
                <span class="register-radar-arc arc-4"></span>
            </div>

            <div class="register-brand-body">
                <p class="register-eyebrow">STEP INTO THE LOOP</p>
                <h1 class="register-brand-heading">
                    GOOD<br>
                    THINGS<br>
                    <em>GROW.</em>
                </h1>
                <p class="register-brand-sub">A better loop starts with you. Help good food find its next destination.</p>
            </div>

            <div class="register-brand-footer">
                <span>FOOD CIRCULARITY</span>
                <span>NUTRIFLUX LOOP</span>
            </div>
        </section>

        <section class="register-form-card">
            <div class="register-form-header">
                <p class="eyebrow">02 / Create your account</p>
                <h2 class="register-form-title">Let's make it <em>count.</em></h2>
                <p class="register-form-subtitle">Create your NutriFlux account. Your role helps us connect you to the right people.</p>
            </div>

            <form id="registerForm" action="${pageContext.request.contextPath}/register" method="post" novalidate>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

                <div class="field-pair">
                    <div class="form-field">
                        <label for="fullName">FULL NAME</label>
                        <input id="fullName" name="fullName" type="text"
                               value="<c:out value='${usersDto.fullName}'/>"
                               placeholder="Your name" autocomplete="name" required>
                        <p id="fullNameError" class="field-error"></p>
                    </div>

                    <div class="form-field">
                        <label for="username">USERNAME</label>
                        <input id="username" name="userName" type="text"
                               value="<c:out value='${usersDto.userName}'/>"
                               placeholder="Choose a username" autocomplete="username"
                               minlength="4" maxlength="20"
                               class="${not empty errorMessages[1] ? 'input-error' : ''}" required>
                        <p id="usernameError" class="field-error">
                            <c:if test="${not empty errorMessages[1]}">
                                <span>✕</span><c:out value="${errorMessages[1]}"/>
                            </c:if>
                        </p>
                    </div>
                </div>

                <div class="form-field">
                    <label for="email">EMAIL ADDRESS</label>
                    <input id="email" name="email" type="email"
                           value="<c:out value='${usersDto.email}'/>"
                           placeholder="you@example.com" autocomplete="email"
                           class="${not empty errorMessages[3] ? 'input-error' : ''}" required>
                    <p id="emailError" class="field-error">
                        <c:if test="${not empty errorMessages[3]}">
                            <span>✕</span><c:out value="${errorMessages[3]}"/>
                        </c:if>
                    </p>
                </div>

                <div class="field-pair">
                    <div class="form-field">
                        <label for="password">PASSWORD</label>
                        <input id="password" name="password" type="password"
                               placeholder="Create a password" autocomplete="new-password" required>
                    </div>

                    <div class="form-field">
                        <label for="confirmPassword">CONFIRM PASSWORD</label>
                        <input id="confirmPassword" name="confirmPassword" type="password"
                               placeholder="Repeat password" autocomplete="new-password" required>
                        <p id="passwordError" class="field-error"></p>
                    </div>
                </div>

                <label class="terms">
                    <input type="checkbox" id="terms" name="termsAccepted" value="true" required>
                    <span>I agree to the terms and understand how NutriFlux works.</span>
                </label>
                <p id="termsError" class="field-error terms-error"></p>

                <button class="submit-button" type="submit">
                    Create my account
                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <line x1="7" y1="17" x2="17" y2="7"></line>
                        <polyline points="7 7 17 7 17 17"></polyline>
                    </svg>
                </button>
            </form>

            <div class="auth-divider"><span></span> OR CONTINUE WITH <span></span></div>

            <a href="${pageContext.request.contextPath}/oauth2/authorization/google" class="social-button">
                <b class="google-icon">G</b>
                <span>Continue with Google</span>
            </a>

            <p class="switch-auth">
                Already part of the loop?
                <a href="${pageContext.request.contextPath}/login">Log in ↗</a>
            </p>
        </section>
    </div>
</main>

<footer class="site-footer">
    <div class="container footer-content">
        <div class="footer-left">
            <a href="${pageContext.request.contextPath}/home" class="brand-logo" aria-label="NutriFlux Home">
                <span class="brand-badge">n.</span>
                <span>nutriflux.</span>
            </a>
            <span class="footer-separator">|</span>
            <span class="footer-network-tag">Food Circularity Network</span>
        </div>

        <div class="footer-right">
            <nav class="footer-legal-links" aria-label="Legal Navigation">
                <a href="${pageContext.request.contextPath}/privacy">Privacy Policy</a>
                <a href="${pageContext.request.contextPath}/terms">Terms of Service</a>
            </nav>
            <div class="footer-tagline">Good food. Better routes.</div>
        </div>
    </div>
</footer>

<script src="${pageContext.request.contextPath}/assets/js/register.js"></script>
</body>
</html>
