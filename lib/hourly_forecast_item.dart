import 'package:flutter/material.dart';
class HourlyForecastItem extends StatelessWidget{
  final String time;
  final String temperature;
  final IconData icon;
  const HourlyForecastItem({super.key,
    required this.time,
    required this. temperature,
    required this. icon,

  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,

      child: Container(
        width: 100,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
        ),
        child:const Column(
          children: [
            Text('03.00',
              style:TextStyle(fontSize: 16,
                  fontWeight: FontWeight.bold) ,),
            SizedBox(height: 8),
            Icon(
              Icons.cloud,size: 32,),
            SizedBox(height: 8),
            Text(
                '320.20'
            )
          ],
        ) ,
      ),
    );
  }
}
