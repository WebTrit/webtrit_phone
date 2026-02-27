import 'package:equatable/equatable.dart';

import 'contact.dart';

enum FavoriteSourceType { device, pbx }

class Favorite extends Equatable {
  const Favorite({
    required this.number,
    required this.sourceType,
    required this.sourceId,
    required this.label,
    required this.position,
  });

  final String number;
  final FavoriteSourceType sourceType;
  final String sourceId;
  final String label;
  final int position;

  @override
  List<Object?> get props => [number, sourceType, sourceId, label, position];

  @override
  String toString() {
    return 'Favorite(number: $number, sourceType: $sourceType, sourceId: $sourceId, label: $label, position: $position)';
  }
}

typedef FavoriteWithContact = ({Favorite favorite, Contact? contact});
