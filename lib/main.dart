import 'package:assengadmin/reusables/brandname.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'destinations/assenga_home.dart';
import 'firebase_options.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        scaffoldBackgroundColor: CupertinoColors.systemGroupedBackground,
        primaryColor: CupertinoColors.activeBlue,
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white, foregroundColor: Colors.black)),
    home: const SoftSplash(),
  ));
}

class SoftSplash extends StatefulWidget {
  const SoftSplash({super.key});

  @override
  State<SoftSplash> createState() => _SoftSplashState();
}

class _SoftSplashState extends State<SoftSplash> {
  @override
  void initState() {
    aftrinit();
    super.initState();
  }

  aftrinit() async {
    await Future.delayed(const Duration(seconds: 5));
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const AssengaHome(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      floatingActionButton: Text("projectsoftonia"),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Center(
        child: AssengaBrand(),
      ),
    );
  }
}
