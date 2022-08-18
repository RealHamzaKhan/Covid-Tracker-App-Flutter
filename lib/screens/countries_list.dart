import 'package:covid_tracker_app/Services/states_services.dart';
import 'package:covid_tracker_app/screens/country_details.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class CountryList extends StatefulWidget {
  const CountryList({Key? key}) : super(key: key);

  @override
  State<CountryList> createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  StatesServices statesServices=StatesServices();
  TextEditingController searchcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  onChanged: (value){
                    setState(() {

                    });
                  },
                  controller: searchcontroller,
                  decoration: InputDecoration(
                    hintText: 'Search for country',
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                    future: statesServices.fetchCountriesStatesData(),
                    builder: (context,AsyncSnapshot<List<dynamic>>snapshot){
                      if(!snapshot.hasData){
                        return ListView.builder(
                            itemBuilder: (context,index){
                              return Shimmer.fromColors(
                                baseColor: Colors.grey.shade700,
                                highlightColor: Colors.grey.shade100,
                                child: ListTile(
                                  leading: Container(color: Colors.white,height: 50,width: 50,),
                                  title: Container(color: Colors.white,height: 10,width: 89,),
                                  subtitle: Container(color: Colors.white,height: 10,width: 89,),
                                ),
                              );
                            });
                      }
                      else{
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder:(context,index){
                              String name=snapshot.data![index]['country'];
                              if(searchcontroller.text.isEmpty)
                                {
                                  return InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context){
                                        return CountryDetails(
                                            name: snapshot.data![index]['country'],
                                            cases: snapshot.data![index]['cases'],
                                            active: snapshot.data![index]['active'],
                                            recovered: snapshot.data![index]['recovered'],
                                            deaths: snapshot.data![index]['deaths'],
                                            image: snapshot.data![index]['countryInfo']['flag'],
                                            todaycases: snapshot.data![index]['todayCases'],
                                            todaydeaths: snapshot.data![index]['todayDeaths'],
                                            todayrecovered: snapshot.data![index]['todayRecovered'],
                                            totalpopulation: snapshot.data![index]['population'],
                                            critical: snapshot.data![index]['critical'],
                                        );
                                      }));
                                    },
                                    child: ListTile(
                                      leading: Image(image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),height: 70,width: 70,),
                                      title: Text(snapshot.data![index]['country']),
                                      subtitle: Text(snapshot.data![index]['cases'].toString()),
                                    ),
                                  );
                                }
                              else if(name.toLowerCase().contains(searchcontroller.text.toLowerCase()))
                                {
                                  return InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context){
                                        return CountryDetails(
                                          name: snapshot.data![index]['country'],
                                          cases: snapshot.data![index]['cases'],
                                          active: snapshot.data![index]['active'],
                                          recovered: snapshot.data![index]['recovered'],
                                          deaths: snapshot.data![index]['deaths'],
                                          image: snapshot.data![index]['countryInfo']['flag'],
                                          todaycases: snapshot.data![index]['todayCases'],
                                          todaydeaths: snapshot.data![index]['todayDeaths'],
                                          todayrecovered: snapshot.data![index]['todayRecovered'],
                                          totalpopulation: snapshot.data![index]['population'],
                                          critical: snapshot.data![index]['critical'],
                                        );
                                      }));
                                    },
                                    child: ListTile(
                                      leading: Image(image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),height: 70,width: 70,),
                                      title: Text(snapshot.data![index]['country']),
                                      subtitle: Text(snapshot.data![index]['cases'].toString()),
                                    ),
                                  );
                                }
                              else{
                                return Container();

                              }
                              return ListTile(
                                leading: Image(image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),height: 70,width: 70,),
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(snapshot.data![index]['cases'].toString()),
                              );
                            });
                      }
                    }),
              )
            ],
          ),
      ),
    );
  }
}
