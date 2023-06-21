import 'package:aireminder/Controllers/taskcontroller.dart';
import 'package:aireminder/db/dbhelper.dart';
import 'package:aireminder/services/themeservices.dart';
import 'package:aireminder/ui/homepage.dart';
import 'package:aireminder/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //makessure that getstorageisinitialized
  await DBHelper.initDb();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      themeMode: ThemeServices().theme,
      theme: Themes.light,
      darkTheme: Themes.dark,

      home: Homepage()
    );
  }
}

