import 'package:realm/realm.dart';
part 'user.g.dart';

@RealmModel()
class _User {
  @PrimaryKey()
  late String id;
  late String name;
  late String email;
  late String? profilePicture;
}
