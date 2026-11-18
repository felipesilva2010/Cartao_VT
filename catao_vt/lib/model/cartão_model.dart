
class CartaoModel {
  double? numero;
  double? saldo;
 
  CartaoModel({
    this.numero,
    this.saldo,
  });

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
