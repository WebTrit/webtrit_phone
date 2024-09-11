// // // import 'package:flutter/material.dart';
// // // import 'package:webtrit_phone/l10n/l10n.dart';
// // // import '../models/flavor.dart';
// // // import '../models/main_flavor.dart';
// // //
// // // extension MainFlavorLabelL10n on Flavor {
// // //   String labelL10n(BuildContext context) {
// // //     if (this is FavoritesFlavor) {
// // //       return context.l10n.main_BottomNavigationBarItemLabel_favorites;
// // //     } else if (this is RecentsFlavor) {
// // //       return context.l10n.main_BottomNavigationBarItemLabel_recents;
// // //     } else if (this is ContactsFlavor) {
// // //       return context.l10n.main_BottomNavigationBarItemLabel_contacts;
// // //     } else if (this is KeypadFlavor) {
// // //       return context.l10n.main_BottomNavigationBarItemLabel_keypad;
// // //     } else if (this is EmbeddedFlavor) {
// // //       return (this as EmbeddedFlavor).embeddedData.title;
// // //     } else {
// // //       return '';
// // //     }
// // //   }
// // // }
// // //
// // import 'package:flutter/material.dart';
// //
// import 'package:flutter/material.dart';
//
// extension MainFlavorIcon on Flavor {
//   IconData get icon {
//     if (this is FavoritesFlavor) {
//       return Icons.star_outline;
//     } else if (this is RecentsFlavor) {
//       return Icons.access_time;
//     } else if (this is ContactsFlavor) {
//       return Icons.account_circle_outlined;
//     } else if (this is KeypadFlavor) {
//       return Icons.dialpad;
//     } else if (this is EmbeddedFlavor) {
//       return (this as EmbeddedFlavor).embeddedData.icon ?? Icons.help_outline;
//     } else {
//       return Icons.help_outline;
//     }
//   }
// }
