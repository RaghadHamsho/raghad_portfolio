import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(isDark: true)) {
    _load();
  }

  static const _key = 'is_dark';

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(_key) ?? true;
    emit(state.copyWith(isDark: isDark));
  }

  Future<void> toggle() async {
    final next = !state.isDark;
    emit(state.copyWith(isDark: next));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, next);
  }
}
