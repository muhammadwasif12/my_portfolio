import 'package:my_portfolio/data/models/experience.dart';

class ExperienceData {
  static List<Experience> getExperiences() {
    return [
      Experience(
        title: 'Flutter App Developer',
        company: 'Raheem Solutions | Lahore',
        period: 'Jun 2025 - Present',
        description: '',
        responsibilities: [
          'Architect and develop enterprise-grade cross-platform mobile applications using Flutter and Dart',
          'Implement advanced state management solutions using Provider and Riverpod for complex application states',
          'Design and integrate RESTful APIs with real-time data synchronization using Firebase services (Authentication, Firestore, Cloud Functions, and Storage)',
          'Apply clean architecture principles and modular development practices for scalable and maintainable codebases',
          'Develop Islamic applications with custom UI/UX designs and Arabic/Urdu localization support',
          'Collaborate with cross-functional teams in a hybrid work environment to deliver high-quality mobile solutions',
        ],
      ),
      Experience(
        title: 'Mobile App Development Intern',
        company: 'Developer Hub Corporation',
        period: 'Apr 2025 - Jun 2025',
        description: '',
        responsibilities: [
          'Contributed to multiple cross-platform mobile application projects using Flutter framework',
          'Gained hands-on experience with modern state management patterns including Provider and Riverpod',
          'Participated in agile development processes and collaborative coding practices',
          'Assisted in debugging, testing, and optimizing mobile applications for better performance',
          'Learned industry best practices for mobile app development lifecycle',
        ],
      ),
      Experience(
        title: 'Flutter Development Intern',
        company: 'Intern Intelligence',
        period: 'Mar 2025 - Apr 2025',
        description: '',
        responsibilities: [
          'Developed foundational skills in Flutter mobile application development',
          'Worked with Provider state management for building reactive user interfaces',
          'Participated in code reviews and learned industry coding standards',
          'Gained experience in mobile app UI/UX implementation and responsive design principles',
        ],
      ),
      Experience(
        title: 'Freelance Flutter Developer',
        company: 'Upwork & Independent Projects',
        period: '2024 - Present',
        description: '',
        responsibilities: [
          'Deliver custom mobile applications for international clients across various industries',
          'Provide end-to-end development services from UI/UX design to deployment and maintenance',
          'Specialize in Islamic applications, e-commerce solutions, and business productivity apps',
          'Maintain high client satisfaction ratings through quality deliverables and timely communication',
          'Handle project management, client consultations, and technical requirement analysis independently',
        ],
      ),
    ];
  }

  // Future additions ke liye helper methods
  static List<Experience> getCurrentExperiences() {
    return getExperiences().where((exp) => exp.period.contains('Present')).toList();
  }

  static List<Experience> getPastExperiences() {
    return getExperiences().where((exp) => !exp.period.contains('Present')).toList();
  }

  static int getTotalExperienceCount() {
    return getExperiences().length;
  }
}