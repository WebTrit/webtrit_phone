import 'package:bloc/bloc.dart';
import 'package:stream_transform/stream_transform.dart';

import 'package:webtrit_phone/app/constants.dart';

EventTransformer<Event> debounce<Event>([Duration duration = kDebounceDuration]) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}
