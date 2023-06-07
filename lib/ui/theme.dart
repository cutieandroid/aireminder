import 'package:flutter/material.dart';

const Color bluishcolor=Color(0xff4e5ae8);
const Color yellowcolor=Color(0xffffb746);
const Color pinkcolor=Color(0xff4e5ae8);
const Color white=Colors.white;
const primcolor=bluishcolor;
const Color darkGreyclr=Color(0xff121212);
Color darkheaderclr= Color(0xff424242);



class Themes{
  static final light=ThemeData(
      primaryColor:primcolor, //primary color changes the buttons and appbar
      brightness:Brightness.light
  );
  static final dark= ThemeData(
  primaryColor:darkGreyclr, //primary color changes the buttons and appbar
  brightness:Brightness.dark);

}