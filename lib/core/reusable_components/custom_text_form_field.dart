import 'package:flutter/material.dart';
typedef Validator = String? Function(String?);
class CustomTextFormField extends StatelessWidget {
   CustomTextFormField({super.key , required this.hintText , this.validatot , this.controller , this.isScure = false});
String hintText ;
   Validator? validatot ;
   TextEditingController? controller ;
   bool isScure;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isScure ,
      validator: validatot,
      controller:controller ,

      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.white ,width: 2),

        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.white ,width: 2),

        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.red ,width: 2),
        ),

        hintText: hintText,
        hintStyle: TextStyle( fontWeight : FontWeight.w300,fontSize: 16, color: Colors.grey),

      ),
    );
  }
}
