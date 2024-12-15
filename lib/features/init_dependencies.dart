import 'package:blog_app/core/secrets/supa_secrets.dart';
import 'package:blog_app/features/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/data/repositories/auth_repository_impl.dart';
import 'package:blog_app/features/domain/repository/auth_repository.dart';
import 'package:blog_app/features/domain/usecases/user_sign_up.dart';
import 'package:blog_app/features/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:blog_app/features/domain/usecases/user_login.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
      url: AppSecrets.supabaseUrl, anonKey: AppSecrets.supabaseAnonKey);
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserSignUp(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserLogin(
      serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocator(),
      userLogin: serviceLocator(),
    ),
  );
}

//if registerFactory is used serviceLocator will create a new instance of the object
//if registerLazySingleton is used serviceLocator will create a single instance of the object
