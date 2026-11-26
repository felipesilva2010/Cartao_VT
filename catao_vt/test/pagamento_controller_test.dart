import 'package:catao_vt/Controller/pagamento_controller.dart';
import 'package:catao_vt/model/pagamento_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PagamentoController', () {
    final controller = PagamentoController();

    test('aceita pagamento com forma e valor válidos', () {
      const pagamento = PagamentoModel(
        formaPagamento: FormaPagamento.pix,
        valor: 30,
      );

      expect(controller.validarPagamento(pagamento), isNull);
    });

    test('rejeita pagamento ausente', () {
      expect(controller.validarPagamento(null), 'Informe os dados do pagamento');
    });

    test('rejeita valores não positivos ou não finitos', () {
      for (final valor in [0.0, -1.0, double.nan, double.infinity]) {
        final pagamento = PagamentoModel(
          formaPagamento: FormaPagamento.pix,
          valor: valor,
        );

        expect(
          controller.validarPagamento(pagamento),
          'O valor do pagamento deve ser maior que zero',
        );
      }
    });
  });
}
