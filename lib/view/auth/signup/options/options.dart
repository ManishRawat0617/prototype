class DifferentOptions {
  // List of language proficiency levels
  final List<String> languageProficiencyLevels = [
    'Beginner',
    'Intermediate',
    'Native',
  ];

  // List of industry categories
  final List<String> industryCategory = [
    "Information Technology (IT)",
    "Marketing",
    "Design",
    "Business & Management",
    "Healthcare",
    "Engineering",
    "Creative Arts",
    "Other Notable Categories"
  ];

  final Map<String, List<String>> industryRoles = {
    "Information Technology (IT)": [
      "",
      "Frontend Developer",
      "Backend Developer",
      "Full Stack Developer",
      "DevOps Engineer",
      "Cybersecurity Analyst",
      "Data Scientist",
      "AI/ML Engineer",
      "Cloud Engineer",
      "Software Engineer",
      "Database Administrator"
    ],
    "Marketing": [
      "",
      "Digital Marketing Specialist",
      "SEO Analyst",
      "Content Strategist",
      "Social Media Manager",
      "Brand Manager",
      "Market Research Analyst",
      "PPC Specialist",
      "Email Marketing Specialist"
    ],
    "Design": [
      "",
      "UI/UX Designer",
      "Graphic Designer",
      "Product Designer",
      "Motion Graphics Designer",
      "3D Modeler",
      "Illustrator",
      "Game Designer"
    ],
    "Business & Management": [
      "",
      "Business Analyst",
      "Project Manager",
      "Operations Manager",
      "Financial Analyst",
      "Human Resources Manager",
      "Sales Manager",
      "Consultant"
    ],
    "Healthcare": [
      "",
      "Doctor",
      "Nurse",
      "Medical Researcher",
      "Healthcare Administrator",
      "Pharmacist",
      "Physical Therapist",
      "Medical Data Analyst"
    ],
    "Engineering": [
      "",
      "Mechanical Engineer",
      "Electrical Engineer",
      "Civil Engineer",
      "Software Engineer",
      "Aerospace Engineer",
      "Biomedical Engineer",
      "Chemical Engineer"
    ],
    "Creative Arts": [
      "",
      "Photographer",
      "Videographer",
      "Writer",
      "Editor",
      "Animator",
      "Musician",
      "Actor"
    ],
    "Other Notable Categories": [
      "",
      "Legal Advisor",
      "Teacher",
      "Research Scientist",
      "Data Analyst",
      "Entrepreneur",
      "Economist",
      "Policy Analyst"
    ]
  };
  final List<String> monthsExperienceLevel =
      List.generate(12, (index) => "${index}");

  final List<String> YearsExperienceLevel =
      List.generate(21, (index) => index == 20 ? "+20" : "${index}");

  final List<String> languages = [
    "Arabic",
    "Bengali",
    "Chinese",
    "Danish",
    "Dutch",
    "English",
    "French",
    "German",
    "Greek",
    "Gujarati",
    "Hebrew",
    "Hindi",
    "Italian",
    "Japanese",
    "Kannada",
    "Korean",
    "Malayalam",
    "Marathi",
    "Nepali",
    "Polish",
    "Portuguese",
    "Punjabi",
    "Russian",
    "Spanish",
    "Tamil",
    "Telugu",
    "Turkish",
    "Urdu",
    "Vietnamese",
    "Welsh"
  ];
}
