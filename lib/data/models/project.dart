class Project {
  final String title;
  final String description;
  final String icon;
  final List<String> tags;
  final String? githubUrl;
  final String? liveUrl;

  const Project({
    required this.title,
    required this.description,
    required this.icon,
    required this.tags,
    this.githubUrl,
    this.liveUrl,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'icon': icon,
      'tags': tags,
      'githubUrl': githubUrl,
      'liveUrl': liveUrl,
    };
  }

  // Create from JSON
  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      icon: json['icon'] ?? '',
      tags: json['tags'] != null 
          ? List<String>.from(json['tags'])
          : [],
      githubUrl: json['githubUrl'],
      liveUrl: json['liveUrl'],
    );
  }

  // Copy with method for immutability
  Project copyWith({
    String? title,
    String? description,
    String? icon,
    List<String>? tags,
    String? githubUrl,
    String? liveUrl,
  }) {
    return Project(
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      tags: tags ?? this.tags,
      githubUrl: githubUrl ?? this.githubUrl,
      liveUrl: liveUrl ?? this.liveUrl,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Project &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          description == other.description &&
          icon == other.icon;

  @override
  int get hashCode => title.hashCode ^ description.hashCode ^ icon.hashCode;

  @override
  String toString() {
    return 'Project{title: $title, description: $description, icon: $icon}';
  }
}

// Example usage in your data source:
/*
List<Project> getProjects() {
  return [
    const Project(
      title: 'Quran Mp3 & Qibla Finder',
      description: 'A Flutter-based application delivering precise prayer times, Quran recitation with audio playback, Qibla direction, and daily Azkar. Features include real-time notifications, Hijri calendar, multilingual support, and persistent local storage.',
      icon: 'mosque',
      tags: ['flutter', 'dart', 'provider'],
      githubUrl: 'https://github.com/muhammadwasif12/quran-app',
      liveUrl: null,
    ),
    const Project(
      title: 'Chat Application',
      description: 'Real-time messaging app with Firebase backend, featuring user authentication, group chats, media sharing, and push notifications.',
      icon: 'chat',
      tags: ['flutter', 'firebase', 'realtime'],
      githubUrl: 'https://github.com/muhammadwasif12/chat-app',
      liveUrl: null,
    ),
    const Project(
      title: 'Task Manager',
      description: 'Productivity app for managing daily tasks with categories, priorities, deadlines, and progress tracking.',
      icon: 'tasks',
      tags: ['flutter', 'sqlite', 'provider'],
      githubUrl: 'https://github.com/muhammadwasif12/task-manager',
      liveUrl: null,
    ),
    // Add more projects...
  ];
}
*/

