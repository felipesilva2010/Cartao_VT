import 'package:catao_vt/Controller/Recarga_Controller.dart';
import 'package:catao_vt/View/confirmacao_recarga_screen.dart';
import 'package:catao_vt/View/saldo_screen.dart';
import 'package:catao_vt/model/cartão_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RecargaController', () {
    test('valida os limites e atualiza o saldo ao confirmar', () {
      final cartao = CartaoModel(saldo: 100);
      final controller = RecargaController(cartao);

      expect(controller.validarValor(9.99), isNotNull);
      expect(controller.validarValor(10), isNull);
      expect(controller.validarValor(50), isNull);
      expect(controller.validarValor(50.01), isNotNull);

      final recarga = controller.confirmarRecarga(20);
      expect(recarga.valor, 20);
      expect(recarga.data, isA<DateTime>());
      expect(cartao.saldo, 120);
    });

    test('interpreta valor decimal com vírgula e rejeita texto inválido', () {
      final controller = RecargaController(CartaoModel());

      expect(controller.interpretarValor('20,50'), 20.5);
      expect(controller.interpretarValor('abc'), isNull);
    });
  });

  testWidgets('continuar abre Tela 4 com o valor selecionado', (
    tester,
  ) async {
    final cartao = CartaoModel(numero: 12345678, saldo: 100);
    await tester.pumpWidget(
      MaterialApp(home: SaldoScreen(cartao: cartao)),
    );

    await tester.tap(find.text('Recarregar'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('R\$ 30'));
    await tester.tap(find.text('Continuar'));
    await tester.pumpAndSettle();

    expect(find.byType(ConfirmacaoRecargaScreen), findsOneWidget);
    expect(find.text('Tela 4 - Confirmar recarga'), findsOneWidget);
    expect(find.text('R\$ 30,00'), findsOneWidget);
    expect(cartao.saldo, 130);
  });

  testWidgets('campo de outro valor rejeita letras e valores abaixo do mínimo', (
    tester,
  ) async {
    final cartao = CartaoModel(saldo: 100);
    await tester.pumpWidget(
      MaterialApp(home: SaldoScreen(cartao: cartao)),
    );

    await tester.tap(find.text('Recarregar'));
    await tester.pumpAndSettle();

    final campoValor = find.byType(TextFormField);
    await tester.enterText(campoValor, 'abc');
    expect(
      tester.widget<TextFormField>(campoValor).controller!.text,
      isEmpty,
    );

    await tester.enterText(campoValor, '5');
    await tester.tap(find.text('Continuar'));
    await tester.pumpAndSettle();

    expect(find.text('O valor mínimo da recarga é R\$ 10,00'), findsOneWidget);
  });
}
