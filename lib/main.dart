import 'package:designingstudio/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:y_player/y_player.dart';

import 'provider/commonviewmodel.dart';

void main() {


  WidgetsFlutterBinding.ensureInitialized();
  YPlayerInitializer.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => CommonViewModel(),
        child: MaterialApp(
          title: 'Designing Studio',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Poppins',
            useMaterial3: true,
          ),
          home: SplashScreen(),
        ));
  }
}
