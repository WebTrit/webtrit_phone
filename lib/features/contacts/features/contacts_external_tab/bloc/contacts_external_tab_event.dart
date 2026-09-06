part of 'contacts_external_tab_bloc.dart';

sealed class ContactsExternalTabEvent extends Equatable {
  const ContactsExternalTabEvent();

  @override
  List<Object?> get props => [];
}

class ContactsExternalTabStarted extends ContactsExternalTabEvent {
  const ContactsExternalTabStarted({required this.search});

  final String search;

  @override
  List<Object?> get props => [search];
}

final class _ContactsExternalTabRefreshRequested extends ContactsExternalTabEvent {
  _ContactsExternalTabRefreshRequested();

  final _completed = Completer<bool>();

  Future<bool> get completed => _completed.future;

  void complete({required bool succeeded}) {
    if (!_completed.isCompleted) {
      _completed.complete(succeeded);
    }
  }

  @override
  List<Object?> get props => [_completed];
}
