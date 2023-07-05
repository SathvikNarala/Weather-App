import 'package:flutter/material.dart';
import 'backend.dart';
import 'model.dart';
import 'city.dart';

class Clima extends StatefulWidget {
  const Clima({super.key});

  @override
  State<Clima> createState() => _ClimaState();
}

class _ClimaState extends State<Clima> {

  WeatherModel model = WeatherModel();

  bool _loading = false;

  String _temparature = '--';
  String _condition = 'Loading';
  String _icon = '';
  String _cityName = 'Phone';

  void _fetch([String city = '']) async{
    Data data = await Location.getCurrentLocation(city);
    
    setState(() {
      if(data.city == ''){
        _condition = 'Unable to get Weather Data';
        _icon = '❌';
      }
      else{
        _temparature = data.temparature.toString();
        _condition = model.getMessage(data.temparature);
        _icon = model.getWeatherIcon(data.weatherid);
      }

      _cityName = data.city;
      _loading = false;
    });
  }

  @override
  void initState(){
    super.initState();
    _fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Climate'),
        ),
      ),

      body: _loading ? const Center(
        child: CircularProgressIndicator()
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      _fetch();
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

                      _fetch(city);
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
                  children: [
                    Text(
                      '$_temparature°c ',
                      style: kTempTextStyle,
                    ),

                    Text(
                      _icon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  "$_condition in $_cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

