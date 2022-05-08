import 'package:flutter/material.dart';

import 'package:webtrit_phone/styles/styles.dart';

class ListTileSeparator extends StatelessWidget {
  const ListTileSeparator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1,
      indent: 15,
      endIndent: 15,
      color: AppColors.lightGrey,
    );
  }
}
