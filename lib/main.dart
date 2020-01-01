import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pigment/pigment.dart';
import 'package:provider/provider.dart';
import 'package:service_appointment/first_page.dart';
import 'package:service_appointment/provider/booking_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => BookingProvider(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Service Appointment',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          canvasColor: Colors.transparent,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(color: Colors.white, elevation: 0),
          primaryColor: Pigment.fromString('#2F313B'),
          accentColor: Pigment.fromString('#00D4B7'),
          disabledColor: Pigment.fromString('#e6e8eb'),
          secondaryHeaderColor: Color(0xff4e515a),
          dividerColor: Colors.transparent,
          fontFamily: 'Inter'),
      home: FirstPage(),
    );
  }
}
