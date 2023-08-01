import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LocationScreen extends StatefulWidget {
  List<String>? cities;
  LocationScreen({this.cities});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  List<String> filteredCilites=[];

  search(String value){
    filteredCilites=[...?(widget.cities)];

    if(value.length!=0){
      filteredCilites.removeWhere((element) => !element.toLowerCase().contains(value.toString()));
    }
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
    appBar: AppBar(elevation: 0,
    leadingWidth: Get.width*.1,
    title: Text("Pick Location"),
      
      backgroundColor: Colors.white,leading: InkWell(
        onTap: (){
          Get.back();
        },
        child: Icon(MdiIcons.arrowLeftBoldBoxOutline))),
      body: SingleChildScrollView(
        child: SafeArea(child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
             TextField(
                  onChanged: (val){
                   
                    setState(() {
                      search(val);
                    });
                  },
                  decoration: InputDecoration(
                    enabledBorder:OutlineInputBorder(borderSide: BorderSide(color:Color.fromARGB(255, 222, 220, 220)),borderRadius: BorderRadius.circular(10)),
                    border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
              ),
              hintText: 'Search Location',
              hintStyle: TextStyle(color: Colors.grey),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Color.fromARGB(255, 222, 220, 220)),borderRadius: BorderRadius.circular(10)),
             prefixIcon: Icon(MdiIcons.magnify))
             ),
      
      
      Padding(
        padding: EdgeInsets.only(top: Get.height*.01),
        child:   InkWell(
          onTap: (){
            Get.back();
          },
          child: ListTile(leading:Icon(MdiIcons.locationEnter), title: Text("Around your location "),tileColor: const Color.fromARGB(255, 220, 218, 218),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
      ),
      SizedBox(height: Get.height*.01,),
      Row(
        children: [
          Text("AREA ",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.red),),
          Text("(No of Gyms)")
        ],
      
      ),
      // SizedBox(height: Get.height*.15,),
      
      ListView.builder(
       clipBehavior: Clip.none,
      
       shrinkWrap: true,
        itemCount:  filteredCilites!.length,
      physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
      
        itemBuilder: (ctx,index)=>Padding(
      
        padding: EdgeInsets.only(top: Get.height*.01),
      
        child:   ListTile(leading:Icon(MdiIcons.pin), title: Text(filteredCilites![index]),tileColor: const Color.fromARGB(255, 220, 218, 218),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      
      ),)
      ],
      
      ),
        )),
      ),


    );
  }
}