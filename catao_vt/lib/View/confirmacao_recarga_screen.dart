import 'package:flutter/material.dart';
import 'package:catao_vt/View/pagamento_screen.dart';
import 'package:catao_vt/model/recarga_model.dart';

class ConfirmacaoRecargaScreen extends StatelessWidget {
  const ConfirmacaoRecargaScreen({super.key, required this.recarga});

  final RecargaModel recarga;

  @override
  Widget build(BuildContext context) => PagamentoScreen(recarga: recarga);
}
