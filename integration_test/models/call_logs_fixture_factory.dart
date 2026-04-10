import 'package:webtrit_phone/models/models.dart';

typedef NewCall = ({
  CallDirection direction,
  String number,
  bool video,
  String? username,
  DateTime createdTime,
  DateTime? acceptedTime,
  DateTime? hungUpTime,
});

class CallLogsFixtureFactory {
  static NewCall createCall(int index, String number) {
    return (
      direction: index.isEven ? CallDirection.incoming : CallDirection.outgoing,
      number: number,
      video: false,
      username: 'User $index',
      createdTime: DateTime.now(),
      acceptedTime: DateTime.now().add(const Duration(seconds: 1)),
      hungUpTime: DateTime.now().add(const Duration(minutes: 1)),
    );
  }
}
