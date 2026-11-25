
class CartaoModel {
  double? numero;
  double? saldo;
 
  CartaoModel({
    this.numero,
    this.saldo,
  });

  String formatarSaldo() {
    final valorFormatado = (saldo ?? 0)
        .toStringAsFixed(2)
        .replaceAll('.', ',');
    return 'R\$ $valorFormatado';
  }

  void adicionarSaldo(double valor) {
    if (!valor.isFinite || valor <= 0) {
      throw ArgumentError.value(valor, 'valor', 'Deve ser um valor positivo.');
    }

    saldo = (saldo ?? 0) + valor;
  }

  CartaoModel.fromJson(Map<String, dynamic> json) {
    numero = json['numero'];
    saldo = (json['saldo'] as num?)?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['numero'] = numero;
    data['saldo'] = saldo;
    return data;
  }
}
