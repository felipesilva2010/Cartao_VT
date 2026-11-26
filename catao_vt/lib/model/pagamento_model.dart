enum FormaPagamento {
  pix,
  cartaoCredito,
  boleto,
}

class PagamentoModel {
  const PagamentoModel({
    required this.formaPagamento,
    required this.valor,
  });

  final FormaPagamento formaPagamento;
  final double valor;
}