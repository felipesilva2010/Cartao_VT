
class CartaoModel {
  double? numero;
  double? saldo;
 
  CartaoModel({
    this.numero,
    this.saldo,
  });
  String formatarSaldo() {
    if (saldo == null) return 'R\$ 100,00';
    return 'R\$ ${saldo!.toStringAsFixed(2).replaceAll('.', ',')}';
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
