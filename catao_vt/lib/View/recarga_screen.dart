import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:catao_vt/Controller/Recarga_Controller.dart';
import 'package:catao_vt/View/pagamento_screen.dart';
import 'package:catao_vt/model/cartão_model.dart';

class RecargaScreen extends StatefulWidget {
  const RecargaScreen({super.key, required this.cartao});

  final CartaoModel cartao;

  @override
  State<RecargaScreen> createState() => _RecargaScreenState();
}

class _RecargaScreenState extends State<RecargaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _valorController = TextEditingController();
  double? _valorRapido;

  late final RecargaController _controller = RecargaController(widget.cartao);

  @override
  void dispose() {
    _valorController.dispose();
    super.dispose();
  }

  double? get _valorSelecionado =>
      _valorRapido ?? _controller.interpretarValor(_valorController.text);

  void _selecionarValor(double valor) {
    setState(() {
      _valorRapido = valor;
      _valorController.clear();
    });
  }

  void _continuar() {
    if (!_formKey.currentState!.validate()) return;

    final recarga = _controller.confirmarRecarga(_valorSelecionado!);
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => PagamentoScreen(recarga: recarga),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recarga')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Escolha um valor',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final valor in [10.0, 20.0, 30.0, 50.0])
                      ElevatedButton(
                        onPressed: () => _selecionarValor(valor),
                        child: Text(
                          _valorRapido == valor
                              ? '✓ R\$ ${valor.toStringAsFixed(0)}'
                              : 'R\$ ${valor.toStringAsFixed(0)}',
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _valorController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      final isNumeric = RegExp(
                        r'^\d*(?:[,.]\d{0,2})?$',
                      ).hasMatch(newValue.text);
                      return isNumeric ? newValue : oldValue;
                    }),
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Outro valor',
                    prefixText: 'R\$ ',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (_) {
                    if (_valorRapido != null) {
                      setState(() => _valorRapido = null);
                    }
                  },
                  validator: (_) =>
                      _controller.validarValor(_valorSelecionado),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _continuar,
                  child: const Text('Continuar'),
                ),
                TextButton(
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