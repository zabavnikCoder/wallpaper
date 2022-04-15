import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wallpapers/drawer_screen.dart';
import 'package:wallpapers/screens/wall_screen.dart';


Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
   @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // initialRoute: LoginScreen.path_id,
      // routes:{
      //   LoginScreen.path_id:(context) => LoginScreen(),
      //   RegisterScreen.path_id:(context) => RegisterScreen(),
      //   DrawerScreen.path_id:(context) => DrawerScreen(),
      // }
      home: WallpaperScreen(),
    );
  }
}



