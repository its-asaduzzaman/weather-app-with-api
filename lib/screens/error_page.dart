import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Text("Error", style: TextStyle(
          fontSize: 30.0
        ),),),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.2), BlendMode.dstATop),

          ),
        ),
        constraints: BoxConstraints.expand(),
      ),
    );
  }
}
