import 'dart:ffi';

import 'package:covid_tracker_app/screens/worldstatesscreen.dart';
import 'package:flutter/material.dart';
class CountryDetails extends StatefulWidget {
  String name,image;
  int cases,active,recovered,deaths,todaydeaths,todayrecovered,todaycases,critical,totalpopulation;
  CountryDetails({
    required this.name,
    required this.cases,
    required this.active,
    required this.recovered,
    required this.deaths,
    required this.image,
    required this.todaycases,
    required this.todaydeaths,
    required this.todayrecovered,
    required this.totalpopulation,
    required this.critical,
  });
  @override
  State<CountryDetails> createState() => _CountryDetailsState();
}

class _CountryDetailsState extends State<CountryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.07,),
           Stack(
             alignment: Alignment.topCenter,
             children: [
               Padding(
                 padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*.065),
                 child: Card(
                   child: Column(
                     children: [
                       SizedBox(height: 70,),
                       ReusableRow(title: 'Total population', value: widget.totalpopulation.toString()),
                       ReusableRow(title: 'Total cases', value: widget.cases.toString()),
                       ReusableRow(title: 'Active cases', value: widget.active.toString()),
                       ReusableRow(title: 'Today cases', value: widget.todaycases.toString()),
                       ReusableRow(title: 'Recovered', value: widget.recovered.toString()),
                       ReusableRow(title: 'Today recovered', value: widget.todayrecovered.toString()),
                       ReusableRow(title: 'Critical', value: widget.critical.toString()),
                       ReusableRow(title: 'Deaths', value: widget.deaths.toString()),
                       ReusableRow(title: 'Today deaths', value: widget.todaydeaths.toString()),
                     ],
                   ),
                 ),
               ),
               CircleAvatar(
                 backgroundImage: NetworkImage(widget.image),
                 radius: 55,
               ),
             ],
           ),
          ],
        ),
      ),
    );
  }
}
