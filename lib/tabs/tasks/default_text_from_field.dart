import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_update/app_them.dart';
import 'package:to_do_update/tabs/settings/seetings_provider.dart';

class DefaultTextFromField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final bool ispassword;
  final String? Function(String?)? validator;

  const DefaultTextFromField({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
    this.validator,
    this.ispassword = false,
  });

  @override
  State<DefaultTextFromField> createState() => _DefaultTextFromFieldState();
}

class _DefaultTextFromFieldState extends State<DefaultTextFromField> {
  bool isObscure = false;
  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider = Provider.of<SettingProvider>(context);
    bool isDark = settingProvider.isDark;

    return TextFormField(
      style: TextStyle(color: isDark ? Appthem.white : Appthem.black),
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(color: isDark ? Appthem.white : Appthem.black),
        suffixIcon: widget.ispassword
            ? IconButton(
                onPressed: () {
                  isObscure = !isObscure;
                  setState(() {});
                },
                icon: Icon(
                  isObscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: isDark ? Appthem.white : Appthem.black,
                ),
              )
            : null,
      ),
      validator: widget.validator,
      maxLines: widget.maxLines,
      obscureText: isObscure,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
