class Experience {
  final String title;
  final String company;
  final String period;
  final String description;
  final List<String>? responsibilities;

  const Experience({
    required this.title,
    required this.company,
    required this.period,
    required this.description,
    this.responsibilities,
  });
}