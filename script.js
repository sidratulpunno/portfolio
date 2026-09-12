// Light-by-default theme, mobile menu, scroll spy, reveal, back-to-top.
(function () {
  var root = document.documentElement;
  var KEY = 'sp-theme';
  var toggle = document.getElementById('themeToggle');
  var icon = document.getElementById('themeIcon');

  function paint(t) {
    root.setAttribute('data-theme', t);
    if (icon) icon.textContent = t === 'dark' ? '☀' : '☾';
    if (toggle) toggle.setAttribute('aria-label', t === 'dark' ? 'Switch to light mode' : 'Switch to dark mode');
    try { localStorage.setItem(KEY, t); } catch (e) {}
  }
  // Default is light. Only restore an explicit past choice.
  var saved = null;
  try { saved = localStorage.getItem(KEY); } catch (e) {}
  paint(saved === 'dark' ? 'dark' : 'light');
  if (toggle) toggle.addEventListener('click', function () {
    paint(root.getAttribute('data-theme') === 'dark' ? 'light' : 'dark');
  });

  // Mobile menu
  var btn = document.getElementById('navToggle');
  var links = document.getElementById('navLinks');
  function closeMenu() {
    if (!links) return;
    links.classList.remove('open');
    if (btn) btn.setAttribute('aria-expanded', 'false');
  }
  if (btn && links) {
    btn.addEventListener('click', function () {
      var open = links.classList.toggle('open');
      btn.setAttribute('aria-expanded', open ? 'true' : 'false');
      btn.setAttribute('aria-label', open ? 'Close menu' : 'Open menu');
    });
    links.addEventListener('click', function (e) {
      if (e.target.closest('a')) closeMenu();
    });
    document.addEventListener('keydown', function (e) {
      if (e.key === 'Escape') closeMenu();
    });
    window.addEventListener('resize', function () {
      if (window.innerWidth > 900) closeMenu();
    });
  }

  // Progress + back-to-top
  var bar = document.getElementById('progressBar');
  var toTop = document.getElementById('toTop');
  var ticking = false;
  function onScroll() {
    ticking = false;
    var h = document.documentElement;
    var max = h.scrollHeight - h.clientHeight;
    if (bar) bar.style.width = (max > 0 ? (h.scrollTop / max) * 100 : 0) + '%';
    if (toTop) toTop.classList.toggle('show', h.scrollTop > 700);
  }
  document.addEventListener('scroll', function () {
    if (!ticking) { ticking = true; requestAnimationFrame(onScroll); }
  }, { passive: true });
  onScroll();
  if (toTop) toTop.addEventListener('click', function () {
    window.scrollTo({ top: 0, behavior: 'smooth' });
  });

  // Active nav via IntersectionObserver (accurate on all screen sizes)
  var navAs = Array.prototype.slice.call(document.querySelectorAll('.nav-links a[href^="#"]'));
  var map = {};
  navAs.forEach(function (a) { map[a.getAttribute('href').slice(1)] = a; });
  if ('IntersectionObserver' in window) {
    var io2 = new IntersectionObserver(function (entries) {
      entries.forEach(function (en) {
        var link = map[en.target.id];
        if (link && en.isIntersecting) {
          navAs.forEach(function (a) { a.classList.remove('active'); });
          link.classList.add('active');
        }
      });
    }, { rootMargin: '-40% 0px -55% 0px', threshold: 0 });
    document.querySelectorAll('main section[id]').forEach(function (s) { io2.observe(s); });
  }

  // Reveal on scroll
  var els = document.querySelectorAll('.card, .hero-inner > *, .sec-head > *');
  els.forEach(function (el) { el.classList.add('reveal'); });
  if ('IntersectionObserver' in window) {
    var io = new IntersectionObserver(function (entries) {
      entries.forEach(function (en) {
        if (en.isIntersecting) { en.target.classList.add('visible'); io.unobserve(en.target); }
      });
    }, { threshold: 0.08, rootMargin: '0px 0px -4% 0px' });
    els.forEach(function (el) { io.observe(el); });
  } else {
    els.forEach(function (el) { el.classList.add('visible'); });
  }

  // Footer year
  var y = document.getElementById('year');
  if (y) y.textContent = new Date().getFullYear();

  // Project details modal
  var PROJECTS = {
    'gpu-pipeline': {
      tech: 'CUDA | cuML | cuDF',
      title: 'GPU-Accelerated ML Pipeline',
      tag: 'GPU computing · Machine learning systems',
      overview: 'End-to-end machine learning pipeline built on the NVIDIA RAPIDS ecosystem. Raw tabular data is ingested and cleaned on the GPU with cuDF, then models are trained with cuML — keeping data on-device to avoid costly CPU-GPU transfers. The result is multi-fold faster iteration than equivalent CPU workflows, making large-scale experimentation practical on a single GPU workstation.',
      points: [
        'GPU-accelerated ML pipelines using the NVIDIA RAPIDS ecosystem',
        'cuDF for large-scale GPU data preprocessing',
        'cuML estimators for on-device model training',
        'Benchmarked against CPU baselines to quantify speedups'
      ],
      stack: ['CUDA', 'Python', 'RAPIDS', 'cuML', 'cuDF', 'Nsight Compute'],
      outcome: 'Outcome: much faster training iterations and a reusable template for GPU-first ML work.'
    },
    'smart-nav': {
      tech: 'AI | Flutter | CV',
      title: 'Smart Navigation Assistant',
      tag: 'Assistive AI · Mobile',
      overview: 'Flutter mobile app that narrates the world for visually impaired users. The camera feed runs on-device object detection with distance estimation, while a language model turns observations into clear spoken guidance via text-to-speech. Everything is tuned for real-world walking: short, calm instructions instead of raw detections.',
      points: [
        'Real-time assistive navigation with LLM-based scene narration',
        'Object detection plus distance estimation from the camera feed',
        'TTS guidance tuned for clarity at walking pace',
        'On-device perception to keep latency low'
      ],
      stack: ['Flutter', 'Dart', 'TFLite', 'LLM APIs', 'Computer Vision', 'Firebase'],
      outcome: 'Outcome: a working assistive-navigation prototype pairing mobile vision with language-model reasoning.'
    },
    'mental-health': {
      tech: 'NLP | RoBERTa | Gemma',
      title: 'Mental Health Detection',
      tag: 'NLP · Transformers',
      overview: 'Comparative study of transformer models — BERT, RoBERTa and Gemma — for detecting signs of student mental-health distress in text. Includes training and evaluation harnesses plus a lightweight CLI for quick inference and testing. This work feeds the IEEE ICECTE 2026 publication.',
      points: [
        'Head-to-head comparison of BERT, RoBERTa and Gemma',
        'Transformer classifier for mental-health text signals',
        'CLI-based inference for streamlined testing and demos',
        'Reproducible evaluation splits'
      ],
      stack: ['Python', 'PyTorch', 'RoBERTa', 'Gemma', 'Hugging Face'],
      outcome: 'Outcome: peer-reviewed IEEE publication with an evaluation setup others can rerun.'
    },
    'video-conf': {
      tech: 'Flutter | Firebase | Jitsi',
      title: 'Video Conferencing App',
      tag: 'Mobile · Realtime',
      overview: 'Full-featured video conferencing app built with Flutter and the Jitsi Meet SDK. Firebase handles authentication and presence, while real-time chat and meeting management — room creation, invites, call history — round out a complete meeting experience from one codebase.',
      points: [
        'Real-time video conferencing with the Jitsi Meet SDK',
        'Firebase auth, presence and real-time chat',
        'Room creation, invites and meeting history',
        'One codebase running on Android and iOS'
      ],
      stack: ['Flutter', 'Dart', 'Jitsi Meet SDK', 'Firebase Auth', 'Firestore'],
      outcome: 'Outcome: a production-style realtime app covering auth, media, chat and state.'
    },
    'door-lock': {
      tech: 'IoT | ESP32',
      title: 'Smart Door Lock System',
      tag: 'IoT · Embedded',
      overview: 'Cloud-connected smart door lock built around the ESP32. Access events are reported to the cloud for remote monitoring, and authorized users can lock or unlock from their phone under secure access control. The firmware is written for reliability: reconnect logic, debounced inputs and fail-safe defaults.',
      points: [
        'Cloud-connected security system on the ESP32',
        'Phone-controlled lock and unlock with access rules',
        'Remote monitoring of access events',
        'Resilient firmware with auto-reconnect'
      ],
      stack: ['ESP32', 'C++', 'Arduino', 'Cloud / MQTT', 'Flutter'],
      outcome: 'Outcome: a dependable IoT security device bridging embedded firmware and mobile control.'
    }
  };
  var modal = document.getElementById('projModal');
  var mTech = document.getElementById('projModalTech');
  var mTitle = document.getElementById('projModalTitle');
  var mTag = document.getElementById('projModalTag');
  var mOverview = document.getElementById('projModalOverview');
  var mPoints = document.getElementById('projModalPoints');
  var mStack = document.getElementById('projModalStack');
  var mOutcome = document.getElementById('projModalOutcome');
  var mClose = document.getElementById('projModalClose');
  var lastFocus = null;
  function openProject(id) {
    var d = PROJECTS[id];
    if (!d || !modal) return;
    mTech.textContent = d.tech;
    mTitle.textContent = d.title;
    mTag.textContent = d.tag;
    mOverview.textContent = d.overview;
    mPoints.innerHTML = '';
    d.points.forEach(function (p) {
      var li = document.createElement('li');
      li.textContent = p;
      mPoints.appendChild(li);
    });
    mStack.innerHTML = '';
    d.stack.forEach(function (s) {
      var li = document.createElement('li');
      li.textContent = s;
      mStack.appendChild(li);
    });
    mOutcome.textContent = d.outcome;
    lastFocus = document.activeElement;
    modal.hidden = false;
    document.body.classList.add('modal-open');
    if (mClose) mClose.focus();
  }
  function closeProject() {
    if (!modal || modal.hidden) return;
    modal.hidden = true;
    document.body.classList.remove('modal-open');
    if (lastFocus && lastFocus.focus) lastFocus.focus();
  }
  document.addEventListener('click', function (e) {
    var opener = e.target.closest('.proj-open');
    if (opener) { openProject(opener.getAttribute('data-project')); return; }
    var card = e.target.closest('.project');
    if (card && modal && modal.hidden) openProject(card.getAttribute('data-project'));
  });
  document.addEventListener('keydown', function (e) {
    if (e.key === 'Escape') { closeProject(); return; }
    if ((e.key === 'Enter' || e.key === ' ') && e.target.classList && e.target.classList.contains('project')) {
      e.preventDefault();
      openProject(e.target.getAttribute('data-project'));
    }
  });
  if (mClose) mClose.addEventListener('click', closeProject);
  if (modal) modal.addEventListener('click', function (e) {
    if (e.target === modal) closeProject();
  });
})();
