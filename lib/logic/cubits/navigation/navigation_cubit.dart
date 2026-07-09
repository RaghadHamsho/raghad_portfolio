import 'package:flutter_bloc/flutter_bloc.dart';

enum Section { home, about, skills, experience, projects, contact }

class NavigationCubit extends Cubit<Section> {
  NavigationCubit() : super(Section.home);

  void select(Section s) => emit(s);
}
