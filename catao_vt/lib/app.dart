

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
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 4, 134, 8),
            foregroundColor: Colors.white,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}