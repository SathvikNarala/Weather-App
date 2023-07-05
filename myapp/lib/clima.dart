import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/app_bloc.dart';
import 'model.dart';
import 'city.dart';

class Clima extends StatefulWidget {
  const Clima({super.key});

  @override
  State<Clima> createState() => _ClimaState();
}

class _ClimaState extends State<Clima> {

  // WeatherModel model = WeatherModel();

  // bool _loading = false;

  // String _temparature = '--';
  // String _condition = 'Loading';
  // String _icon = '';
  // String _cityName = 'Phone';

  // void _fetch([String city = '']) async{
  //   Data data = await Location.getCurrentLocation(city);
    
  //   setState(() {
  //     if(data.city == ''){
  //       _condition = 'Unable to get Weather Data';
  //       _icon = '❌';
  //     }
  //     else{
  //       _temparature = data.temparature.toString();
  //       _condition = model.getMessage(data.temparature);
  //       _icon = model.getWeatherIcon(data.weatherid);
  //     }

  //     _cityName = data.city;
  //     _loading = false;
  //   });
  // }

  @override
  void initState(){
    super.initState();
    init() => context.read<AppBloc>().add(LocationEvent());
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Climate'),
        ),
      ),

      resizeToAvoidBottomInset: false,
      
      body: BlocBuilder<AppBloc, AppState>(
        builder: (context, state){
          return state.loading ? const Center(
            child: CircularProgressIndicator(),
          ):
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/location_background.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.8), BlendMode.dstATop),
              ),
            ),
            constraints: const BoxConstraints.expand(),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          context.read<AppBloc>().add(LocationEvent()); // _fetch();
                        },
                        child: const Icon(
                          Icons.near_me,
                          size: 50.0,
                        ),
                      ),
              
                      TextButton(
                        onPressed: () async{
                          String city = await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const City()
                            )
                          );
              
                          // _fetch(city);
                          if(context.mounted){
                            context.read<AppBloc>().add(CityEvent(city));
                          }
                        },
                        child: const Icon(
                          Icons.location_city,
                          size: 50.0,
                        ),
                      ),
                    ],
                  ),
              
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${state.temparature}°c',
                          style: kTempTextStyle,
                        ),
              
                        Text(
                          state.icon,
                          style: kConditionTextStyle,
                        ),
                      ],
                    ),
                  ),
              
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text(
                      "${state.condition} in ${state.cityName}!",
                      textAlign: TextAlign.center,
                      style: kMessageTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

