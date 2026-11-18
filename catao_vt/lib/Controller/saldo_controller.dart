import 'package:catao_vt/model/cartão_model.dart';

class SaldoController {
  SaldoController(this.cartao);

  final CartaoModel cartao;

  String get saldoFormatado => cartao.formatarSaldo();
}
