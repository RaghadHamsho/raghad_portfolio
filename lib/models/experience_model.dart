import 'package:equatable/equatable.dart';

class ExperienceModel extends Equatable {
  final String role;
  final String company;
  final String period;
  final String location;
  final List<String> description; 
  const ExperienceModel({
    required this.role,
    required this.company,
    required this.period,
    required this.location,
    required this.description
  });

  @override
  List<Object?> get props => [role, company, period, location , description];
}
