import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SunriseSunsetWidget extends StatelessWidget{
  final int sunrise;
  final int sunset;

  const SunriseSunsetWidget({Key? key, required this.sunrise, required this.sunset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSunInfo(Icons.wb_sunny, 'Sunrise', DateTime.fromMillisecondsSinceEpoch(sunrise * 1000)),
          _buildSunInfo(Icons.nights_stay, 'Sunset', DateTime.fromMillisecondsSinceEpoch(sunset * 1000)),
        ],
      ),
    );
  }

  Widget _buildSunInfo(IconData icon, String label, DateTime time){
    return Column(
      children: [
        Icon(icon, color: Colors.white,),
        const SizedBox(height: 5,),
        Text(label, style: TextStyle(color: Colors.white70),),
        Text(
          DateFormat('h:mm a').format(time),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
        )
      ],
    );
  }
}