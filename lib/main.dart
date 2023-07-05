// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:traffic_hero/Passerby_Mode/MassTransit_Mode.dart';
import 'Passerby_Mode/Car_Mode.dart';
import 'Passerby_Mode/Scooter_Mode.dart';
import 'package:provider/provider.dart';
import 'Mode_State.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => mode_state(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String mode = 'car';  

  void selectedMode(value){
    setState(() {
      mode = value;
    });
  }
  Widget changeMode(){
    if(mode == 'car'){
      return const CarMode();
    }else if(mode == 'scooter'){
      return const ScooterMode();
    }else{
      return const MassTransitMode();
    }
  }

  @override
  Widget build(BuildContext context) {
    mode_state state = Provider.of<mode_state>(context);

    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(46, 117, 182, 1),
          elevation: 0,
          title: Text(''),
          centerTitle: true, 
          leading: IconButton(
            icon: Image.asset("assets/topbar/SmartAssistant.png"),
            iconSize: 50,
            onPressed: () => print('smart Assistant'),
          ),
          actions: [
            IconButton(
              icon: Image.asset("assets/topbar/Mode_Car.png"),
              iconSize: 50,
              onPressed: ()  {
                selectedMode('car');
                //將狀態儲存為car
                state.updateState('car');
              },
            ),
            IconButton(
              icon: Image.asset("assets/topbar/Mode_Scooter.png"),
              iconSize: 50,
              onPressed: ()  {
                selectedMode('scooter');
                state.updateState('scooter');
                },
            ),
            IconButton(
              icon: Image.asset("assets/topbar/Mode_Masstransit.png"),
              iconSize: 50,
              onPressed: ()  {
                selectedMode('masstransit');
                state.updateState('masstransit');
              },
            ),
            PopupMenuButton<String>(
              icon: Image.asset("assets/topbar/Default_Avatar.png"),
              iconSize: 50,
              offset: Offset(0, AppBar().preferredSize.height), 
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem<String>(
                    value: '',
                    child: Text(''),
                  ),
                  const PopupMenuItem<String>(
                    value: '',
                    child: Text(''),
                  ),
                ];
              },
            ),
          ],
        ),
        body: changeMode(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
