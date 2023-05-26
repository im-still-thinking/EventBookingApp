part of 'events_bloc.dart';

@immutable
abstract class EventsState extends Equatable {
  const EventsState();

  @override
  List<Object> get props => [];
}

class EventsLoading extends EventsState {}

class EventsLoaded extends EventsState {
  final List<Event> events;

  const EventsLoaded({required this.events});

  @override
  List<Object> get props => [events];
}

class EventsError extends EventsState {
  final String error;
  const EventsError(this.error);

  @override
  List<Object> get props => [error];
}



class SearchLoading extends EventsState{}

class SearchLoaded extends EventsState{
  final List<Event> events;

  const SearchLoaded({required this.events});

  @override
  List<Object> get props => [events];
}

class SearchError extends EventsState{
  final String error;
  const SearchError(this.error);

  @override
  List<Object> get props => [error];
}
