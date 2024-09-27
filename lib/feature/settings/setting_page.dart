import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.cyan,
      child: Center(
        child: Text('Settings Page',style: TextStyle(color: Colors.black),),
      ),
    );
  }
}