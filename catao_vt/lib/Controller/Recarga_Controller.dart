import 'package:catao_vt/model/cartão_model.dart';
import 'package:catao_vt/model/recarga_model.dart';

class RecargaController {
  RecargaController(this.cartao);

  static const double valorMinimo = 10;
  static const double valorMaximo = 200;

  final CartaoModel cartao;

  String? validarValor(double? valor) {
    if (valor == null || !valor.isFinite) {
      return 'Informe um valor válido';
    }
    if (valor < valorMinimo) {
      return 'O valor mínimo da recarga é R\$ 10,00';
    }
    if (valor > valorMaximo) {
      return 'O valor máximo da recarga é R\$ 200';
    }
    return null;
  }

  double? interpretarValor(String texto) {
    final valorNormalizado = texto.trim().replaceAll(',', '.');
    if (!RegExp(r'^\d+(?:\.\d{1,2})?$').hasMatch(valorNormalizado)) {
      return null;
    }
    return double.tryParse(valorNormalizado);
  }

  RecargaModel confirmarRecarga(double valor) {
    final erro = validarValor(valor);
    if (erro != null) {
      throw ArgumentError.value(valor, 'valor', erro);
    }

    final recarga = RecargaModel(valor: valor, data: DateTime.now());
    cartao.adicionarSaldo(valor);
    return recarga;
  }
}