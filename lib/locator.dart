import 'package:get_it/get_it.dart';
import 'package:todo_app/screens/view_model/tasks_view_model.dart';
import 'package:todo_app/services/local_services.dart';

GetIt locator = GetIt.instance;

Future setupLocator() async {
  locator.registerLazySingleton<LocalServices>(() => LocalServices());
  locator.registerFactory<TasksViewModel>(() => TasksViewModel(
    localServices:locator<LocalServices>(),
  ));
}
