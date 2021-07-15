

//constant scope
// const other = DartInScope('other');
// const params = DartInScope('params');

//
// final repoModule = Module([
//   single<GithubRepo>(() => GithubRepo(get<GithubService>())),
// ]);

// final remoteModule = Module([
//   single<Personal>(({required params}) => Personal(params.get(0))),
// ])
//   ..withScope(other, []);
//
//
// final appModule = [remoteModule];
//
// class Personal {
//   int id;
//
//   Personal(this.id);
// }






import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory(() => AppInfo());
}

class AppInfo {
  String get welcomeMessage => 'Hello from FilledStacks';
}