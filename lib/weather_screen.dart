import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app/additional_info_item.dart';
import 'package:weather_app/secrets.dart';
import 'hourly_forecast_item.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  double temp = 0;
  bool isLoading = false;
  Future getCurrentWeather() async {

    try{
      setState(() {
        isLoading = true;
      });
      String cityName = 'London';

      final res = await http.get(
        Uri.parse('http://api.openweathermap.org/data/2.5/forecast?q=$cityName,uk&APPID=$openweatherAPIKey'),
      );
   final data =  jsonDecode(res.body) ;
   if(data['cod']!='200'){
     throw 'An unexpected error occurred';

   }
   setState(() {

     temp = data['list'][0]['main']['temp'];
     isLoading = false;
   });

    } catch (e){
      throw e.toString();

    }


  }

  @override
  void initState() {
    super.initState();
    print('initState');
    getCurrentWeather(); // call API when screen loads
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: getCurrentWeather, // refresh on button click
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body:isLoading?
      const CircularProgressIndicator():
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // main card
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child:  Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            '$temp K',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          Icon(
                            Icons.cloud,
                            size: 65,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Rain',
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Weather Forecast',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: const [
                  HourlyForecastItem(
                    time: '03.00',
                    temperature: '320.20',
                    icon: Icons.cloud,
                  ),
                  HourlyForecastItem(
                    time: '04.00',
                    temperature: '318.50',
                    icon: Icons.sunny,
                  ),
                  HourlyForecastItem(
                    time: '05.00',
                    temperature: '317.90',
                    icon: Icons.cloud,
                  ),
                  HourlyForecastItem(
                    time: '06.00',
                    temperature: '319.80',
                    icon: Icons.sunny,
                  ),
                  HourlyForecastItem(
                    time: '07.00',
                    temperature: '321.00',
                    icon: Icons.cloud,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Additional Information',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                AdditionalInfoItem(
                  icon: Icons.water_drop,
                  label: 'Humidity',
                  value: '91',
                ),
                AdditionalInfoItem(
                  icon: Icons.air,
                  label: 'Wind Speed',
                  value: '9',
                ),
                AdditionalInfoItem(
                  icon: Icons.beach_access,
                  label: 'Pressure',
                  value: '100',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
