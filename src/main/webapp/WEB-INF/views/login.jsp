<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Log in — NutriFlux</title>
<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=DM+Mono:wght@400;500&family=DM+Sans:wght@400;500;600;700&family=Manrope:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/login.css">
</head>
<body>
<div class="auth-shell">
<aside class="auth-aside">
<a class="brand" href="${pageContext.request.contextPath}/home"><span class="brand-mark">n.</span><span>nutriflux<span class="brand-dot">.</span></span></a>
<div class="aside-content"><span class="eyebrow">YOUR NEXT GOOD THING STARTS HERE</span><h1>Pick up<br>where <em>good</em><br>begins.</h1><p>One small connection can keep a whole lot of good food in circulation.</p></div>
<div class="aside-orb"></div>
</aside>
<main class="auth-main">
<a class="back-home" href="${pageContext.request.contextPath}/home">← Back to home</a>
<div class="auth-card">
<div class="auth-kicker">WELCOME BACK <span>✳</span></div>
<h2>Good to see you.</h2><p class="auth-subtitle">Log in to keep the good moving.</p>
<form action="${pageContext.request.contextPath}/process-login" method="post">
<label for="username">EMAIL OR USERNAME</label><input id="username" name="userName" type="text" placeholder="you@example.com" autocomplete="username" required>
<div class="password-label"><label for="password">PASSWORD</label><a href="#">Forgot password?</a></div><input id="password" name="createPassword" type="password" placeholder="Enter your password" autocomplete="current-password" required>
<button class="submit-button" type="submit">Log in <span>↗</span></button>
</form>
<div class="auth-divider"><span></span>OR CONTINUE WITH<span></span></div>
<div class="social-row"><a href="${pageContext.request.contextPath}/oauth2/authorization/google" class="social-button"><b>G</b> Google</a></div>
<p class="switch-auth">New to the loop? <a href="${pageContext.request.contextPath}/register">Create an account ↗</a></p>
</div>
</main>
</div>
</body>
</html>