class Education {
  final String year;
  final String title;
  final String institution;
  final String detail;
  const Education(this.year, this.title, this.institution, this.detail);
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
  final String? githubUrl;
  final String? liveUrl;
  const Project({
    required this.title,
    required this.tech,
    required this.points,
    this.githubUrl,
    this.liveUrl,
  });
}

class SkillCategory {
  final String name;
  final List<String> skills;
  const SkillCategory(this.name, this.skills);
}

class Certification {
  final String title;
  final String verifyUrl;
  final String imageUrl;
  const Certification(this.title, this.verifyUrl, this.imageUrl);
}

class Badge {
  final String title;
  final String verifyUrl;
  final String imageUrl;
  const Badge(this.title, this.verifyUrl, this.imageUrl);
}

class Experience {
  final String company;
  final String role;
  final String period;
  final String description;
  final List<String> highlights;
  final String? logoUrl;
  const Experience({
    required this.company,
    required this.role,
    required this.period,
    required this.description,
    this.highlights = const [],
    this.logoUrl,
  });
}
