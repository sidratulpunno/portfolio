class Education {
  final String year;
  final String title;
  final String subtitle;
  final String detail;
  const Education(this.year, this.title, this.subtitle, this.detail);
}

class Publication {
  final String date;
  final String title;
  final String venue;
  const Publication(this.date, this.title, this.venue);
}

class Project {
  final String title;
  final String tech;
  final List<String> points;
  const Project(this.title, this.tech, this.points);
}

class ResumeData {
  ResumeData._();

  static const name = 'Sheikh Sidratul\nMuntaha Punno';
  static const tagline = 'HPC & AI Engineer';
  static const email = 'sheikhpunno400@gmail.com';
  static const phone = '+8801941529696';
  static const github = 'sidratulpunno';
  static const linkedin = 'sidratul-punno-51a0832b6';

  static const summary =
      'Engineering student specializing in High Performance Computing (HPC) '
      'and GPU accelerated Machine Learning using CUDA, cuML, and cuDF. '
      'Experienced in designing scalable ML pipelines, parallel computing '
      'workflows, and performance-optimized GPU systems. Also proficient in '
      'building production-grade Flutter applications integrated with AI '
      'services. Seeking opportunities in HPC, GPU computing, and AI-driven '
      'systems.';

  static const interests = [
    'High-Performance Computing',
    'GPU-Accelerated Machine Learning',
    'Parallel Algorithms',
    'LLM Steering & Fine Tuning',
    'Assistive & Human-Centered AI',
    'AI-Enabled Mobile Systems',
  ];

  static const education = [
    Education('2023 – 2026', 'B.Sc. in IoT & Robotics Engineering',
        'University of Frontier Technology, Bangladesh', 'CGPA (7th Sem): 3.84 / 4.00'),
    Education('2021', 'Higher Secondary School Certificate', '', 'GPA: 5.0/5.0'),
    Education('2018', 'Secondary School Certificate', '', 'GPA: 5.0/5.0'),
  ];

  static const publications = [
    Publication(
        'Jan 2026',
        'Transformer-Based Models for Student Mental Health Detection: A Comparative Study of BERT, RoBERTa and Gemma',
        'IEEE ICECTE 2026, Rajshahi, Bangladesh'),
    Publication(
        'Apr 2026',
        'AgriMind: An IoT-Driven LLM Framework for Intelligent Precision Agriculture',
        'IEEE QPAIN 2026, Chittagong, Bangladesh'),
  ];

  static const skills = [
    ('HPC & GPU Computing', [
      'CUDA C/C++',
      'NVIDIA RAPIDS',
      'cuML',
      'cuDF',
      'Nsight Compute',
    ]),
    ('AI & Machine Learning', [
      'Deep Learning',
      'LoRA',
      'LLM Fine Tuning',
      'Computer Vision',
      'RoBERTa',
    ]),
    ('Mobile Development', ['Flutter', 'Firebase', 'TFLite']),
    ('Languages', ['Python', 'CUDA C/C++', 'Dart', 'C', 'C++', 'Rust']),
    ('Backend & IoT', ['FastAPI', 'Flask', 'Arduino', 'ESP32', 'Raspberry Pi']),
    ('Tools & Platforms', ['Git', 'Docker', 'Linux', 'Azure', 'Altium']),
  ];

  static const projects = [
    Project('GPU-Accelerated ML Pipeline', 'CUDA | cuML | cuDF', [
      'GPU-accelerated ML pipelines using NVIDIA RAPIDS ecosystem',
      'cuDF for large-scale GPU data preprocessing',
      'Multi-fold training speedups vs CPU-based workflows',
    ]),
    Project('Smart Navigation Assistant', 'AI | Flutter | CV', [
      'AI-powered Flutter app for real-time assistive navigation with LLM',
      'Object detection, distance estimation, and TTS-based guidance',
    ]),
    Project('Mental Health Detection', 'NLP | RoBERTa | Gemma', [
      'Transformer model for mental health text classification',
      'CLI-based inference for streamlined testing evaluation',
    ]),
    Project('Video Conferencing App', 'Flutter | Firebase | Jitsi', [
      'Real-time video conferencing with Jitsi Meet SDK',
      'Firebase auth, real-time chat, and meeting management',
    ]),
    Project('Smart Door Lock System', 'IoT | ESP32', [
      'Cloud-connected security system with ESP32 microcontroller',
      'Remote monitoring and secure access control via IoT',
    ]),
  ];

  static const certifications = [
    ('Learn C++ Programming Beginner to Advance Deep Dive in C++', 'UC-780d24b1-eedd-4870-a91e-a4a74f4f6e9f','https://udemy-certificate.s3.amazonaws.com/image/UC-780d24b1-eedd-4870-a91e-a4a74f4f6e9f.jpg'),
    ('Machine Learning A-Z', 'UC-c6847dd9-c135-4118-a95c-620c3b6bb3c2','https://udemy-certificate.s3.amazonaws.com/image/UC-c6847dd9-c135-4118-a95c-620c3b6bb3c2.jpg'),
    ('Learn Ethical Hacking From Scratch', 'UC-a247b4da-dede-4368-ab73-4ad280ee5ef7','https://udemy-certificate.s3.amazonaws.com/image/UC-a247b4da-dede-4368-ab73-4ad280ee5ef7.jpg'),
    ('Flutter & Dart - The Complete Guide', 'UC-d38b33f6-9674-40b2-a319-cd64643928b5','https://udemy-certificate.s3.amazonaws.com/image/UC-d38b33f6-9674-40b2-a319-cd64643928b5.jpg'),
    ('DevOps Beginners to Advanced with Projects', 'UC-0dafc0e6-892b-4117-a750-badce1091708','https://udemy-certificate.s3.amazonaws.com/image/UC-0dafc0e6-892b-4117-a750-badce1091708.jpg'),
    ('Learn JAVA Programming Beginner to Master', 'UC-c2d008d1-2cfd-4723-b0e4-c0ae0630ca43','https://udemy-certificate.s3.amazonaws.com/image/UC-c2d008d1-2cfd-4723-b0e4-c0ae0630ca43.jpg'),
    ('PCB Design: From Idea to Product', 'UC-9df4d3f1-2eeb-4245-a158-8884d6ff4f73','https://udemy-certificate.s3.amazonaws.com/image/UC-9df4d3f1-2eeb-4245-a158-8884d6ff4f73.jpg'),
    ('Go - The Complete Guide', 'UC-560066ed-eb42-4323-b4c6-0dc4f42e23f3','https://udemy-certificate.s3.amazonaws.com/image/UC-560066ed-eb42-4323-b4c6-0dc4f42e23f3.jpg'),
    ('Flutter BLoC - Zero to Hero', 'UC-d6cc5e44-2608-4cc7-9596-81d6c3d91305','https://udemy-certificate.s3.amazonaws.com/image/UC-d6cc5e44-2608-4cc7-9596-81d6c3d91305.jpg'),
    ('Learning Complete PCB Design: From an Idea to a Product', 'UC-9df4d3f1-2eeb-4245-a158-8884d6ff4f73','https://udemy-certificate.s3.amazonaws.com/image/UC-9df4d3f1-2eeb-4245-a158-8884d6ff4f73.jpg'),
    ('DevOps, CI/CD(Continuous Integration/DeIivery) for Beginners', 'UC-5a2f1bbf-d4d8-4b75-a1d2-6b4d79ba800e','https://udemy-certificate.s3.amazonaws.com/image/UC-5a2f1bbf-d4d8-4b75-a1d2-6b4d79ba800e.jpg'),
    ('How to Set Up an Electronics Lab: Tools & Equipments', 'UC-0f1e3b5a-f474-48b2-8d9c-35c0511820dd','https://udemy-certificate.s3.amazonaws.com/image/UC-0f1e3b5a-f474-48b2-8d9c-35c0511820dd.jpg'),

  ];
  static const badges = [
    ('Building AI-Powered Search with MongoDB Vector Search', 'https://www.credly.com/badges/c7dc30b0-da8a-4a72-a75b-f43fabb6c4e5','https://images.credly.com/images/730e9c82-7869-4288-b580-9f8500a94465/blob'),
    ('Building RAG Apps Using MongoDB', 'https://www.credly.com/badges/70617833-ec67-4564-bd8b-786a4c6ad97c','https://images.credly.com/images/2aff887d-ee1e-479f-b26f-dcb20d647bd6/blob'),
  ];

  static const honors = [
    ('2023 – 2025', 'Dean\'s Award — 3 Consecutive Years'),
    ('2017', 'President\'s Scout Award — Honorable President of Bangladesh'),
    ('2018', 'Community Development Award — Ministry Level'),
    ('2012', 'Junior Scholarship'),
  ];
}
