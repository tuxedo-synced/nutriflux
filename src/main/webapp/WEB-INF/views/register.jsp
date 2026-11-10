
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Create account — NutriFlux</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=DM+Mono:wght@400;500&family=DM+Sans:wght@400;500;600;700&family=Manrope:wght@400;500;600;700;800&display=swap"
          rel="stylesheet">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/register.css">

</head>

<body>

<div class="register-shell">

    <aside class="register-aside">

        <a class="brand" href="${pageContext.request.contextPath}/home">
            <span class="brand-mark">n.</span>
            <span>nutriflux<span class="brand-dot">.</span></span>
        </a>

        <div class="register-art">
            <div class="art-ring ring-a"></div>
            <div class="art-ring ring-b"></div>
            <div class="art-leaf">✳</div>

            <div class="art-word">
                GOOD<br>
                THINGS<br>
                <em>GROW.</em>
            </div>

            <span class="art-caption">A BETTER LOOP STARTS WITH YOU</span>
        </div>

    </aside>

    <main class="register-main">

        <a class="back-home" href="${pageContext.request.contextPath}/home">
            ← Back to home
        </a>

        <div class="register-card">

            <div class="auth-kicker">
                STEP INTO THE LOOP <span>✳</span>
            </div>

            <h1>
                Let's make it<br>
                <em>count.</em>
            </h1>

            <p class="auth-subtitle">
                Create your NutriFlux account. Your role helps us connect you to the right people.
            </p>

            <form id="registerForm"
                  action="${pageContext.request.contextPath}/register"
                  method="post"
                  novalidate>

                <input type="hidden"
                       name="${_csrf.parameterName}"
                       value="${_csrf.token}">

                <div class="field-pair">

                    <div class="form-field">

                        <label for="fullName">FULL NAME</label>

                        <input
                            id="fullName"
                            name="fullName"
                            type="text"
                            value="<c:out value='${usersDto.fullName}'/>"
                            placeholder="Your name"
                            autocomplete="name"
                            required>

                        <p id="fullNameError" class="field-error"></p>

                    </div>

                    <div class="form-field">

                        <label for="username">USERNAME</label>

                        <input
                            id="username"
                            name="userName"
                            type="text"
                            value="<c:out value='${usersDto.userName}'/>"
                            placeholder="Choose a username"
                            autocomplete="username"
                            minlength="4"
                            maxlength="20"
                            class="${not empty errorMessages[1] ? 'input-error' : ''}"
                            required>

                        <p id="usernameError" class="field-error">
                            <c:if test="${not empty errorMessages[1]}">
                                <span>✕</span>
                                <c:out value="${errorMessages[1]}"/>
                            </c:if>
                        </p>

                    </div>

                </div>

                <div class="form-field">

                    <label for="email">EMAIL ADDRESS</label>

                    <input
                        id="email"
                        name="email"
                        type="email"
                        value="<c:out value='${usersDto.email}'/>"
                        placeholder="you@example.com"
                        autocomplete="email"
                        class="${not empty errorMessages[3] ? 'input-error' : ''}"
                        required>

                    <p id="emailError" class="field-error">
                        <c:if test="${not empty errorMessages[3]}">
                            <span>✕</span>
                            <c:out value="${errorMessages[3]}"/>
                        </c:if>
                    </p>

                </div>

                <div class="field-pair">

                    <div class="form-field">

                        <label for="password">PASSWORD</label>

                        <input
                            id="password"
                            name="password"
                            type="password"
                            placeholder="Create a password"
                            autocomplete="new-password"
                            required>

                    </div>

                    <div class="form-field">

                        <label for="confirmPassword">CONFIRM PASSWORD</label>

                        <input
                            id="confirmPassword"
                            name="confirmPassword"
                            type="password"
                            placeholder="Repeat password"
                            autocomplete="new-password"
                            required>

                        <p id="passwordError" class="field-error"></p>

                    </div>

                </div>

                <label class="terms">

                    <input
                        type="checkbox"
                        id="terms"
                        name="termsAccepted"
                        value="true"
                        required>

                    <span>
                        I agree to the terms and understand how NutriFlux works.
                    </span>

                </label>

                <p id="termsError" class="field-error"></p>

                <button class="submit-button" type="submit">
                    Create my account <span>↗</span>
                </button>

            </form>

            <div class="auth-divider">
                <span></span>OR CONTINUE WITH<span></span>
            </div>

            <div class="social-row">
                <a href="${pageContext.request.contextPath}/oauth2/authorization/google"
                   class="social-button">
                    <b>G</b> Google
                </a>
            </div>

            <p class="switch-auth">
                Already part of the loop?
                <a href="${pageContext.request.contextPath}/login">Log in ↗</a>
            </p>

        </div>

    </main>

</div>

<script src="${pageContext.request.contextPath}/assets/js/register.js"></script>

</body>
</html>
