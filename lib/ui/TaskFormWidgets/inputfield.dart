

import 'package:aireminder/services/themeservices.dart';
import 'package:aireminder/ui/theme.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String title,hint;
  final TextEditingController;
  final Widget? widget;
  const InputField({Key? key, required this.title, required this.hint, this.TextEditingController, this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: inputfieldstyle,),
          Container(
            margin: EdgeInsets.only(top: 10),
            height: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey,
                width: 1.0
              )
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: TextEditingController,
                      readOnly: widget==null?false:true,
                      decoration: InputDecoration(
                        hintText: hint,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color:ThemeServices().loadThemeFromStore()?darkGreyclr:Colors.white )

                        ),
                        focusedBorder:  UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: ThemeServices().loadThemeFromStore()?darkGreyclr:Colors.white
                          )
                        )
                      ),
                      cursorColor: ThemeServices().loadThemeFromStore()?Colors.black:Colors.black,

                    ),
                  ),
                ),
                widget==null?Container():Container(child:widget ,)
              ],
            ),

          )
        ],
      ),
    );
  }
}
