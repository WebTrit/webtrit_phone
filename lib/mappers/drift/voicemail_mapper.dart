import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

mixin VoicemailMapper {
  VoicemailData voicemailToDrift(
    UserVoicemailItem userVoicemailItem,
    UserVoicemail userVoicemailDetails,
    String attachmentUrl,
  ) {
    final voicemail = VoicemailData(
      id: userVoicemailItem.id,
      date: userVoicemailItem.date,
      duration: userVoicemailItem.duration,
      sender: userVoicemailDetails.sender,
      receiver: userVoicemailDetails.receiver,
      seen: userVoicemailItem.seen,
      size: userVoicemailItem.size,
      type: userVoicemailItem.type,
      attachmentPath: attachmentUrl,
    );

    return voicemail;
  }

  Voicemail voicemailFromDrift(VoicemailData voicemailData, String? contactName) {
    return Voicemail(
      voicemailData.id,
      voicemailData.date,
      voicemailData.duration,
      voicemailData.sender,
      contactName ?? voicemailData.sender,
      voicemailData.receiver,
      voicemailData.seen,
      voicemailData.size,
      voicemailData.type,
      voicemailData.attachmentPath,
    );
  }
}
