import 'package:covid_tracker_app/Models/WorldStatesModel.dart';
import 'package:covid_tracker_app/Services/states_services.dart';
import 'package:covid_tracker_app/screens/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen> with TickerProviderStateMixin{
  late final AnimationController _controller=AnimationController(vsync: this,
  duration: const Duration(seconds: 3))..repeat();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  final colorList= <Color> [
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];
  StatesServices statesServices=StatesServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child:Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                FutureBuilder(
                  future: statesServices.fetchWorldStatesData(),
                    builder:(context,AsyncSnapshot<WorldStatesModel>snapshot)
                        {
                          if(!snapshot.hasData){
                            return Expanded(
                              flex: 1,
                              child: SpinKitFadingCircle(
                                color: Colors.white,
                                controller: _controller,
                              ),
                            );
                          }
                          else{
                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  PieChart(
                                    chartValuesOptions: const ChartValuesOptions(
                                      showChartValuesInPercentage: true,
                                    ),
                                      chartType: ChartType.ring,
                                      ringStrokeWidth: 20,
                                      animationDuration: const Duration(milliseconds: 1200),
                                      colorList: colorList,
                                      chartRadius: MediaQuery.of(context).size.width/3.2,
                                      legendOptions: const LegendOptions(
                                        legendPosition: LegendPosition.right,
                                      ),
                                      dataMap: {
                                        "Total Cases":double.parse(snapshot.data!.cases.toString()),
                                        "Recovered":double.parse(snapshot.data!.recovered.toString()),
                                        "Deaths":double.parse(snapshot.data!.deaths.toString()),
                                      }
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Card(
                                      child: Column(
                                        children: [
                                          ReusableRow(title: 'Total cases', value: snapshot.data!.cases.toString()),
                                          ReusableRow(title: 'Today cases', value: snapshot.data!.todayCases.toString()),
                                          ReusableRow(title: 'Active cases', value: snapshot.data!.active.toString()),
                                          ReusableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                                          ReusableRow(title: 'Today recovered', value: snapshot.data!.todayRecovered.toString()),
                                          ReusableRow(title: 'Total deaths', value: snapshot.data!.deaths.toString()),
                                          ReusableRow(title: 'Today deaths', value: snapshot.data!.todayDeaths.toString()),
                                          ReusableRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CountryList()));
                                    },
                                    child: Container(
                                      height: MediaQuery.of(context).size.height*0.08,
                                      width: MediaQuery.of(context).size.width*0.85,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Center(child: Text('Track countries'),),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        }
                ),
              ],
            ),
          ), ),
    );
  }
}
class ReusableRow extends StatelessWidget {
  String title,value;
  ReusableRow({Key? key,required this.title,required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const Divider(),

        ],
      ),
    );
  }
}

