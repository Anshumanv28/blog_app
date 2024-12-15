import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/domain/entities/user.dart';
import 'package:blog_app/features/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  const AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.loginWithEmailPassword(
          email: email, password: password),
    );
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userId = await remoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      );

      // Logging success
      print('User signed up successfully with ID: $userId');
      return right(userId);
    } on ServerException catch (e) {
      // Logging failure
      print('Signup failed with ServerException: ${e.message}');
      return left(Failure(e.message));
    } catch (e) {
      // Catching any other exceptions
      print('Unexpected error during signup: $e');
      return left(Failure('Unexpected error occurred. Please try again.'));
    }
  }
}

Future<Either<Failure, User>> _getUser(
  Future<User> Function() fn,
) async {
  try {
    final user = await fn();

    return right(user);
  } on sb.AuthException catch (e) {
    return left(Failure(e.message));
  } on ServerException catch (e) {
    return left(Failure(e.message));
  }
}
