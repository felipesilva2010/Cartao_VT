

import 'package:flutter/material.dart';
import 'package:catao_vt/View/Login_Scree.dart';

class CartaoVTApp extends StatelessWidget {
  const CartaoVTApp({super.key} );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CartãoVT Recarga',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const LoginScreen(),
    );
  }
}