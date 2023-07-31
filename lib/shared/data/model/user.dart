import 'package:isar/isar.dart';

part 'user.g.dart';

@collection
class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    this.profilePicture,
  });

  @Id()
  final String id;
  final String name;
  final String email;
  final String? profilePicture;
}
