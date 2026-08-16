import '../models/experience_model.dart';
import '../models/project_model.dart';
import '../models/skill_model.dart';

class PortfolioRepository {
  List<ExperienceModel> getExperiences() => const [
    ExperienceModel(
      role: 'Flutter Developer',
      company: 'Smart Software Solutions',
      period: '2022 — 2026',
      location: 'Doha, Qatar',
      description: [
        'Developed and maintained scalable cross-platform mobile applications using Flutter and Dart.',
        'Built applications across multiple domains, including business, services, and government-related solutions.',
        'Delivered applications used by 100+ active users with reliable performance and stability.',
        'Integrated RESTful APIs and third-party services for efficient data handling.',
        'Improved application performance by up to 30% through code optimization and efficient state management.',
        'Collaborated closely with UI/UX designers to implement responsive and pixel-perfect designs.',
      ],
    ),

    ExperienceModel(
      role: 'Flutter Developer (Freelance)',
      company: 'Self-employed',
      period: '2025 — 2026',
      location: 'Damascus, Syria',
      description: [
        'Delivered custom mobile applications using Flutter tailored to client requirements across different industries.',
        'Built apps for chat systems, service platforms, business tools, and file download features.',
        'Implemented Firebase services for push notifications, real-time chat, and email-based password reset.',
        'Used WebSocket technology to build real-time chat features with low latency.',
        'Implemented secure file download functionality with proper storage handling.',
      ],
    ),

    ExperienceModel(
      role: 'Android Native Developer',
      company: 'Smart Software Solutions',
      period: '2022 — 2024',
      location: 'Doha, Qatar',
      description: [
        'Built and maintained Android applications using Java and Kotlin.',
        'Developed applications for multiple sectors, enhancing functionality and user experience.',
        'Integrated RESTful APIs and handled JSON/XML data processing.',
        'Followed MVVM architecture and best practices for clean, maintainable code.',
        'Collaborated with backend teams to deliver high-quality software.',
      ],
    ),

    ExperienceModel(
      role: 'UI / UX Designer',
      company: '',
      period: '2025 — 2026',
      location: 'Doha, Qatar',
      description: [
        'Designed user-centered mobile and web interfaces using Figma.',
        'Created designs for applications across different industries and user needs.',
        'Developed wireframes, prototypes, and design systems aligned with modern UI/UX principles.',
        'Conducted usability testing and user research to enhance user satisfaction.',
        'Worked closely with developers to ensure design feasibility and consistency.',
        'Applied accessibility and responsive design standards.',
      ],
    ),
  ];
  List<SkillCategory> getSkills() => const [
    SkillCategory(
      title: 'Mobile & Web',
      items: [
        'Flutter (Mobile & Web)',
        'Android Native',
        'Dart',
        'RESTful APIs',
        'State Management',
        'MVC / MVVM',
        'Clean Architecture',
        'Responsive UI',
        'Google Play Deployment',
      ],
      images: [
        'flutter.png',
        'android.png',
        'Dart.png',
        'api.png',
        'bloc.png',
        'mvc.png',
        'clean_architecture.png',
        'responsive.png',
        'google.png',
      ],
    ),

    SkillCategory(
      title: 'UI / UX',
      items: ['UI/UX Collaboration', 'Figma — Design & Prototyping'],
      images: ['ux-ui.png', 'figma.png'],
    ),

    SkillCategory(
      title: 'Back-End & DB',
      items: ['Laravel', 'Firebase', 'SQL Databases', 'Socket Connections'],
      images: ['laravel.png', 'firebase.png', 'sql.png', 'socket.png'],
    ),

    SkillCategory(
      title: 'Tools',
      items: ['Git', 'Agile / Scrum', 'Scalable Code Design'],
      images: ['git.png', 'agile.png', 'code.png'],
    ),
  ];

  List<ProjectModel> getProjects() => const [
    ProjectModel(
      title: 'Content Management System',
      longDescription:
          'Enterprise CMS for government & private institutions — file classification, indexing, permissions, inbox and workflow actions.',
      features: [
        'File classification and indexing',
        'User permissions and access control',
        'Inbox and workflow management',
      ],
      tags: ['Flutter', 'Bloc', 'REST', 'Enterprise'],
      images: [
        'assets/cms/screen1.png',
        'assets/cms/screen2.png',
        'assets/cms/screen3.png',
        'assets/cms/screen4.png',
        'assets/cms/screen5.png',
        'assets/cms/screen6.png',
        'assets/cms/screen8.png',
        'assets/cms/screen10.png',
        'assets/cms/screen11.png',
        'assets/cms/screen17.png',
      ],
    ),
    ProjectModel(
      title: 'Al Meera',
      longDescription:
          'Hypermarket app for Qatar — browse products, redeem rewards across all locations, integrated electronic payment.',
      features: ['Browse products', 'Redeem rewards across all locations', 'Integrated electronic payment'],
      tags: ['Flutter', 'Payments', 'Loyalty'],
      platform: '',
      images: [
        'assets/al_meera/screen1.png',
        'assets/al_meera/screen2.png',
        'assets/al_meera/screen3.png',
        'assets/al_meera/screen4.png',
        'assets/al_meera/screen5.png',
        'assets/al_meera/screen6.png',
        'assets/al_meera/screen7.png',
        'assets/al_meera/screen8.png',
        'assets/al_meera/screen9.png',
        'assets/al_meera/screen10.png',
      ],
    ),
    ProjectModel(
      title: 'Loyalty System',
      longDescription:
          'Points & vouchers platform for partner retail stores. Customers earn points on purchases and redeem as discounts.',
      features: ['Earn points on purchases', 'Redeem points as discounts'],
      tags: ['Flutter', 'Web', 'Laravel'],
      platform: 'Web + Mobile',
      images: [
        'assets/loyalty/screen1.png',
        'assets/loyalty/screen2.png',
        'assets/loyalty/screen3.png',
        'assets/loyalty/screen4.png',
        'assets/loyalty/screen5.png',
        'assets/loyalty/screen6.png',
        'assets/loyalty/screen7.png',
        'assets/loyalty/screen8.png',
        'assets/loyalty/screen9.png',
        'assets/loyalty/screen10.png',
      ],
    ),

    ProjectModel(
      title: 'Lusso',
      longDescription:
          'E-commerce platform in Qatar for premium chocolate — electronic payment, order management, admin dashboard & push notifications.',
      features: ['Electronic payment', 'Order management', 'Admin dashboard', 'Push notifications'],
      tags: ['Flutter', 'E-commerce', 'Web Admin'],
      platform: 'Web + Mobile',
      images: [
        'assets/lusso/screen1.png',
        'assets/lusso/screen2.png',
        'assets/lusso/screen3.png',
        'assets/lusso/screen4.png',
        'assets/lusso/screen5.png',
        'assets/lusso/screen6.png',
        'assets/lusso/screen7.png',
        'assets/lusso/screen8.png',
        'assets/lusso/screen9.png',
      ],
    ),
    ProjectModel(
      title: 'Ehsan',
      longDescription:
          'Charity platform for donations and volunteering — donation tracking, volunteer management, and event organization.',
      features: ['Donation tracking', 'Volunteer management', 'Event organization'],
      tags: ['Flutter', 'Charity', 'Web Admin'],
      platform: '',
      images: [
        'assets/ehsan/screen1.jpg',
        'assets/ehsan/screen2.jpg',
        'assets/ehsan/screen3.jpg',
        'assets/ehsan/screen4.jpg',
        'assets/ehsan/screen5.jpg',
        'assets/ehsan/screen6.jpg',
        'assets/ehsan/screen7.jpg',
        'assets/ehsan/screen8.jpg',
        'assets/ehsan/screen9.jpg',
        'assets/ehsan/screen10.jpg',
      ],
    ),
    ProjectModel(
      title: 'Lotus Buds',
      longDescription:
          'Support platform for children with special needs — progress tracking, weekly updates, annual reports and administrative management.',
      features: ['Progress tracking', 'Weekly updates', 'Annual reports', 'Administrative management'],
      tags: ['Flutter', 'Web', 'Education'],
      platform: 'Web + Mobile',
      images: [
        'assets/lotus_buds/screen1.png',
        'assets/lotus_buds/screen2.png',
        'assets/lotus_buds/screen3.png',
        'assets/lotus_buds/screen4.png',
        'assets/lotus_buds/screen5.png',
        'assets/lotus_buds/screen6.png',
        'assets/lotus_buds/screen7.png',
        'assets/lotus_buds/screen8.png',
        'assets/lotus_buds/screen9.png',
      ],
    ),

    ProjectModel(
      title: 'Committee Management App',
      longDescription:
          'Manage committee sessions, actions, and decisions in one place, with easy tracking and follow-up.',
      features: ['Schedule meetings', 'Send invitations', 'Track attendance'],
      tags: ['Flutter', 'Sessions', 'Productivity'],
      platform: '',
      images: [
        'assets/meeting/screen1.png',
        'assets/meeting/screen2.png',
        'assets/meeting/screen3.png',
        'assets/meeting/screen4.png',
        'assets/meeting/screen5.png',
        'assets/meeting/screen6.png',
        'assets/meeting/screen7.png',
        'assets/meeting/screen8.png',
        'assets/meeting/screen12.png',
        'assets/meeting/screen9.png',
        'assets/meeting/screen13.png',
      ],
    ),

    ProjectModel(
      title: 'Ministry of Justice',
      longDescription:
          'A comprehensive memorandum management system designed to streamline document tracking and workflow automation within the ministry. ',
      features: [
        'Workflow automation for memorandum processing',
        'Integration with existing ministry systems',
        'Multi-level approvals and action tracking',
        'Dashboards for monitoring and reporting',
        'Advanced search and filtering',
        'Multi-language support',
        'Dark and light mode interface',
      ],
      tags: ['Flutter', 'Enterprise', 'Workflow', 'Government'],
      platform: '',
      images: [
        'assets/moj/screen1.png',
        'assets/moj/screen2.png',
        'assets/moj/screen3.png',
        'assets/moj/screen4.png',
        'assets/moj/screen5.png',
        'assets/moj/screen6.png',
        'assets/moj/screen7.png',
        'assets/moj/screen8.png',
        'assets/moj/screen9.png',
      ],
    ),
  ];
}
