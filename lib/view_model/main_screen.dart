import 'dart:developer';


import 'package:assignment_wtf/Providers/gym_provider.dart';

import 'package:assignment_wtf/const/constants.dart';
import 'package:assignment_wtf/services/fetch_gym.dart';
import 'package:assignment_wtf/services/service_for_gym_data.dart';
import 'package:assignment_wtf/util/get_location.dart';
import 'package:assignment_wtf/view_model/location_screen.dart';
import 'package:assignment_wtf/widgets/main_card.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
    String? _place="Noida";
    String? _locality="Sector 10";
    int selectedIndex=0;
    List<String> cities=[];
    List<GymData> _gymData=[];

  
  @override
  void initState() {
    fetch_gym().getGymCities().then((value) {
      cities=value;
    });
    getAllGyms();
    super.initState();
  }


List<GymData> filteredGym=[];

String? filterSelected;
filterSearchedGym(String val,String filterSelected){
List<GymData> allGyms= [..._gymData];
filteredGym=allGyms;

filteredGym.removeWhere((element) => !(element.gymName!.toLowerCase().contains(val.toLowerCase())));
filteredGym.removeWhere((element) => !(element.gymType==filterSelected));
}




  getAllGyms(){
    Util().determinePosition().then((value) {
      _getAddressFromLatLng(value);
      fetch_gym().getGyms(value.latitude.toString(), value.longitude.toString(), "10", "1").then((value) {
       final gymProvider = Provider.of<GymProvider>(context,listen: false);
       setState(() {
       });
       gymProvider.setGymList(value);
       _gymData=value;
       filteredGym=_gymData;
      });
    });
  }
    Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            position!.latitude, position!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        
      });
        _place ='${place.subAdministrativeArea}';
        _locality='${place.locality}';
        log(place.subAdministrativeArea.toString());
    }).catchError((e) {
      debugPrint(e);
    });
  }


 filterGyms(String type){

List<GymData> allGyms= [..._gymData];

filteredGym=allGyms;
if(type=="All")
return;

filteredGym.removeWhere((element) => !(element.gymType==type));
}
 


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(elevation: 0,
    leadingWidth: Get.width*.1,
    title: InkWell(
      onTap: () {
        Get.to(LocationScreen(cities: cities,));
      },
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
            Icon(MdiIcons.mapMarker,size: 10),
            Text(_place!,style: TextStyle(fontSize: 10),)
          ],),
          Text(_locality!,style: TextStyle(fontSize: 10),)
          
        ],
      ),
    ),
      centerTitle: true,
      backgroundColor: Colors.white,leading: Icon(MdiIcons.arrowLeftBoldBoxOutline)),body: SingleChildScrollView(
        child: SafeArea(child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (val){
                filterSearchedGym(val,filterSelected!);
                setState(() {
                  
                });
              },
              decoration: InputDecoration(
                enabledBorder:OutlineInputBorder(borderSide: BorderSide(color:Color.fromARGB(255, 222, 220, 220)),borderRadius: BorderRadius.circular(30)),
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
          ),
          hintText: 'Search by gym name',
          hintStyle: TextStyle(color: Colors.grey),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Color.fromARGB(255, 222, 220, 220)),borderRadius: BorderRadius.circular(30)),
          fillColor: Color.fromARGB(255, 222, 220, 220),filled: true,suffixIcon: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(child: Icon(MdiIcons.magnify,color: Colors.white,),padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),decoration: BoxDecoration(color: Colors.orange,borderRadius: BorderRadius.circular(20))),
          )),),
          ),
      
          Container(
            height: Get.height*.05,
            width: Get.width,
            child: ListView.builder(
              itemCount: gymType.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx,index){
              var key= gymType.keys.elementAt(index);
             return Padding(
               padding: const EdgeInsets.symmetric(horizontal: 5),
               child: InkWell(
                onTap: (){
                  setState(() {
                     selectedIndex=index;
                     filterGyms(key);
                     filterSelected=key;
                  });
                },
                 child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(),color: selectedIndex==index?Colors.black:Colors.white,),
                  child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: selectedIndex==index?Text(gymType[key]!,style: TextStyle(color: Colors.white),):Text(gymType[key]!,style: TextStyle(color: Colors.black),),
                  ),
                 ),
               ),
             );
            }),
            
          ),
          SizedBox(height: Get.height*.03,),
           Container(
            height: Get.height*.7,
            width: Get.width,
             child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: filteredGym.length,
              itemBuilder: (ctx,index){
            return  MainCard(filteredGym[index]);
              
              }),
           )
        ],),),
      ),);
  }
}