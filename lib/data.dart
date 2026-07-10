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

class Certification {
  final String title;
  final String verifyUrl;
  final String imageUrl;
  const Certification(this.title, this.verifyUrl, this.imageUrl);
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
    Certification('AI Fluency: Framework & Foundations', 'https://verify.skilljar.com/c/m3t6rum2y2px', 'https://cc.sj-cdn.net/certificate/17owe4fx9adox/certificate-m3t6rum2y2px-1781688207.jpg?Expires=1783685016&Signature=Tk~JPFIi81SFj4Xicxm7YtWxzPT6gb95QAmwbhgW1O8v~ddhEevJ4bQKoy46lcUu3UOngJnWhhDs~VsMZBE6jngQAfthtx4DqyiwIi~SHYoyg5slK18UA1i4BozNoV2zUfJOlIKTcuKLW664AzKmL8ROugde7S4yynmfWhzFzDflDgUnNYP~SnaBIGb4T22KPkTtuYMKCMzYbyOPi8LP8U9D-Gv-pAnsh8aCSDZ740k9TPdhTeyeT0q4WEkMH517fRSavzGhY90P0QzV9-U5mWwlP0bGAQ9Jum7pijE-smWis9h004-5~c2izyziVE4y6C1vAMUTnjMGxYpVIvg4Qw__&Key-Pair-Id=APKAI3B7HFD2VYJQK4MQ'),
    Certification('Claude 101', 'https://verify.skilljar.com/c/wfmycoovhkd6', 'https://cc.sj-cdn.net/certificate/22npsux5ldfq0/certificate-wfmycoovhkd6-1781687868.jpg?Expires=1783685013&Signature=nbByVOlbwYTpPMjGLO6DHg8XPN64glvTtGQu4csp4To~fA7xHm~LVfsIONECSMuC7UGidXGCZVcLJ35SfRSVOmMztDzWhGB6Wpq3pG8KFKx2Rt04qK6RZNoKk1EzS6M6qRZPk7feeS0CtQ5hmJmqWW3D6Y2Y8AdYv33WS52zhDKtQACw-FpQBCCajfhloCX-rj2k4r0BrpK7Ox3NXLyHXVzqv0iqqN649JMxXeQr6POSr6lYwRlYsujamIn0IL1ZbaKhArFuS1D4GdxSD9LX-MZa6ZesdEerDkDSEfB2jOUUxeO5Hpc4NCeWSwP9xOlrK0tEbSCfVzbq1WWdfksczA__&Key-Pair-Id=APKAI3B7HFD2VYJQK4MQ'),
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
