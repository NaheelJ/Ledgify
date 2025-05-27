import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ledgifi/company/companySplashScreen.dart';
import 'package:ledgifi/company/sales/customersScreen.dart';
import 'package:ledgifi/providers/loginProvider.dart';
import 'package:ledgifi/providers/mainProvider.dart';
import 'package:provider/provider.dart';

import 'admin/dashBoard/dashBoardAdmin.dart';
import 'admin/reports/expenseReportScreen.dart';
import 'admin/sideBarForAmnin.dart';
import 'admin/users/usersScreen.dart';
import 'company/employees management/employeesScreen.dart';
import 'company/employees management/payRollScreen.dart';
import 'company/sideBar.dart';
import 'company/topBarSwitcher.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await Firebase.initializeApp();
  } else {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBUsVb8Be0EzZFfo2TpPyi1ts4J31HPaLo",
          authDomain: "ledgifi-68391.firebaseapp.com",
          projectId: "ledgifi-68391",
          storageBucket: "ledgifi-68391.firebasestorage.app",
          messagingSenderId: "690836165499",
          appId: "1:690836165499:web:5d18ac91cb3e31b67e63de",
          measurementId: "G-4NXQG2DTH1"
      ),
    );
  }

  runApp(MyApp());
}


void testFirestoreConnection() async {
  try {
    await FirebaseFirestore.instance
        .collection('test')
        .doc('connection_check')
        .set({'connected': true, 'time': DateTime.now()});
    print('✅ Firestore write successful – Firebase is connected.');
  } catch (e) {
    print('❌ Firebase connection failed: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   // testFirestoreConnection();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MainProvider(),),
        ChangeNotifierProvider(create: (context) => LoginProvider(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'LEDGIFI',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: SplashScreenCompany(),
      ),
    );
  }
}
