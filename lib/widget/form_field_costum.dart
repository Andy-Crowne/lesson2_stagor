import 'package:flutter/material.dart';

class FormFieldCostum extends StatelessWidget {

  final TextInputType inputType;
  final String hint;
  final FocusNode focus;
  final String saved;
  final String validator;



  FormFieldCostum(this.inputType,this.hint,this.focus,this.saved,this.validator);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: inputType,
      decoration: InputDecoration(
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0x00000000),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0x00000000),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Color(0xFF006064),
      ),
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) {
        FocusScope.of(context)
            .requestFocus(focus);
      },
      onSaved: (value) {
        saved;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return validator;
        }
        return null;
      },
    );
  }
}

class FormFieldCostumPassword extends StatelessWidget {

  final FocusNode focusNode;
  final String hint;
  final String onSave;
  final VoidCallback function;


  FormFieldCostumPassword({required this.focusNode,required this.hint,required this.onSave,required this.function});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      obscureText: true,
      decoration: InputDecoration(
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0x00000000),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0x00000000),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Color(0xFF006064),
      ),
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (_) => function(),
      onSaved: (value) {
        onSave;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter your password";
        }
        if (value.length < 5) {
          return "Please enter longest password";
        }
        return null;
      },
    );
  }
}
