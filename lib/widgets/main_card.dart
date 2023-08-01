import 'package:assignment_wtf/services/service_for_gym_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MainCard extends StatelessWidget {
  final GymData filteredGym;
  MainCard(this.filteredGym);

  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Card(
                    elevation: 5,
                    color: Colors.grey,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    child:  Container(      
                      height: Get.height*.55,
                      width: Get.width*.9,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.grey,),
                    child: Column(children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [ 
                          Container(
                            height: Get.height*.4,
                            width: Get.width*.9,
                            child: filteredGym.gymType=="Yoga"? Image.asset("assets/cobranded.jpg",fit: BoxFit.fill,):filteredGym.gymType=="Powered"? Image.asset("assets/poweredImage.jpg",fit: BoxFit.fill,):Image.asset("assets/main.png",fit: BoxFit.fill,),
                          ),
                           Positioned(
                           bottom: Get.height*.03,
                           left: Get.width*.25,
                            child:Column(children: [
                            Text(filteredGym.gymName.toString(),style: TextStyle(color:!(filteredGym.gymType=="Powered")? Colors.white:Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                            Text(filteredGym.distance!+"Km "+filteredGym.city.toString(),style: TextStyle(color:!(filteredGym.gymType=="Powered")? Colors.white:Colors.black,fontWeight: FontWeight.bold,fontSize: 12),),
                          ],) ),
                        ],
                      ),
                      Container(height:Get.height*.15 ,width: Get.width*.88,decoration: BoxDecoration(color: const Color.fromARGB(255, 43, 39, 39),borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30))),child: Column(children: [
                        SizedBox(height: Get.height*.02,),
                         Text("Starting At \$1833/month",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                         ButtonBar(
                           alignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                        ElevatedButton(
                child: Text('FREE FIRST DAY',style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(backgroundColor:Colors.red ),
                onPressed: (){},
              ),
             ElevatedButton(
                child: Text('BUY NOW',style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(backgroundColor:Colors.grey ),
                onPressed: (){},
              ),
            ],
          )
                      ],),)
                  ],),) ,
                  ),
                
                ],
              ),
            );
  }
}