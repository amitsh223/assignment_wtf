import 'dart:convert';
import 'dart:developer';


import 'package:assignment_wtf/const/constants.dart' as constant;
import 'package:assignment_wtf/services/service_for_gym_data.dart';
import 'package:http/http.dart' as http;
class fetch_gym{

Future<List<String>> getGymCities()async{
   String token = constant.token;
    final response = await http.get(Uri.parse(constant.urlForCities), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if(response.statusCode==200){
      List<String>? cities=[];
    Map data=json.decode(response.body);
    if(data['data']!=null){
      log(data['data'].toString());
      ((data['data'][0] as Map)['popular_locations'] as List ).forEach((element) {
        cities.add(element['location']);
       });

       return cities;
    }

  
  
    }
    return [];
}

Future<List<GymData>> getGyms(String lat,String long,String limit,String page)async{
  String token = constant.token;
    final response = await http.get(Uri.parse("https://devapi.wtfup.me/gym/nearestgym/new?page=$page&limit=$limit&lat=$lat&long=$long"), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if(response.statusCode==200){
      List<GymData> list=[];
    Map data=json.decode(response.body);
    
      if(data["status"]){
        (data["data"] as List).forEach((value) {
          list.add(GymData(gymName: value["gym_name"],city: value["city"],lat: value["lat"],long: value["long"],distance: value["distance"],gymType: value['category_name']));
         });
      }
     
    return list;
    }
    return [];
    }

}