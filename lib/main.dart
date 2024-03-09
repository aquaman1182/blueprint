import 'package:blueprint/firebase_options.dart';
import 'package:blueprint/screens/signup/signup_screen.dart';
import 'package:blueprint/stores.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: generateProviders(),
      child: MaterialApp(
        title: 'Blueprint',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SignupScreen(),
      ),
    );
  }
}
