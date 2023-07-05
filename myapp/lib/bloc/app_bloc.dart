import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../backend.dart';
import '../model.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppInitial()) {
    WeatherModel model = WeatherModel();

    on<LocationEvent>((event, emit) async{
      Data data = await Location.getCurrentLocation('');

      if(data.city == ''){
        emit(const AppError());
      }
      
      emit(
        AppSuccess(
          temp: data.temparature.toString(), 
          msg: model.getMessage(data.temparature), 
          icon: model.getWeatherIcon(data.weatherid), 
          city: data.city
        )
      );
    });

    on<CityEvent>((event, emit) async{
      Data data = await Location.getCurrentLocation('');

      if(data.city == ''){
        emit(const AppError());
      }
      
      emit(
        AppSuccess(
          temp: data.temparature.toString(), 
          msg: model.getMessage(data.temparature), 
          icon: model.getWeatherIcon(data.weatherid), 
          city: data.city
        )
      );
    });
  }
}
