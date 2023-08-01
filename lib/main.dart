import 'package:assignment_wtf/Providers/gym_provider.dart';
import 'package:assignment_wtf/view_model/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GymProvider()),
      ],
      child: const MainScreen(),
    ),
    );
  }
}
