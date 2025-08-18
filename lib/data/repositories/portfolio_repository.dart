
import '../../data/models/project.dart';
import '../../data/models/experience.dart';
import '../../data/models/skill.dart';

abstract class PortfolioRepository {
  List<Project> getProjects();
  List<Experience> getExperiences();
  List<Skill> getSkills();
}