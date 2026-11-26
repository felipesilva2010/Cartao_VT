import 'package:catao_vt/Controller/Recarga_Controller.dart';
import 'package:catao_vt/View/pagamento_screen.dart';
import 'package:catao_vt/View/saldo_screen.dart';
import 'package:catao_vt/model/cartão_model.dart';
import 'package:catao_vt/model/pagamento_model.dart';
import 'package:catao_vt/model/recarga_model.dart';
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

  testWidgets('continuar abre Tela 4 com o valor selecionado', (tester) async {
    final cartao = CartaoModel(numero: 12345678, saldo: 100);
    await tester.pumpWidget(MaterialApp(home: SaldoScreen(cartao: cartao)));

    await tester.tap(find.text('+ Recarregar saldo'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('R\$ 30'));
    await tester.tap(find.text('Continuar'));
    await tester.pumpAndSettle();

    expect(find.byType(PagamentoScreen), findsOneWidget);
    expect(find.text('Tela 4 - Confirmar recarga'), findsOneWidget);
    expect(find.text('R\$ 30,00'), findsOneWidget);
    expect(cartao.saldo, 130);
  });

  testWidgets('exibe formas de pagamento com ícones e permite selecioná-las', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PagamentoScreen(
          recarga: RecargaModel(valor: 30, data: DateTime(2026, 1, 1)),
        ),
      ),
    );

    expect(find.text('Pix'), findsOneWidget);
    expect(find.text('Cartão de crédito'), findsOneWidget);
    expect(find.text('Boleto'), findsOneWidget);
    expect(find.byIcon(Icons.phone_android), findsOneWidget);
    expect(find.byIcon(Icons.credit_card), findsOneWidget);
    expect(find.byIcon(Icons.receipt_long), findsOneWidget);
    expect(find.byType(Divider), findsNWidgets(2));
    expect(find.byType(TextFormField), findsNothing);

    await tester.tap(find.text('Cartão de crédito'));
    await tester.pump();

    final grupoPagamento = tester.widget<RadioGroup<FormaPagamento>>(
      find.byType(RadioGroup<FormaPagamento>),
    );
    expect(grupoPagamento.groupValue, FormaPagamento.cartaoCredito);
    expect(find.byType(TextFormField), findsNWidgets(3));
    expect(find.text('Número do cartão'), findsOneWidget);
    expect(find.text('Validade'), findsOneWidget);
    expect(find.text('CVV'), findsOneWidget);
  
      
    

    await tester.tap(find.text('Pix'));
    await tester.pump();
    expect(find.byType(TextFormField), findsNothing);
  });

  testWidgets(
    'campo de outro valor rejeita letras e valores abaixo do mínimo',
    (tester) async {
      final cartao = CartaoModel(saldo: 100);
      await tester.pumpWidget(MaterialApp(home: SaldoScreen(cartao: cartao)));

      await tester.tap(find.text('+ Recarregar saldo'));
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

      expect(
        find.text('O valor mínimo da recarga é R\$ 10,00'),
        findsOneWidget,
      );
    },
  );
}
