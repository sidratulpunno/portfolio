import '../models/models.dart';

class ResumeData {
  ResumeData._();

  static const name = 'Sheikh Sidratul\nMuntaha Punno';
  static const tagline = 'HPC & AI Engineer';
  static const email = 'sheikhpunno400@gmail.com';
  static const phone = '+8801941529696';
  static const github = 'sidratulpunno';
  static const linkedin = 'sidratul-punno-51a0832b6';
  static const portfolioRepo = 'https://github.com/sidratulpunno/portfolio';
  static const resumeUrl = 'https://drive.google.com/file/d/1nR40C2p7q3Zfxd9ihVOl7iD_vItlwAI3/view';

  static const summary = 'B.Sc. in IoT & Robotics. Specialized in HPC and '
      'GPU-accelerated ML using CUDA, cuML, and cuDF. Experienced in scalable '
      'ML pipelines, parallel computing, and performance-optimized GPU systems. '
      'Research focuses on quantum-inspired and classical ML for IoT and network '
      'security. Also builds production-grade Flutter applications with AI '
      'services. Targeting opportunities in HPC, GPU computing, and AI-driven systems.';

  static const interests = [
    'High-Performance Computing',
    'GPU-Accelerated Machine Learning',
    'Parallel Algorithms',
    'LLM steering & Fine Tuning',
    'Assistive & Human-Centered AI',
    'AI-Enabled Mobile Systems',
  ];

  static const education = [
    Education('2023 - 2026', 'B.Sc. in IoT & Robotics Engineering',
        'University of Frontier Technology, Bangladesh', 'CGPA: 3.87 / 4.00'),
    Education('2021', 'Higher Secondary School Certificate (HSC)', '', 'GPA: 5.0/5.0'),
    Education('2018', 'Secondary School Certificate (SSC)', '', 'GPA: 5.0/5.0'),
  ];

  static const publications = [
    Publication(
      'Jan 2026',
      'Transformer-Based Models for Student Mental Health Detection: A Comparative Study of BERT, RoBERTa and Gemma',
      '2026 IEEE International Conference on Electrical, Computer & Telecommunication Engineering (ICECTE 2026), Rajshahi, Bangladesh'),
    Publication(
      'Apr 2026',
      'AgriMind: An IoT-Driven LLM Framework for Intelligent Precision Agriculture',
      '2026 IEEE 2nd International Conference on Quantum Photonics, Artificial Intelligence, and Networking (QPAIN), Chittagong, Bangladesh'),
    Publication(
      'Jun 2026',
      'IoT-Based Smart Homes: Technologies, Security Risks and Countermeasures',
      'International Journal of Information Engineering and Electronic Business (IJIEEB) Vol. 18, No. 3'),
  ];

  static const skills = [
    SkillCategory('HPC & GPU Computing', [
      'CUDA (C/C++)',
      'NVIDIA RAPIDS (cuML, cuDF)',
      'GPU-accelerated pipelines',
      'Parallel computing',
      'Performance optimization',
      'Nsight Compute',
      'nvidia-smi',
    ]),
    SkillCategory('AI & Machine Learning', [
      'Deep Learning',
      'LoRA',
      'LLM fine tuning',
      'Computer Vision',
      'Generative AI (Gemini / Nano Banana)',
      'RoBERTa',
      'GPU workflows',
    ]),
    SkillCategory('Mobile Development', [
      'Flutter (Android, Web)',
      'Firebase (Auth, Firestore, FCM)',
      'Google Sign-In',
      'TTS integration',
      'TFLite',
    ]),
    SkillCategory('Backend Development', [
      'Python (FastAPI, Flask)',
    ]),
    SkillCategory('Languages', [
      'Python',
      'CUDA C/C++',
      'Dart',
      'C',
      'Java',
      'C++',
      'Bash',
      'Rust',
    ]),
    SkillCategory('IoT Platform', [
      'Arduino',
      'Raspberry Pi',
      'ESP8266',
      'ESP32',
    ]),
    SkillCategory('PCB Design', [
      'Altium Designer',
    ]),
    SkillCategory('Operating System', [
      'Windows',
      'Linux',
    ]),
    SkillCategory('Typesetting', [
      'LaTeX',
    ]),
    SkillCategory('Database', [
      'MySQL',
      'MongoDB',
    ]),
    SkillCategory('Tools & Platforms', [
      'Burp Suite',
      'Git',
      'GitHub',
      'Google Drive API',
      'Jitsi Meet SDK',
      'Azure Cloud',
    ]),
  ];

  static const languages = [
    'English (Professional Working Proficiency)',
    'Bangla (Native)',
  ];

  static const extracurriculars = [
    'Scout Member (Senior Patrol Leader) — Leadership training, team coordination, and community service initiatives.',
    'Photography — Event, nature and creative photography. Executive committee member of the school photography club.',
  ];

  static final projects = [
    Project(
      title: 'GPU-Accelerated ML Pipeline',
      tech: 'HPC | CUDA | cuML | cuDF',
      points: [
        'Built GPU-accelerated ML pipelines using NVIDIA RAPIDS (cuDF for preprocessing, cuML for training), achieving multi-fold speedups over CPU workflows.',
      ],
    ),
    Project(
      title: 'Quantum ML for Network Security',
      tech: 'Quantum ML | Network Security | Python',
      points: [
        'Evaluated parameterized quantum kernels for one-class intrusion detection on CICIoT2023 and UNSW-NB15 under an equalized protocol; implemented a PSO-tuned RFF surrogate validated against the exact fidelity kernel.',
        'Found no detection advantage over classical RBF one-class SVM, with explicit surrogate-to-exact kernel fidelity analysis.',
      ],
    ),
    Project(
      title: 'Quantum-Inspired Decentralized IoT Anomaly Detection',
      tech: 'IoT Security | Anomaly Detection | Swarm Collaboration',
      points: [
        'Designed a decentralized anomaly-detection framework combining a benign-reference fidelity-density detector with swarm-inspired peer corroboration.',
        'Evaluated on CICIoT2023 and X-IIoTID (ROC-AUC 0.9706, 0.8758) and validated peer verification in a 50-node NS-3 simulation (3-of-3 delivery, 10.8424 ms latency).',
      ],
    ),
    Project(
      title: 'Smart Navigation Assistant for Visually Impaired',
      tech: 'AI | Flutter',
      points: [
        'Developed an AI-powered Flutter app for real-time assistive navigation using an LLM, with computer vision for object detection, distance estimation, and TTS-based guidance.',
      ],
    ),
    Project(
      title: 'Student Mental Health Detection System',
      tech: 'ML | NLP',
      points: [
        'Implemented a RoBERTa & Gemma based Transformer for mental health sentiment analysis and a CLI-based inference tool for evaluation.',
      ],
    ),
  ];

  static const certifications = [
    Certification('Learn C++ Programming Beginner to Advance Deep Dive in C++', 'https://ude.my/UC-780d24b1-eedd-4870-a91e-a4a74f4f6e9f', 'https://udemy-certificate.s3.amazonaws.com/image/UC-780d24b1-eedd-4870-a91e-a4a74f4f6e9f.jpg'),
    Certification('Machine Learning A-Z', 'https://ude.my/UC-c6847dd9-c135-4118-a95c-620c3b6bb3c2', 'https://udemy-certificate.s3.amazonaws.com/image/UC-c6847dd9-c135-4118-a95c-620c3b6bb3c2.jpg'),
    Certification('Learn Ethical Hacking From Scratch', 'https://ude.my/UC-a247b4da-dede-4368-ab73-4ad280ee5ef7', 'https://udemy-certificate.s3.amazonaws.com/image/UC-a247b4da-dede-4368-ab73-4ad280ee5ef7.jpg'),
    Certification('Flutter & Dart - The Complete Guide', 'https://ude.my/UC-d38b33f6-9674-40b2-a319-cd64643928b5', 'https://udemy-certificate.s3.amazonaws.com/image/UC-d38b33f6-9674-40b2-a319-cd64643928b5.jpg'),
    Certification('DevOps Beginners to Advanced with Projects', 'https://ude.my/UC-0dafc0e6-892b-4117-a750-badce1091708', 'https://udemy-certificate.s3.amazonaws.com/image/UC-0dafc0e6-892b-4117-a750-badce1091708.jpg'),
    Certification('Learn JAVA Programming Beginner to Master', 'https://ude.my/UC-c2d008d1-2cfd-4723-b0e4-c0ae0630ca43', 'https://udemy-certificate.s3.amazonaws.com/image/UC-c2d008d1-2cfd-4723-b0e4-c0ae0630ca43.jpg'),
    Certification('PCB Design: From Idea to Product', 'https://ude.my/UC-9df4d3f1-2eeb-4245-a158-8884d6ff4f73', 'https://udemy-certificate.s3.amazonaws.com/image/UC-9df4d3f1-2eeb-4245-a158-8884d6ff4f73.jpg'),
    Certification('Go - The Complete Guide', 'https://ude.my/UC-560066ed-eb42-4323-b4c6-0dc4f42e23f3', 'https://udemy-certificate.s3.amazonaws.com/image/UC-560066ed-eb42-4323-b4c6-0dc4f42e23f3.jpg'),
    Certification('Flutter BLoC - Zero to Hero', 'https://ude.my/UC-d6cc5e44-2608-4cc7-9596-81d6c3d91305', 'https://udemy-certificate.s3.amazonaws.com/image/UC-d6cc5e44-2608-4cc7-9596-81d6c3d91305.jpg'),
    Certification('Learning Complete PCB Design: From an Idea to a Product', 'https://ude.my/UC-9df4d3f1-2eeb-4245-a158-8884d6ff4f73', 'https://udemy-certificate.s3.amazonaws.com/image/UC-9df4d3f1-2eeb-4245-a158-8884d6ff4f73.jpg'),
    Certification('DevOps, CI/CD(Continuous Integration/DeIivery) for Beginners', 'https://ude.my/UC-5a2f1bbf-d4d8-4b75-a1d2-6b4d79ba800e', 'https://udemy-certificate.s3.amazonaws.com/image/UC-5a2f1bbf-d4d8-4b75-a1d2-6b4d79ba800e.jpg'),
    Certification('How to Set Up an Electronics Lab: Tools & Equipments', 'https://ude.my/UC-0f1e3b5a-f474-48b2-8d9c-35c0511820dd', 'https://udemy-certificate.s3.amazonaws.com/image/UC-0f1e3b5a-f474-48b2-8d9c-35c0511820dd.jpg'),
    Certification('AI Fluency: Framework & Foundations', 'https://verify.skilljar.com/c/m3t6rum2y2px', 'https://i.imgur.com/PdDnZZ1.jpeg'),
    Certification('Claude 101', 'https://verify.skilljar.com/c/wfmycoovhkd6', 'https://i.imgur.com/TcxFrKG.jpeg'),
  ];

  static const badges = [
    Badge('Building AI-Powered Search with MongoDB Vector Search', 'https://www.credly.com/badges/c7dc30b0-da8a-4a72-a75b-f43fabb6c4e5', 'https://images.credly.com/images/730e9c82-7869-4288-b580-9f8500a94465/blob'),
    Badge('Building RAG Apps Using MongoDB', 'https://www.credly.com/badges/70617833-ec67-4564-bd8b-786a4c6ad97c', 'https://images.credly.com/images/2aff887d-ee1e-479f-b26f-dcb20d647bd6/blob'),
  ];

  static const honors = [
    ('2023 – 2025', "Dean's Award — 3 Consecutive Years"),
    ('2017', "President's Scout Award — Honorable President of Bangladesh"),
    ('2018', 'Community Development Award — Ministry Level'),
    ('2012', 'Junior Scholarship'),
  ];

  static final experiences = [
    Experience(
      company: 'University of Frontier Technology',
      role: 'Undergraduate Research Assistant',
      period: 'Jan 2025 – Present',
      description: 'Research on quantum-inspired and classical ML for IoT and network security, plus GPU-accelerated ML.',
      highlights: [
        'Transformer-based models for student mental health detection (IEEE ICECTE 2026)',
        'Quantum ML evaluation for intrusion detection on CICIoT2023 and UNSW-NB15',
        'Decentralized IoT anomaly detection validated in 50-node NS-3 simulation',
      ],
    ),
    Experience(
      company: 'Independent Projects',
      role: 'HPC & AI Engineer (Freelance)',
      period: '2024 – Present',
      description: 'Building GPU-accelerated ML systems and production-grade Flutter apps with AI services.',
      highlights: [
        'GPU-accelerated ML pipelines with RAPIDS (cuML, cuDF)',
        'AI-powered Flutter applications integrating LLM APIs and TTS',
        'IoT systems with ESP32 / Arduino and cloud connectivity',
      ],
    ),
  ];
}
