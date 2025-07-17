import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class DeliveryOrderStatePage extends StatelessWidget {
  final Color highlightColor = const Color(0xFFFF6A00);

  const DeliveryOrderStatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.6),
        elevation: 0,
        title: const Text(
          'Estado da Entrega',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'SpaceGrotesk',
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Symbols.support_agent, color: highlightColor),
            onPressed: () => context.go('/entregador/delivery_support'),
          )
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: const MapOptions(
              center: LatLng(-25.9692, 32.5732),
              zoom: 13.0,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png',
                subdomains: const ['a', 'b', 'c'],
                userAgentPackageName: 'com.example.app',
              ),
            ],
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.6,
            maxChildSize: 0.95,
            builder: (context, scrollController) => Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                border: Border.all(color: highlightColor.withOpacity(0.2)),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: ListView(
                controller: scrollController,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: highlightColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  _buildProgressTimeline(context),
                  const SizedBox(height: 24),
                  _buildClientInfo(),
                  const SizedBox(height: 24),
                  _buildOrderDetails(context),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProgressTimeline(BuildContext context) {
    final List<String> etapas = [
      'Cheguei ao ponto de coleta',
      'Encomenda foi coletada',
      'Estou a caminho do destino',
      'Entreguei a encomenda',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: etapas.asMap().entries.map((entry) {
        int index = entry.key;
        String title = entry.value;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Icon(Symbols.circle, color: highlightColor, size: 16),
                  if (index != etapas.length - 1)
                    Container(width: 2, height: 40, color: highlightColor),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(color: Colors.white)),
                    const SizedBox(height: 4),
                    Text('Hora: --:--:--', style: const TextStyle(color: Colors.white30, fontSize: 12)),
                  ],
                ),
              ),
              FilledButton(
                onPressed: () {
                  _showConfirmationDialog(context, title: title, message: 'Confirmas esta etapa?');
                },
                style: FilledButton.styleFrom(
                  backgroundColor: highlightColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('Confirmar', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildClientInfo() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage('assets/images/avatar.jpg'),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Cliente: João C.', style: TextStyle(color: Colors.white)),
            const SizedBox(height: 4),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Symbols.call, color: Colors.white),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Symbols.sms, color: Colors.white),
                  onPressed: () {},
                )
              ],
            )
          ],
        )
      ],
    );
  }

  Widget _buildOrderDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _DetailRow(icon: Symbols.timer, text: 'Duração estimada: 20 min'),
        const _DetailRow(icon: Symbols.confirmation_number, text: 'ID: #1342'),
        const _DetailRow(icon: Symbols.calendar_today, text: 'Data: 15/07/2025 às 13:30'),
        const _DetailRow(icon: Symbols.location_on, text: 'Origem: Av. Eduardo Mondlane'),
        const _DetailRow(icon: Symbols.flag, text: 'Destino: Game Matola'),
        const _DetailRow(icon: Symbols.local_shipping, text: 'Veículo: Motorizada'),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: () => _showConfirmationDialog(
            context,
            title: 'Observações',
            message: 'Cliente solicita entrega rápida com manuseio cuidadoso.',
            showOnlyClose: true,
          ),
          style: FilledButton.styleFrom(
            backgroundColor: Colors.transparent,
            side: BorderSide(color: highlightColor),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text('Ver Observações', style: TextStyle(color: Colors.white)),
        ),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: () => _showConfirmationDialog(
            context,
            title: 'Cancelar Pedido',
            message: 'Tens a certeza que queres cancelar o pedido?',
            isCancel: true,
          ),
          style: FilledButton.styleFrom(
            backgroundColor: Colors.red.withOpacity(0.8),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Symbols.cancel, color: Colors.white),
              SizedBox(width: 8),
              Text('Cancelar Entrega', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ],
    );
  }

  void _showConfirmationDialog(BuildContext context, {
    required String title,
    required String message,
    bool isCancel = false,
    bool showOnlyClose = false,
  }) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.black.withOpacity(0.75),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: highlightColor, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isCancel ? Symbols.cancel : Symbols.info,
                color: highlightColor,
                size: 40,
              ),
              const SizedBox(height: 16),
              Text(title, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Text(message, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70)),
              const SizedBox(height: 20),
              if (showOnlyClose)
                FilledButton(
                  onPressed: () => Navigator.pop(context),
                  style: FilledButton.styleFrom(
                    backgroundColor: highlightColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Fechar', style: TextStyle(color: Colors.white)),
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancelar', style: TextStyle(color: Colors.white)),
                    ),
                    FilledButton(
                      onPressed: () {context.go('/entregador/delivery_orderslist');},
                      style: FilledButton.styleFrom(
                        backgroundColor: highlightColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Confirmar', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _DetailRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
