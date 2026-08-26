part of 'contacts_favorites_tab_bloc.dart';

sealed class ContactsFavoritesTabEvent extends Equatable {
  const ContactsFavoritesTabEvent();

  @override
  List<Object?> get props => [];
}

class ContactsFavoritesTabStarted extends ContactsFavoritesTabEvent {
  const ContactsFavoritesTabStarted({required this.search});

  final String search;

  @override
  List<Object?> get props => [search];
}
