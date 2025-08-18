
// features/portfolio/data/repositories/portfolio_repository_impl.dart
import '../repositories/portfolio_local_data_source.dart';
import '../../data/models/project.dart';
import '../../data/models/experience.dart';
import '../../data/models/skill.dart';
import '../../data/repositories/portfolio_repository.dart';

class PortfolioRepositoryImpl implements PortfolioRepository {
  final PortfolioLocalDataSource localDataSource;

  const PortfolioRepositoryImpl({required this.localDataSource});

  @override
  List<Project> getProjects() {
    return localDataSource.getProjects();
  }

  @override
  List<Experience> getExperiences() {
    return localDataSource.getExperiences();
  }

  @override
  List<Skill> getSkills() {
    return localDataSource.getSkills();
  }
}