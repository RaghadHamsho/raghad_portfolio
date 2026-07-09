import 'package:equatable/equatable.dart';

class ProjectModel extends Equatable {
  final String title;
  final String longDescription;
   final List<String> features;
  final List<String> tags;
  final String? platform;
  final List<String> images;
  const ProjectModel({
    required this.title,
required this.longDescription,
    required this.features,
    required this.tags,
    this.platform,
    required this.images,
  });

  @override
  List<Object?> get props => [title, longDescription, features, tags, platform];
}
