import 'package:flutter/material.dart';
import 'package:newstask/Screens/SplashScreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'screens/SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://pwbtejdshwvgownaqeao.supabase.co/rest/v1/L",
    anonKey: "sb_publishable_tR8Up4GHxG1mWG2Vh_pEYQ_nHCPYUqo",
  );

  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
