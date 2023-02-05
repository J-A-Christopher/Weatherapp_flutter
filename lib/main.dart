import 'package:flutter/material.dart';
import './weather.dart';
import './news.dart';
import './signUp.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex=0;
  final screens =[
    const MyWeather(),
    const News(),
    const SignUp()
  ];
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index)=>setState(() {
          currentIndex = index;
        }),
        selectedItemColor: Colors.amber,
        selectedFontSize: 17,
        items: const <BottomNavigationBarItem>[BottomNavigationBarItem(
          
          icon: Icon(Icons.update),label: 'Weather Update', ),
      BottomNavigationBarItem(icon: Icon(Icons.newspaper),label: 'News'),
      BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Profile')]),
        body: screens[currentIndex],
      
      )
     
    );
  }
}
