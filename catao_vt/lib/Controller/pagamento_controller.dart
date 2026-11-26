import 'package:catao_vt/model/pagamento_model.dart';

class PagamentoController {
  String? validarPagamento(PagamentoModel? pagamento) {
    if (pagamento == null) {
      return 'Informe os dados do pagamento';
    }

    if (!pagamento.valor.isFinite || pagamento.valor <= 0) {
      return 'O valor do pagamento deve ser maior que zero';
    }

    return null;
  }
}
