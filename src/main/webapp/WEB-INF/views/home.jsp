<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title>NutriFlux — AI-Powered Food Waste Reduction</title>

    <meta name="description"
          content="NutriFlux connects surplus food with the people and places that need it." />

    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />

    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@1,400;1,500;1,600;1,700&family=Plus+Jakarta+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;0,800;1,400;1,600&family=Space+Grotesk:wght@500;600;700&display=swap"
          rel="stylesheet" />

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/home.css" />
</head>

<body>

      <header class="site-header">
        <div class="container">
          <a href="#" class="brand-logo" aria-label="NutriFlux Home">
            <span class="brand-badge">n.</span>
            <span>nutriflux.</span>
          </a>

          <nav class="nav-links" aria-label="Primary Navigation">
            <a href="#how-it-works" class="nav-link">How it works</a>
            <a href="#impact" class="nav-link">Platform impact</a>
            <a href="#stories" class="nav-link">For organizations</a>
          </nav>

          <div class="nav-actions">
            <a href="${pageContext.request.contextPath}/login" class="btn-pill btn-outline">Log in</a>
            <a href="${pageContext.request.contextPath}/register" class="btn-pill btn-dark">
              <span>Get started</span>
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                <line x1="7" y1="17" x2="17" y2="7"></line>
                <polyline points="7 7 17 7 17 17"></polyline>
              </svg>
            </a>
          </div>
        </div>
      </header>

      <main>
        <section class="hero-section" id="hero">
          <div class="container">
            <div class="hero-grid">

              <!-- Left Column: Copy & Actions -->
              <div class="hero-content">
                <div class="eyebrow eyebrow-accent">
                  <span class="eyebrow-line"></span>
                  <span>AI-powered food waste reduction platform</span>
                </div>

                <h1 class="hero-title">
                  Reduce food waste.<br />
                  Redistribute <span class="serif-italic">surplus</span><br />
                  intelligently.
                </h1>

                <p class="hero-desc">
                  NutriFlux helps food businesses prevent avoidable waste with real-time expiry monitoring and AI-driven predictions, while connecting surplus food with NGOs, community kitchens, and food banks.
                </p>

                <div class="hero-cta-group">
                  <a href="${pageContext.request.contextPath}/register" class="btn-pill btn-lime">
                    <span>Manage food smarter</span>
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                      <line x1="7" y1="17" x2="17" y2="7"></line>
                      <polyline points="7 7 17 7 17 17"></polyline>
                    </svg>
                  </a>

                  <a href="#how-it-works" class="btn-text-link">
                    <span>Explore the platform</span>
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                      <line x1="12" y1="5" x2="12" y2="19"></line>
                      <polyline points="19 12 12 19 5 12"></polyline>
                    </svg>
                  </a>
                </div>

                <div class="hero-social-proof">
                  <div class="avatar-group-wrap">
                    <div class="avatar-stack">
                      <div class="avatar avatar-1">R</div>
                      <div class="avatar avatar-2">A</div>
                      <div class="avatar avatar-3">M</div>
                      <div class="avatar avatar-4">+</div>
                    </div>
                    <div class="avatar-text">
                      <span class="avatar-title">One platform. Two sides.</span>
                      <span class="avatar-subtitle">For food businesses and recipient organizations.</span>
                    </div>
                  </div>

                  <div class="hero-system-tag">
                    01 / Smarter food recovery
                  </div>
                </div>
              </div>

              <div class="hero-graphic-wrap">
                <div class="hero-square-card">

                  <div class="radar-rings" aria-hidden="true">
                    <div class="radar-ring ring-1"></div>
                    <div class="radar-ring ring-2"></div>
                    <div class="radar-ring ring-3"></div>
                    <div class="radar-ring ring-4"></div>
                  </div>

                  <div class="square-header">
                    <span>Platform overview / 001</span>
                    <span>Surplus, put to use</span>
                  </div>

                  <div class="square-center-stage">
                    <div class="polaroid-frame">

                      <div class="float-pill-left">
                        <div class="float-icon-lime">
                          <svg width="13" height="13" viewBox="0 0 24 24" fill="currentColor">
                            <path d="M13 2L3 14h9l-1 8 10-12h-9l1-8z" />
                          </svg>
                        </div>
                        <div class="pill-text-group">
                          <span class="pill-text-title">Expiry monitored</span>
                          <span class="pill-text-sub">At-risk stock identified.</span>
                        </div>
                      </div>

                      <div class="float-tag-corner">
                        <svg viewBox="0 0 24 24" fill="none">
                          <polyline points="20 6 9 17 4 12"></polyline>
                        </svg>
                      </div>

                      <div class="polaroid-img-wrapper">
                        <img src="assets/hero-apple.png" alt="Fresh & Rescued organic apple produce card" />
                      </div>

                      <div class="polaroid-caption">
                        <div class="caption-label">Inventory insights</div>
                        <div class="caption-heading">Act before food is wasted.</div>
                      </div>

                      <div class="float-pill-right">
                        <span class="pill-badge-num">01</span>
                        <div class="pill-text-group">
                          <span class="pill-text-title">Find a recipient</span>
                          <span class="pill-text-sub">NGOs. Kitchens. Food banks.</span>
                        </div>
                      </div>

                    </div>
                  </div>

                  <div class="square-footer">
                    <span>01 &mdash; 04</span>
                    <span>Turn surplus into community value.</span>
                  </div>

                </div>
              </div>

            </div>
          </div>
        </section>

        <section class="ticker-banner" aria-label="Key Principles Banner">
          <div class="ticker-track">
            <!-- Sequence 1 -->
            <div class="ticker-content">
              <div class="ticker-item">
                <span>Track inventory</span>
                <svg class="ticker-star" viewBox="0 0 24 24"><path d="M12 2l2.4 7.4h7.6l-6.2 4.5 2.4 7.4-6.2-4.5-6.2 4.5 2.4-7.4-6.2-4.5h7.6z"/></svg>
                <span>Predict waste</span>
                <svg class="ticker-star" viewBox="0 0 24 24"><path d="M12 2l2.4 7.4h7.6l-6.2 4.5 2.4 7.4-6.2-4.5-6.2 4.5 2.4-7.4-6.2-4.5h7.6z"/></svg>
                <span>Redistribute surplus</span>
                <svg class="ticker-star" viewBox="0 0 24 24"><path d="M12 2l2.4 7.4h7.6l-6.2 4.5 2.4 7.4-6.2-4.5-6.2 4.5 2.4-7.4-6.2-4.5h7.6z"/></svg>
                <span>Support communities</span>
                <svg class="ticker-star" viewBox="0 0 24 24"><path d="M12 2l2.4 7.4h7.6l-6.2 4.5 2.4 7.4-6.2-4.5-6.2 4.5 2.4-7.4-6.2-4.5h7.6z"/></svg>
              </div>
            </div>
            <!-- Sequence 2 (Duplicated for seamless loop) -->
            <div class="ticker-content" aria-hidden="true">
              <div class="ticker-item">
                <span>Track inventory</span>
                <svg class="ticker-star" viewBox="0 0 24 24"><path d="M12 2l2.4 7.4h7.6l-6.2 4.5 2.4 7.4-6.2-4.5-6.2 4.5 2.4-7.4-6.2-4.5h7.6z"/></svg>
                <span>Predict waste</span>
                <svg class="ticker-star" viewBox="0 0 24 24"><path d="M12 2l2.4 7.4h7.6l-6.2 4.5 2.4 7.4-6.2-4.5-6.2 4.5 2.4-7.4-6.2-4.5h7.6z"/></svg>
                <span>Redistribute surplus</span>
                <svg class="ticker-star" viewBox="0 0 24 24"><path d="M12 2l2.4 7.4h7.6l-6.2 4.5 2.4 7.4-6.2-4.5-6.2 4.5 2.4-7.4-6.2-4.5h7.6z"/></svg>
                <span>Support communities</span>
                <svg class="ticker-star" viewBox="0 0 24 24"><path d="M12 2l2.4 7.4h7.6l-6.2 4.5 2.4 7.4-6.2-4.5-6.2 4.5 2.4-7.4-6.2-4.5h7.6z"/></svg>
              </div>
            </div>
          </div>
        </section>

        <section class="routing-section" id="how-it-works">
          <div class="container">

            <div class="eyebrow">
              <span>How the platform works / 01</span>
            </div>

            <div class="routing-top-grid">
              <div>
                <h2 class="routing-title">
                  Food waste is a<br />
                  <span class="serif-italic">visibility</span> problem.
                </h2>
              </div>

              <div>
                <p class="routing-body">
                  Food waste grows when businesses cannot track expiry, forecast demand, or redirect surplus. NutriFlux combines inventory intelligence with a live donation network to connect food businesses and recipient organizations.
                </p>
                <a href="#loop" class="link-arrow">
                  <span>Connect with the platform</span>
                  <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                    <line x1="7" y1="17" x2="17" y2="7"></line>
                    <polyline points="7 7 17 7 17 17"></polyline>
                  </svg>
                </a>
              </div>
            </div>

            <div class="process-grid">

              <div class="process-card">
                <span class="process-step-num">01 / Monitor</span>
                <h3 class="process-heading">Track inventory and expiry</h3>
                <p class="process-desc">
                  Food businesses manage stock in one dashboard with real-time expiry monitoring and alerts for items approaching their use-by dates.
                </p>
              </div>

              <div class="process-card">
                <span class="process-step-num">02 / Predict</span>
                <h3 class="process-heading">Identify waste risks early</h3>
                <p class="process-desc">
                  AI analyzes purchasing patterns and historical demand to predict waste risk and provide actionable reorder recommendations.
                </p>
              </div>

              <div class="process-card">
                <span class="process-step-num">03 / Redistribute</span>
                <h3 class="process-heading">Connect surplus with recipients</h3>
                <p class="process-desc">
                  Businesses list surplus food for NGOs, community kitchens, and food banks, with pickup scheduling and logistics coordination.
                </p>
              </div>

            </div>

          </div>
        </section>

        <section class="dark-section" id="impact">
          <div class="container">

            <div class="dark-grid">

              <!-- Left Info -->
              <div>
                <div class="eyebrow" style="color: #8CA795;">
                  <span>Tools for both sides of food recovery / 02</span>
                </div>

                <h2 class="dark-title">
                  Insights that<br />
                  <span class="serif-italic">drive action.</span>
                </h2>

                <p class="dark-desc">
                  Analytics dashboards help both businesses and recipient organizations understand waste trends, donation impact, and food recovery volumes.
                </p>
              </div>

              <div>
                <div class="metric-list">

                  <div class="metric-row">
                    <div class="metric-number">01/</div>
                    <div class="metric-label">Business inventory dashboard</div>
                  </div>

                  <div class="metric-row">
                    <div class="metric-number">
                      AI<span class="metric-x"> </span>
                    </div>
                    <div class="metric-label">Waste risk scores and reorder recommendations</div>
                  </div>

                  <div class="metric-row">
                    <div class="metric-number">&infin;</div>
                    <div class="metric-label">Live donation feed and pickup scheduling</div>
                  </div>

                </div>

                <div class="seal-container">
                  <div class="circular-seal">
                    <span class="seal-text">Food Saved<br />Communities Fed</span>
                    <span class="seal-icon">&lowast;</span>
                  </div>
                </div>

              </div>

            </div>

          </div>
        </section>

        <section class="access-section" id="stories">
          <div class="container">

            <div class="eyebrow">
              <span>A connected food recovery network / 03</span>
            </div>

            <div class="access-grid">

              <div>
                <h2 class="access-title">
                  From surplus<br />
                  to <span class="serif-italic">impact.</span>
                </h2>
              </div>

              <div>
                <div class="promise-card">
                  <div class="eyebrow" style="margin-bottom: 1.25rem;">
                    <span>One platform. Two experiences.</span>
                  </div>

                  <p class="promise-quote">
                    Food businesses get inventory control, expiry alerts, AI waste predictions, and surplus listings. NGOs, community kitchens, and food banks get a live donation feed, pickup scheduling, and logistics coordination.
                  </p>

                  <a href="${pageContext.request.contextPath}/register" class="btn-pill btn-dark">
                    <span>Get started with NutriFlux</span>
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                      <line x1="7" y1="17" x2="17" y2="7"></line>
                      <polyline points="7 7 17 7 17 17"></polyline>
                    </svg>
                  </a>
                </div>
              </div>

            </div>

          </div>
        </section>
      </main>

      <footer class="site-footer">
        <div class="container">
          <div class="footer-content">
            <a href="#" class="brand-logo" aria-label="NutriFlux Home">
              <span class="brand-badge">n.</span>
              <span>nutriflux.</span>
            </a>

            <div class="footer-tagline">
              Less food wasted. More food recovered.
            </div>
          </div>
        </div>
      </footer>

    <img src="${pageContext.request.contextPath}/assets/hero-apple.png"
         alt="Fresh and rescued apple produce card" />

</body>
</html>

