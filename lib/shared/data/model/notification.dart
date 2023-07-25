import 'package:realm/realm.dart';
part 'notification.g.dart';

@RealmModel()
class _Notification {
  @PrimaryKey()
  late String id;
  late String title;
  late String description;
  String? deepLink;
  late bool isSeen;
}
