import 'package:flutter/material.dart';
import 'model.dart';

class City extends StatefulWidget {
  const City({super.key});

  @override
  State<City> createState() => _CityState();
}

class _CityState extends State<City> {
  String city = '';

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Climate'),
          ),
          automaticallyImplyLeading: false,
        ),
        
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/city_background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          constraints: const BoxConstraints.expand(),
          child: SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop('');
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      size: 50.0,
                    ),
                  ),
                ),
      
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    style: const TextStyle(
                      color: Colors.black
                    ),
                    decoration: kTextFieldInputDecoration,
                    onChanged: (value) {
                      city = value;
                    },
                  ),
                ),
      
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(city);
                  },
                  child: const Text(
                    'Get Weather',
                    style: kButtonTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
