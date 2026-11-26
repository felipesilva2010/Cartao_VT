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
    return 'Cartão •••• $ultimosDigitos';
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
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5F4EF),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Saldo disponível',
                        style: TextStyle(
                          color: Color(0xFF287A5A),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        controller.saldoFormatado,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF168451),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _numeroMascarado,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF36566B),
                      ),
                ),
                const SizedBox(height: 12),
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF168451),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text('+ Recarregar saldo'),
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
