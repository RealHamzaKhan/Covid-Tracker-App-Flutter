import 'dart:async';
import 'dart:math' as math;

import 'package:covid_tracker_app/screens/worldstatesscreen.dart';
import 'package:flutter/material.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _controller=AnimationController(vsync: this,
  duration: Duration(seconds: 3))..repeat();
  @override
  void initState() {
    Timer(Duration(seconds: 5), () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>WorldStatesScreen()));
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
                builder: (BuildContext context,Widget? child){
                  return Transform.rotate(
                      angle: _controller.value * 2.0*math.pi,
                  child: child,);
                },
              child: Container(
                height: 200,
                width: 200,
                child: Center(child: Image.asset('images/virus.png')),
              ),),
            SizedBox(height: 40,),
            Text('Covid-19\nTracking App',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,),textAlign: TextAlign.center,)
          ],
        ),
      ),
    );
  }
}
