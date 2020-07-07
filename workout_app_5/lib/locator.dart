import 'package:get_it/get_it.dart';
import 'package:workout_app_5/core/components/provider/creating/course_creation_provider.dart';


GetIt locator = GetIt.instance;

void setupLocator() {
  print('HULLO');
  locator.registerLazySingleton(() => CourseCreationProvider());
}