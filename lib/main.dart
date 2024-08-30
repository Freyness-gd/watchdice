import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watchdice/layers/presentation/cubit_app.dart';

enum StateManagementOptions {
  bloc,
  cubit,
  provider,
  riverpod,
  getIt,
  mobX,
}

late SharedPreferences sharedPref_Temp;
late final SharedPreferencesAsync sharedPref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref_Temp = await SharedPreferences.getInstance();

  // Loads configuration files, initializes databases and accesses
  sharedPref = SharedPreferencesAsync();

  // Load environmental variables
  await dotenv.load(fileName: 'assets/env/.env.dev');

  Animate.restartOnHotReload = true;

  runApp(const CubitApp());
}
