import 'dart:developer';
import 'package:assignment_wtf/const/list_constant.dart';
import 'package:assignment_wtf/controllers/homepage_controller.dart';
import 'package:assignment_wtf/util/get_location.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
    String? _place;
    String? _locality;
    int selectedIndex=0;

     HomePageController controller = Get.put(HomePageController());

  
  @override
  void initState() {
    Util().determinePosition().then((value) {
     _getAddressFromLatLng(value);
    });
    super.initState();
  }
   Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            position!.latitude, position!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
        controller.place.value ='${place.subAdministrativeArea}';
        controller.locality.value='${place.locality}';
        log(place.subAdministrativeArea.toString());
    }).catchError((e) {
      debugPrint(e);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(elevation: 0,
    leadingWidth: Get.width*.1,
    title: Column(
    mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
          Icon(MdiIcons.mapMarker,size: 10),
          Obx(() =>  Text(controller.place.value,style: TextStyle(fontSize: 10),))
        ],),
        Obx(() =>Text(controller.locality.value,style: TextStyle(fontSize: 10),))
        
      ],
    ),
      centerTitle: true,
      backgroundColor: Colors.white,leading: Icon(MdiIcons.arrowLeftBoldBoxOutline)),body: SafeArea(child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
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
           return Padding(
             padding: const EdgeInsets.symmetric(horizontal: 5),
             child: InkWell(
              onTap: (){
                setState(() {
                   selectedIndex=index;
                });
              },
               child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(),color: selectedIndex==index?Colors.black:Colors.white,),
                child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: selectedIndex==index?Text(gymType[index],style: TextStyle(color: Colors.white),):Text(gymType[index],style: TextStyle(color: Colors.black),),
                ),
               ),
             ),
           );
          }),
        )
      ],),),);
  }
}