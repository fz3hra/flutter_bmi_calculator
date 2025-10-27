import 'package:feedback/feedback.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bmi_calculator/app_state.dart';
import 'package:flutter_bmi_calculator/firebase_options.dart';
import 'package:flutter_bmi_calculator/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(AgenticBmiWidget());
}

class AgenticBmiWidget extends StatelessWidget {
  const AgenticBmiWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BetterFeedback(
      theme: FeedbackThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      child: ChangeNotifierProvider(
        create: (context) => AppState(),
        child: MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppState manager = context.watch<AppState>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: manager.appColor),
        // textTheme: Theme.of(context).textTheme.apply(
        //   fontFamily: context.watch<AppState>().fontFamily,
        //   fontSizeFactor: context.watch<AppState>().fontSizeFactor,
        // ),
      ),
      home: const HomeScreen(),
    );
  }
}

// TODO: BMI calculation
//BMI = weight (kg) / height² (m²)
