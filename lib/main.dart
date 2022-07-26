import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_lyft_app/utils/LocationProvider.dart';


import 'ui/MyHomePageRevamp.dart';


// This is our global ServiceLocator
GetIt getIt = GetIt.instance;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
  getIt.registerSingleton(LocationProvider());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uber Lyft App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        hintColor: Colors.grey,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: MyHomePage(title: 'Flutter Demo'),
      home: MyHomePageRevamp(title: 'Flutter Demo'),
    );
  }
}


