import 'package:webtrit_phone/data/data.dart';

class VoicemailsFixtureFactory {
  static VoicemailData createVoicemail({
    String id = '',
    String date = '',
    double duration = 0.0,
    String sender = '',
    String displaySender = '',
    String receiver = '',
    bool seen = false,
    int size = 0,
    String type = '',
    String? attachmentPath,
  }) {
    return VoicemailData(
      id: id,
      date: date,
      duration: duration,
      sender: sender,
      receiver: receiver,
      seen: seen,
      size: size,
      type: type,
      attachmentPath: attachmentPath,
    );
  }
}
