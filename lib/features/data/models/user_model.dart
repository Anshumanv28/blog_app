import 'package:blog_app/features/domain/entities/user.dart';

class UserModel extends User {
  //extending from the User entity for seperation of concerns

  UserModel({required super.name, required super.email, required super.id});

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      id: map['id'] ?? '',
    );
  }
}
