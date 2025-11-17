import 'package:flutter/material.dart';

class AppInputField extends StatelessWidget {
  // varibale nilam
  String labelText;
  TextEditingController controller = TextEditingController();
  TextInputType textInputType = TextInputType.none;

  AppInputField({
    super.key,
    required this.labelText,
    required this.controller,
    required this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,

      keyboardType: textInputType,

      decoration: InputDecoration(

        hintText: labelText,

        label: Text(labelText),

        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        // Click korarr age
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green,width:2)
        ),
        // Click korarr pore
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.yellow,width:2)
        ),
      ),
    );
  }
}
