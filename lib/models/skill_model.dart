import 'package:equatable/equatable.dart';

class SkillCategory extends Equatable {
  final String title;
  final List<String> items;
 final List<String> images;
  const SkillCategory({required this.title, required this.items , required this.images});

  @override
  List<Object?> get props => [title, items , images];
}
