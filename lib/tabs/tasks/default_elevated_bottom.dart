import 'package:flutter/material.dart';
import 'package:to_do_update/app_them.dart';

class DefaultElevatedBottom extends StatelessWidget {
  final String lable;
  final VoidCallback onPressed;

  const DefaultElevatedBottom(
      {super.key, required this.lable, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(MediaQuery.of(context).size.width, 52),
      ),
      onPressed: onPressed,
      child: Text(
        lable,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w400,
              color: Appthem.white,
            ),
      ),
    );
  }
}
