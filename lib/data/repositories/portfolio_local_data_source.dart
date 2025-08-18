import '../../data/models/project.dart';
import '../../data/models/experience.dart';
import '../../data/models/skill.dart';

class PortfolioLocalDataSource {
  List<Project> getProjects() {
    return const [
      Project(
        title: "Islamic Toolkit App",
        description: "Production-ready Islamic mobile app featuring prayer times with Adhan notifications, accurate Qibla direction finder, daily duas collection, Islamic calendar with Hijri dates, and Tasbeeh counter. Built with MVVM architecture, optimized performance, and monetized with AdMob integration.",
        icon: "mosque",
        tags: ["Flutter", "MVVM", "Riverpod", "Notifications", "AdMob", "Play Store", "Islamic", "Prayer Times"],
        githubUrl: "https://github.com/muhammadwasif12/islamic_toolkit_app",
      ),
      Project(
        title: "Real-Time Chat App",
        description: "WhatsApp-inspired chat application with Firebase authentication, real-time messaging using Firestore, image sharing via Supabase storage, push notifications, user presence indicators, and beautiful glassmorphism UI with smooth Lottie animations.",
        icon: "chat",
        tags: ["Flutter", "Firebase", "Supabase", "Real-time", "Push Notifications", "Lottie", "Glassmorphism", "Chat"],
        githubUrl: "https://github.com/muhammadwasif12/flutter-chat-app",
      ),
      Project(
        title: "Task Manager Pro",
        description: "Comprehensive productivity app with user authentication, task analytics dashboard, interactive charts and graphs, category-based task organization, priority levels, deadline management, and data persistence using SharedPreferences with beautiful modern UI design.",
        icon: "tasks",
        tags: ["Flutter", "Riverpod", "Charts", "SharedPreferences", "Analytics", "Productivity", "Authentication"],
        githubUrl: "https://github.com/muhammadwasif12/task_manager_app",
      ),
      Project(
        title: "Favorite Places App",
        description: "Location-based app for saving and managing favorite places with Google Maps integration, GPS location detection, reverse geocoding for address conversion, SQLite local database storage, and intuitive navigation with premium UI design and smooth user experience.",
        icon: "location",
        tags: ["Flutter", "Google Maps", "SQLite", "Geolocator", "Riverpod", "GPS", "Location"],
        githubUrl: "https://github.com/muhammadwasif12/favorite_places_app",
      ),
      Project(
        title: "Movie Vault App",
        description: "Feature-rich movie discovery app powered by TMDb API, showcasing trending movies, upcoming releases, top-rated films, detailed movie information, search functionality, watchlist management, and Firebase backend integration for user data synchronization.",
        icon: "movie",
        tags: ["Flutter", "REST API", "Firebase", "JSON", "TMDb API", "Search", "Movies"],
        githubUrl: "https://github.com/muhammadwasif12/InternIntelligence_MovieVault_app",
      ),
      Project(
        title: "Meals Recipe App",
        description: "Comprehensive recipe and meal planning application with categorized recipes, detailed cooking instructions, ingredient lists, nutritional information, favorite meals system, and beautiful food photography with smooth navigation and modern design patterns.",
        icon: "restaurant",
        tags: ["Flutter", "Recipes", "UI/UX", "Navigation", "Food", "Categories"],
        githubUrl: "https://github.com/muhammadwasif12/Meals_App",
      ),
    ];
  }

  List<Experience> getExperiences() {
    return const [
      Experience(
        title: "Flutter App Developer",
        company: "Raheem Solutions | Agile Staff Augmentation",
        period: "Jun 2025 - Present",
        description: "Leading cross-platform mobile application development with focus on scalable architecture and performance optimization for enterprise-level Flutter applications.",
        responsibilities: [
          "Architect and develop enterprise-grade cross-platform mobile applications using Flutter and Dart",
          "Implement advanced state management solutions using Provider, Riverpod, and BLoC for complex application states",
          "Design and integrate RESTful APIs with real-time data synchronization using Firebase services (Authentication, Firestore, Cloud Functions, and Storage)",
          "Apply clean architecture principles and modular project structures using dependency injection with get_it and flutter_hooks",
          "Optimize application performance, memory management, and ensure smooth 60fps animations across Android and iOS platforms",
          "Collaborate with cross-functional teams using Agile methodologies and maintain high code quality through code reviews and testing",
        ],
      ),
      Experience(
        title: "Freelance Flutter Developer",
        company: "Upwork • Remote",
        period: "May 2025 - Present",
        description: "Building custom cross-platform mobile applications for international clients with focus on UI/UX excellence and robust functionality.",
        responsibilities: [
          "Deliver custom Flutter applications for diverse client requirements across various industries",
          "Implement complex UI/UX designs with pixel-perfect accuracy and smooth user interactions",
          "Integrate third-party services including payment gateways, social media APIs, and cloud storage solutions",
          "Provide ongoing maintenance, bug fixes, and feature enhancements for existing applications",
          "Maintain 100% client satisfaction rate with timely project delivery and excellent communication",
        ],
      ),
      Experience(
        title: "Software Developer | Flutter Specialist",
        company: "DevelopersHub Corporation • Internship",
        period: "Apr 2025 - Jun 2025",
        description: "Intensive Flutter development program focusing on industry best practices, clean code principles, and real-world application development.",
        responsibilities: [
          "Developed production-ready Flutter applications following industry coding standards and best practices",
          "Collaborated with senior developers on large-scale projects using Git version control and code review processes",
          "Learned advanced Flutter concepts including custom animations, performance optimization, and platform-specific implementations",
          "Participated in daily standups, sprint planning, and retrospective meetings using Scrum methodology",
        ],
      ),
      Experience(
        title: "Flutter Development Intern",
        company: "Intern Intelligence • Remote Internship",
        period: "Mar 2025 - Apr 2025",
        description: "Foundational Flutter development experience with emphasis on Firebase integration and mobile app deployment processes.",
        responsibilities: [
          "Built and deployed Flutter applications with Firebase backend integration including authentication and database operations",
          "Gained hands-on experience with Flutter widgets, state management, and responsive design principles",
          "Learned mobile app deployment processes for both Google Play Store and Apple App Store",
          "Completed multiple mini-projects demonstrating proficiency in different Flutter concepts and packages",
        ],
      ),
    ];
  }

  List<Skill> getSkills() {
    return const [
      // Core Development
      Skill(name: "Flutter", icon: "flutter", level: "Expert"),
      Skill(name: "Dart", icon: "code", level: "Expert"),
      Skill(name: "Object-Oriented Programming", icon: "code", level: "Advanced"),
      
      // State Management
      Skill(name: "Riverpod", icon: "state", level: "Advanced"),
      Skill(name: "Provider", icon: "state", level: "Advanced"),
      Skill(name: "BLoC Pattern", icon: "state", level: "Intermediate"),
      
      // Backend & Database
      Skill(name: "Firebase", icon: "fire", level: "Advanced"),
      Skill(name: "Supabase", icon: "database", level: "Intermediate"),
      Skill(name: "SQLite", icon: "database", level: "Advanced"),
      Skill(name: "REST APIs", icon: "api", level: "Advanced"),
      
      // Tools & Platforms
      Skill(name: "Git/GitHub", icon: "git", level: "Advanced"),
      Skill(name: "Android Studio", icon: "android", level: "Advanced"),
      Skill(name: "VS Code", icon: "code", level: "Expert"),
      Skill(name: "Figma", icon: "design", level: "Intermediate"),
      
      // Additional Technologies
      Skill(name: "Google Maps API", icon: "location", level: "Intermediate"),
      Skill(name: "Push Notifications", icon: "notification", level: "Advanced"),
      Skill(name: "AdMob Integration", icon: "ads", level: "Intermediate"),
      Skill(name: "App Store Deployment", icon: "mobile", level: "Advanced"),
    ];
  }

  // Additional method for project categories
  List<String> getProjectCategories() {
    return const [
      "All",
      "Production Apps",
      "Firebase Integration",
      "API Integration",
      "UI/UX Showcase",
      "Utility Apps",
    ];
  }

  // Method to get projects by category
  List<Project> getProjectsByCategory(String category) {
    final allProjects = getProjects();
    
    switch (category) {
      case "All":
        return allProjects;
      case "Production Apps":
        return allProjects.where((project) => 
          project.tags.contains("Play Store") || 
          project.tags.contains("Production")
        ).toList();
      case "Firebase Integration":
        return allProjects.where((project) => 
          project.tags.contains("Firebase")
        ).toList();
      case "API Integration":
        return allProjects.where((project) => 
          project.tags.contains("REST API") || 
          project.tags.contains("TMDb API")
        ).toList();
      case "UI/UX Showcase":
        return allProjects.where((project) => 
          project.tags.contains("UI/UX") || 
          project.tags.contains("Glassmorphism")
        ).toList();
      case "Utility Apps":
        return allProjects.where((project) => 
          project.tags.contains("Utilities") || 
          project.tags.contains("Productivity")
        ).toList();
      default:
        return allProjects;
    }
  }

  // Method for featured projects (top 3)
  List<Project> getFeaturedProjects() {
    return getProjects().take(3).toList();
  }

  // Method for recent projects
  List<Project> getRecentProjects({int limit = 4}) {
    return getProjects().take(limit).toList();
  }

  // Method to get stats
  Map<String, int> getPortfolioStats() {
    final projects = getProjects();
    final experiences = getExperiences();
    final skills = getSkills();
    
    return {
      'totalProjects': projects.length,
      'totalExperience': experiences.length,
      'totalSkills': skills.length,
      'yearsOfExperience': 2, // Calculate based on actual experience
      'completedProjects': projects.length,
      'satisfiedClients': 15, // Update based on actual client count
    };
  }
}