import 'package:catao_vt/View/Login_Scree.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('campo vazio não navega', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    await tester.tap(find.text('Entrar'));
    await tester.pumpAndSettle();

    expect(find.text('Informe o número do cartão'), findsOneWidget);
    expect(find.text('Tela 2'), findsNothing);
  });

  testWidgets('caractere não numérico não é aceito no campo do cartão', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    final cardField = find.byType(TextFormField).first;
    await tester.enterText(cardField, '12a34b');
    await tester.pump();

    final field = tester.widget<TextFormField>(cardField);
    expect(field.controller!.text, '1234');

  });
}
