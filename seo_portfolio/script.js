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

  // Project details modal — mirrors CV
  var PROJECTS = {
    'gpu-pipeline': {
      tech: 'HPC | CUDA | cuML | cuDF',
      title: 'GPU-Accelerated ML Pipeline',
      tag: 'HPC · GPU computing',
      overview: 'GPU-accelerated ML pipelines using NVIDIA RAPIDS (cuDF for preprocessing, cuML for training), achieving multi-fold speedups over CPU workflows. Keeps data on-device to avoid CPU-GPU transfer overhead.',
      points: [
        'Built GPU-accelerated ML pipelines using NVIDIA RAPIDS (cuDF for preprocessing, cuML for training)',
        'Multi-fold speedups over CPU workflows'
      ],
      stack: ['CUDA', 'Python', 'RAPIDS', 'cuML', 'cuDF', 'Nsight Compute', 'nvidia-smi'],
      outcome: 'Outcome: reusable template for GPU-first ML work.'
    },
    'quantum-ml': {
      tech: 'Quantum ML | Network Security | Python',
      title: 'Quantum ML for Network Security',
      tag: 'Quantum ML · Intrusion detection',
      overview: 'Evaluated parameterized quantum kernels for one-class intrusion detection on CICIoT2023 and UNSW-NB15 under an equalized protocol; implemented a PSO-tuned RFF surrogate validated against the exact fidelity kernel.',
      points: [
        'Parameterized quantum kernels for one-class intrusion detection on CICIoT2023 and UNSW-NB15',
        'PSO-tuned RFF surrogate validated against the exact fidelity kernel',
        'No detection advantage over classical RBF one-class SVM, with explicit fidelity analysis'
      ],
      stack: ['Python', 'Quantum kernels', 'RFF', 'PSO', 'CICIoT2023', 'UNSW-NB15'],
      outcome: 'Outcome: rigorous negative result with surrogate-to-exact kernel fidelity analysis.'
    },
    'quantum-iot': {
      tech: 'IoT Security | Anomaly Detection | Swarm Collaboration',
      title: 'Quantum-Inspired Decentralized IoT Anomaly Detection',
      tag: 'IoT security · Decentralized detection',
      overview: 'Decentralized anomaly-detection framework combining a benign-reference fidelity-density detector with swarm-inspired peer corroboration. Evaluated on CICIoT2023 and X-IIoTID (ROC-AUC 0.9706, 0.8758) and validated in a 50-node NS-3 simulation (3-of-3 delivery, 10.8424 ms latency).',
      points: [
        'Benign-reference fidelity-density detector with swarm-inspired peer corroboration',
        'ROC-AUC 0.9706 (CICIoT2023) and 0.8758 (X-IIoTID)',
        '50-node NS-3 validation: 3-of-3 delivery, 10.8424 ms latency'
      ],
      stack: ['Python', 'IoT Security', 'Anomaly Detection', 'NS-3', 'CICIoT2023', 'X-IIoTID'],
      outcome: 'Outcome: decentralized detector with peer-verified validation at scale.'
    },
    'smart-nav': {
      tech: 'AI | Flutter',
      title: 'Smart Navigation Assistant for Visually Impaired',
      tag: 'Assistive AI · Mobile',
      overview: 'AI-powered Flutter app for real-time assistive navigation using an LLM, with computer vision for object detection, distance estimation, and TTS-based guidance.',
      points: [
        'Real-time assistive navigation with LLM-based scene narration',
        'Object detection plus distance estimation from the camera feed',
        'TTS-based guidance'
      ],
      stack: ['Flutter', 'Dart', 'LLM APIs', 'Computer Vision', 'TTS', 'Firebase'],
      outcome: 'Outcome: working assistive-navigation prototype pairing mobile vision with language-model reasoning.'
    },
    'mental-health': {
      tech: 'ML | NLP',
      title: 'Student Mental Health Detection System',
      tag: 'NLP · Transformers',
      overview: 'RoBERTa and Gemma based Transformer for mental health sentiment analysis and a CLI-based inference tool for evaluation. Feeds the IEEE ICECTE 2026 publication (BERT/RoBERTa/Gemma comparison).',
      points: [
        'RoBERTa and Gemma transformer for mental-health text classification',
        'CLI-based inference tool for evaluation',
        'Comparative study of BERT, RoBERTa and Gemma'
      ],
      stack: ['Python', 'PyTorch', 'RoBERTa', 'Gemma', 'Hugging Face'],
      outcome: 'Outcome: peer-reviewed IEEE publication with reusable evaluation setup.'
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
