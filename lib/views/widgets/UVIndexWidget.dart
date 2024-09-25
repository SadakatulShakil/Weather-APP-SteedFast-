import 'package:flutter/material.dart';

class UVIndexWidget extends StatelessWidget{
  final int uvIndex;

  const UVIndexWidget({Key? key, required this.uvIndex}) : super(key: key);

  String _getUVDescription(int index){
    if(index <= 2) return 'LOW';
    if(index <= 5) return 'Moderate';
    if(index <= 7) return 'High';
    if(index <= 10) return 'Very High';
    return 'Extreme';
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.wb_sunny_outlined, color: Colors.white, size: 30,),
          const SizedBox(width: 15,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('UV Index', style: TextStyle(color: Colors.white70)),
              Text(
                '$uvIndex ${_getUVDescription(uvIndex)}',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)
              )
            ],
          )
        ],
      ),
    );
  }
}