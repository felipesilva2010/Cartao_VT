import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  final numeroController = TextEditingController();
  final senhaController = TextEditingController();

  bool _ocultarSenha = true;
  bool _carregando = false;

  bool get ocultarSenha => _ocultarSenha;
  bool get carregando => _carregando;

  void alternarVisibilidadeSenha() {
    _ocultarSenha = !_ocultarSenha;
    notifyListeners();
  }

  // Validações

  String? validarNumero(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Informe o número do cartão';
    }
    if (value.length != 8) {
      return 'O número do cartão deve ter 8 dígitos ex:87654321';
    }
    return null;
  }

  String? validarSenha(String? value) {
    if (value == null || value.isEmpty) {
      return 'Informe a senha';
    }
    if (value.length < 4) {
      return 'A senha deve ter pelo menos 4 caracteres ex:1234';
    }
    return null;
  }

  // Ação de login

  Future<bool> login(GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) return false;

    _carregando = true;
    notifyListeners();

    try {
      final numero = numeroController.text;
      final senha = senhaController.text;
      await Future.delayed(const Duration(seconds: 1));
      debugPrint('Login: $numero / $senha');
      return true;
    } finally {
      _carregando = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    numeroController.dispose();
    senhaController.dispose();
    super.dispose();
  }
}