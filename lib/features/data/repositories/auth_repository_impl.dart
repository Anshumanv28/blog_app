// import 'package:blog_app/core/error/exceptions.dart';
// import 'package:blog_app/core/error/failure.dart';
// import 'package:blog_app/features/data/datasources/auth_remote_data_source.dart';
// import 'package:blog_app/features/domain/repository/auth_repository.dart';
// import 'package:fpdart/fpdart.dart';
//
// class AuthRepositoryImpl implements AuthRepository {
//   final AuthRemoteDataSource remoteDataSource;
//   const AuthRepositoryImpl(this.remoteDataSource);
//
//   @override
//   Future<Either<Failure, String>> loginWithEmailPassword({
//     required String email,
//     required String password,
//   }) {
//     // TODO: implement loginWithEmailPassword
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<Either<Failure, String>> signUpWithEmailPassword({
//     required String name,
//     required String email,
//     required String password,
//   }) async {
//     try {
//       print('Signing up user with email: $email');
//       final userId = await remoteDataSource.signUpWithEmailPassword(
//         name: name,
//         email: email,
//         password: password,
//       );
//
//       return right(userId);
//     } on ServerException catch (e) {
//       return left(Failure(e.message));
//       // return left(Failure(message: e.message));
//     }
//   }
// }

import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  const AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, String>> loginWithEmailPassword({
    required String email,
    required String password,
  }) {
    // Implementation for loginWithEmailPassword would go here
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // Logging request data
      print('auth_repository_impl.dart');
      print(name);
      print(email);
      print(password);
      print('Attempting to sign up user with email: $email');

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
