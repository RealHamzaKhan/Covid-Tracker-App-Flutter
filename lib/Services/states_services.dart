import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:covid_tracker_app/Services/utilities/app_url.dart';
import 'package:covid_tracker_app/Models/WorldStatesModel.dart';
class StatesServices{
  Future<WorldStatesModel> fetchWorldStatesData()async{
    final response=await http.get(Uri.parse(AppUrls.worldurl));
    var data=jsonDecode(response.body);
    if(response.statusCode==200)
      {
        return WorldStatesModel.fromJson(data);
      }
    else{
      throw Exception('Error');
    }
  }
  Future<List<dynamic>> fetchCountriesStatesData()async{
    final response=await http.get(Uri.parse(AppUrls.countrieslist));
    var data=jsonDecode(response.body);
    if(response.statusCode==200)
    {
      return data;
    }
    else{
      throw Exception('Error');
    }
  }
}