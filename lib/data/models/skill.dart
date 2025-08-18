// data/models/skill.dart
class Skill {
  final String name;
  final String icon;
  final String level;
  final String? description;
  final List<String>? subSkills;

  const Skill({
    required this.name,
    required this.icon,
    this.level = "Intermediate",
    this.description,
    this.subSkills,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'icon': icon,
      'level': level,
      'description': description,
      'subSkills': subSkills,
    };
  }

  // Create from JSON
  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      name: json['name'] ?? '',
      icon: json['icon'] ?? '',
      level: json['level'] ?? 'Intermediate',
      description: json['description'],
      subSkills: json['subSkills'] != null 
          ? List<String>.from(json['subSkills'])
          : null,
    );
  }

  // Copy with method for immutability
  Skill copyWith({
    String? name,
    String? icon,
    String? level,
    String? description,
    List<String>? subSkills,
  }) {
    return Skill(
      name: name ?? this.name,
      icon: icon ?? this.icon,
      level: level ?? this.level,
      description: description ?? this.description,
      subSkills: subSkills ?? this.subSkills,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Skill &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          icon == other.icon &&
          level == other.level;

  @override
  int get hashCode => name.hashCode ^ icon.hashCode ^ level.hashCode;

  @override
  String toString() {
    return 'Skill{name: $name, icon: $icon, level: $level}';
  }
}