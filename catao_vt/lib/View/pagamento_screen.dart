import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:catao_vt/model/pagamento_model.dart';
import 'package:catao_vt/model/recarga_model.dart';

class PagamentoScreen extends StatefulWidget {
  const PagamentoScreen({super.key, required this.recarga});

  final RecargaModel recarga;

 
  @override
  State<PagamentoScreen> createState() => _PagamentoScreenState();
}

class _PagamentoScreenState extends State<PagamentoScreen> {
  late PagamentoModel _pagamento;

  @override
  void initState() {
    super.initState();
    _pagamento = PagamentoModel(
      formaPagamento: FormaPagamento.pix,
      valor: widget.recarga.valor,
    );
  }

  String get _valorFormatado =>
      'R\$ ${widget.recarga.valor.toStringAsFixed(2).replaceAll('.', ',')}';


  void _selecionarFormaPagamento(FormaPagamento formaPagamento) {
    setState(() {
      _pagamento = PagamentoModel(
        formaPagamento: formaPagamento,
        valor: widget.recarga.valor,
      );
    });
  }

  Widget _opcaoPagamento({
    required FormaPagamento formaPagamento,
    required IconData icone,
    required String titulo,
    String? subtitulo,
  }) {
    const azul = Color(0xFF1976D2);

    return InkWell(
      onTap: () => _selecionarFormaPagamento(formaPagamento),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFFE3F2FD),
              child: Icon(icone, color: azul),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  if (subtitulo != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitulo,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ],
              ),
            ),
            Radio<FormaPagamento>(value: formaPagamento, activeColor: azul),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tela 4 - Confirmar recarga')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Valor escolhido', textAlign: TextAlign.center),
              const SizedBox(height: 8),
              Text(
                _valorFormatado,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              Text(
                'Data: ${widget.recarga.data.day.toString().padLeft(2, '0')}/'
                '${widget.recarga.data.month.toString().padLeft(2, '0')}/'
                '${widget.recarga.data.year}',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              const Text(
                'Forma de pagamento',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              RadioGroup<FormaPagamento>(
                groupValue: _pagamento.formaPagamento,
                onChanged: (valor) {
                  if (valor != null) _selecionarFormaPagamento(valor);
                },
                child: Column(
                  children: [
                    _opcaoPagamento(
                      formaPagamento: FormaPagamento.pix,
                      icone: Icons.phone_android,
                      titulo: 'Pix',
                      subtitulo: 'Aprovação imediata',
                    ),
                    const Divider(height: 1),
                    _opcaoPagamento(
                      formaPagamento: FormaPagamento.cartaoCredito,
                      icone: Icons.credit_card,
                      titulo: 'Cartão de crédito',
                      subtitulo: "Visa ",
                    ),
                    const Divider(height: 1),
                    _opcaoPagamento(
                      formaPagamento: FormaPagamento.boleto,
                      icone: Icons.receipt_long,
                      titulo: 'Boleto',
                    ),
                  ],
                ),
              ),
              if (_pagamento.formaPagamento == FormaPagamento.cartaoCredito) ...[
                const SizedBox(height: 16),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(16),
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Número do cartão',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  keyboardType: TextInputType.datetime,
                  decoration: const InputDecoration(
                    labelText: 'Validade',
                    hintText: 'MM/AA',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                  ],
                  decoration: const InputDecoration(
                    labelText: 'CVV',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Voltar'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => (),
                child: const Text('Pagar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
