import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:webtrit_phone/theme/styles/styles.dart';

extension MaskTextInputFormatterConfig on MaskTextInputFormatter {
  void updateFromConfig(InputMaskStyle? config) {
    if (config?.pattern != null) {
      updateMask(mask: config!.pattern, filter: config.filter?.map((key, value) => MapEntry(key, RegExp(value))));
    }
  }
}
