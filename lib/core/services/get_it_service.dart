import 'package:get_it/get_it.dart';
import '../../features/auth/data/repo/auth_repo_implemtation.dart';
import '../../features/auth/domain/repo/auth_repo.dart';
import 'firebase_auth_service.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());

  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(
      firebaseAuthService: getIt<FirebaseAuthService>(),
    ),
  );
}