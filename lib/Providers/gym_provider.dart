

import 'dart:developer';

import 'package:assignment_wtf/services/service_for_gym_data.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../services/fetch_gym.dart';
import '../util/get_location.dart';

class GymProvider with ChangeNotifier{
  List<GymData> allGym=[];
  String? gymPlace;
  String? gymLcality;

  setGymList(List<GymData> list){
    allGym=list;
    notifyListeners(); 
  }

  setLocation(String place, String localaty){
    gymPlace=place;
    gymLcality=localaty;
    notifyListeners();
  }
}