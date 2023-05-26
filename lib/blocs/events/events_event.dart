part of 'events_bloc.dart';

@immutable
abstract class EventsEvent extends Equatable{
  const EventsEvent();

  @override
  List <Object> get props => [];
}

class LoadEvents extends EventsEvent {

  @override
  List <Object> get props => [];
}

class SearchEvents extends EventsEvent {
  String searchTerm;

  SearchEvents({required this.searchTerm});
  @override
  List <Object> get props => [];
}

class EventDetails extends EventsEvent{

  @override
  List <Object> get props => [];
}