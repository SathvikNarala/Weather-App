part of 'app_bloc.dart';

@immutable
abstract class AppState {
  final bool loading;
  final String temparature;
  final String condition;
  final String icon;
  final String cityName;

  const AppState({
    required this.loading,
    required this.temparature,
    required this.condition,
    required this.icon,
    required this.cityName,
  });
}

class AppInitial extends AppState {
  const AppInitial() : super(
    loading: true,
    temparature: '--',
    condition: 'Loading',
    icon: '',
    cityName: 'Phone'
  );
}

class AppSuccess extends AppState{
  const AppSuccess({
    required String temp, 
    required String msg,
    required String icon,
    required String city
  }) : super(
    loading: false, 
    temparature: temp,
    condition: msg,
    icon: icon,
    cityName: city
  );
}

class AppError extends AppState{
  const AppError() : super(
    loading: false,
    temparature: '--',
    condition: 'Unable to get Weather Data',
    icon: '❌',
    cityName: ''
  );
}