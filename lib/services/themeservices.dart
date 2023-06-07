import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices{
  final _store= GetStorage(); //create a store to store the bolean
  final _key='isDarkmode'; //get storage saves in key value format so we will create a key

  //loadthemeformstore will check if there is a value present in the store for key
  //if there is then it will return true else will return false
  bool _loadThemeFromStore()=> _store.read(_key)??false;
  //this getter function checks loadthemes returned value is true or false
  //if false means no value for that key , that is app is just loaded, so for false it will set lightmode
  ThemeMode get theme=>_loadThemeFromStore()?ThemeMode.dark:ThemeMode.light;
  void switchtheme(){
    Get.changeThemeMode(_loadThemeFromStore()?ThemeMode.light:ThemeMode.dark);
    _savethemetostore(!_loadThemeFromStore());
    //loadthemefromstore return true that is there is a value for key isdarkmode
    //that means currently darkmode is on, so change it to light
  }
  //after we change the theme we need to update the current theme which is present
  //so if we click and we enter darkmode next time we click we should enter light mode
  //we will enter lightmode only if loadtheme return true but current value of loadtheme
  //is true false so we pass the complement of currentloadtheme
  _savethemetostore(bool isDarkmode)=>_store.write(_key, isDarkmode);
}