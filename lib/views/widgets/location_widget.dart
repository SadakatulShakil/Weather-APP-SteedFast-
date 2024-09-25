import 'package:flutter/material.dart';

class LocationWidget extends StatelessWidget{
  final String cityName;

  const LocationWidget({Key? key, required this.cityName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Column(
     children: [
       Row(
         children: [
           Icon(Icons.location_on, color: Colors.white,),
           SizedBox(width: 10,),
           Text(
             cityName,
             style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
           ),
         ],
       ),
     ],
   );
  }
}