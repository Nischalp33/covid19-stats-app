import 'dart:convert';

import 'package:covid_tracker/Model/WorldStatesModel.dart';
import 'package:http/http.dart' as http;

import '../Model/CountryModel.dart';
import 'Utilities/app_url.dart';

class StatesServices{
  Future<WorldStatesModel> fetchWorldStatesRecords()async{
    final response = await http.get(Uri.parse(AppUrl.worldStateApi));
  if(response.statusCode == 200){
    var data = jsonDecode(response.body);

    return WorldStatesModel.fromJson(data);

  }else{
    throw Exception('error');

  }

  }
  List<CountryModel> countryList = [];
  Future<List<CountryModel>> countriesListApi()async{
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for(Map i in data){
        countryList.add(CountryModel.fromJson(i));
      }

      return countryList;

    }else{
      throw Exception('error');

    }

  }



}