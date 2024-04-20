import 'package:flutter/material.dart';
import 'package:mb_app_root/utils/app_theme.dart';

class TextFieldCustom extends StatelessWidget {
  const TextFieldCustom(
      {super.key,
      required this.textController,
      required this.label,
      required this.soloLectura,
      required this.onPressed,
      required this.focusText,
      required this.isFocus
      /* required this.helperText*/
      });

  final TextEditingController textController;
  final String label;
  final bool soloLectura;
  final VoidCallback onPressed;
  final FocusNode? focusText;
  final bool isFocus;

  //final String helperText;

  @override
  Widget build(BuildContext context) {
    return Container(
      //width:100,
      height: 40,
      child: TextField(
        //maxLines:null,
        //textAlign: TextAlign.center,
        autofocus: isFocus,
        focusNode: focusText,
        textAlignVertical: TextAlignVertical.center,
        maxLines: 1,
        readOnly: soloLectura,
        controller: textController,
        style: TextStyle(fontSize: 14, height: 1),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: onPressed,
            icon: Icon(Icons.clear),
          ),
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey),
          fillColor: Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            // borderSide: BorderSide(color: Colors.grey, width: 1.0),
            borderSide:
                BorderSide(color: AppThemeData.light.primaryColor, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
