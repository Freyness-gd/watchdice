import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watchdice/layers/presentation/app_root.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  // WidgetsFlutterBinding.ensureInitialized();
  sharedPref_Temp = await SharedPreferences.getInstance();
  // await initializeGetIt();
  // Animate.restartOnHotReload = true;
  //
  // runApp(const ProviderScope(child: AppRoot()));

  // Loads configuration files, initializes databases and accesses
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = SharedPreferencesAsync();

  // Load environmental variables
  await dotenv.load(fileName: 'env/.env.dev');

  Animate.restartOnHotReload = true;

  runApp(const ProviderScope(child: AppRoot()));
}
