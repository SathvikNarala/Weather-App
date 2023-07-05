part of 'app_bloc.dart';

@immutable
abstract class AppEvent {}

class LocationEvent extends AppEvent{}

class CityEvent extends AppEvent{
  final String city;

  CityEvent(this.city);
}