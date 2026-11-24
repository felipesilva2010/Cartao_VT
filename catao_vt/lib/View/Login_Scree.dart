import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:catao_vt/View/saldo_screen.dart';
import 'package:catao_vt/model/cartão_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _numeroController = TextEditingController();
  final _senhaController = TextEditingController();

  @override
  void dispose() {
    _numeroController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  void _entrar() {
    if (!_formKey.currentState!.validate()) return;

    final cartao = CartaoModel(
      numero: double.parse(_numeroController.text),
      saldo: 100,
    );
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => SaldoScreen(cartao: cartao),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.directions_bus_filled,
                    size: 72,
                    color: Color.fromARGB(255, 201, 187, 64),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'CartãoVT Recarga',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                   const SizedBox(height: 8),
                  const Text(
                    'Consulte o saldo e recarregue seu cartão de vale-transporte',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _numeroController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(16),
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Número do cartão',
                      prefixIcon: Icon(
                        Icons.credit_card,
                        color: Colors.blue,
                      ),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe o número do cartão';
                      }
                      if (value.length != 8) {
                        return 'O número do cartão deve ter 8 dígitos ex:87654321';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _senhaController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Color.fromARGB(255, 241, 143, 113),
                      ),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe a senha';
                      }
                      if (value.length < 4) {
                        return 'A senha deve ter pelo menos 4 caracteres ex:1234';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _entrar,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Entrar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
