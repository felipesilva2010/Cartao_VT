import 'package:flutter/material.dart';
import 'package:catao_vt/Controller/saldo_controller.dart';
import 'package:catao_vt/View/recarga_screen.dart';
import 'package:catao_vt/model/cartão_model.dart';

class SaldoScreen extends StatefulWidget {
  const SaldoScreen({super.key, required this.cartao});

  final CartaoModel cartao;

  @override
  State<SaldoScreen> createState() => _SaldoScreenState();
}

class _SaldoScreenState extends State<SaldoScreen> {
  late final SaldoController controller = SaldoController(widget.cartao);

  String get _numeroMascarado {
    final numero = widget.cartao.numero?.toInt().toString() ?? '';
    final ultimosDigitos = numero.length > 4
        ? numero.substring(numero.length - 4)
        : numero.padLeft(4, '0');
    return '**** **** $ultimosDigitos';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meu saldo')),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Número do cartão',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  _numeroMascarado,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 32),
                const Text(
                  'Saldo atual',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  controller.saldoFormatado,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () async {
                    final recarga = await Navigator.of(context)
                        .push<Object>(
                          MaterialPageRoute<Object>(
                            builder: (_) =>
                                RecargaScreen(cartao: widget.cartao),
                          ),
                        );
                    if (recarga != null && mounted) {
                      setState(() {});
                    }
                  },
                  child: const Text('Recarregar'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Sair'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
