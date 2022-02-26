import 'package:flutter/material.dart';

class header2 extends StatelessWidget {
  const header2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 150,
      child: DrawerHeader(
        child: Image.asset("images1/ibblogo.png", height: 60, width: 60),
        decoration: const BoxDecoration(
            color: Colors.lime
        ),
      ),
    );
  }
}
