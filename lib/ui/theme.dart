import 'package:aireminder/services/themeservices.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bluishcolor=Color(0xff4e5ae8);
const Color yellowcolor=Color(0xffffb746);
const Color pinkcolor=Color(0xff4e5ae8);
const Color white=Colors.white;
const primcolor=bluishcolor;
const Color darkGreyclr=Color(0xff121212);
Color darkheaderclr= Color(0xff424242);



class Themes{
  static final light=ThemeData(
      backgroundColor: Colors.white,
      primaryColor:primcolor, //primary color changes the buttons and appbar
      brightness:Brightness.light
  );
  static final dark= ThemeData(
  backgroundColor: darkGreyclr,
  primaryColor:darkGreyclr, //primary color changes the buttons and appbar
  brightness:Brightness.dark);

}

TextStyle get subheadingstyle{
  return GoogleFonts.lato(
    textStyle:  TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: ThemeServices().loadThemeFromStore()?Colors.grey:Colors.grey[500]
    )

  );
}

TextStyle get headingstyle{
  return GoogleFonts.lato(
      textStyle: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,

      )

  );
}