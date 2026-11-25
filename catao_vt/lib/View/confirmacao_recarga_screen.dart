import 'package:flutter/material.dart';
import 'package:catao_vt/model/recarga_model.dart';

class ConfirmacaoRecargaScreen extends StatelessWidget {
  const ConfirmacaoRecargaScreen({
    super.key,
    required this.recarga,
  });

  final RecargaModel recarga;

  String get _valorFormatado =>
      'R\$ ${recarga.valor.toStringAsFixed(2).replaceAll('.', ',')}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tela 4 - Confirmar recarga')),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Valor escolhido',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  _valorFormatado,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                Text(
                  'Data: ${recarga.data.day.toString().padLeft(2, '0')}/'
                  '${recarga.data.month.toString().padLeft(2, '0')}/'
                  '${recarga.data.year}',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Voltar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
