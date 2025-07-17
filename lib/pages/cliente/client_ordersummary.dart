import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class ClientOrderSummaryPage extends StatelessWidget {
  final Color highlightColor = const Color(0xFFFF6A00);

  const ClientOrderSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.6),
        elevation: 0,
        title: const Text(
          'Resumo do Pedido',
          style: TextStyle(
            fontFamily: 'SpaceGrotesk',
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildStatusRow(isDelivered: true),
          const SizedBox(height: 12),
          const _DetailRow(icon: Symbols.confirmation_number, text: 'ID do Pedido: #1342'),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                height: 140, // ou o tamanho que quiseres
                child: FlutterMap(
                  options: const MapOptions(
                    center: LatLng(-25.9692, 32.5732),
                    zoom: 13.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: const ['a', 'b', 'c'],
                      userAgentPackageName: 'com.example.app',
                    ),
                  ],
                ),
              ),
            )

          ),
          const SizedBox(height: 16),
          const _DetailRow(icon: Symbols.calendar_today, text: 'Data: 15/07/2025 às 13:30'),
          const _DetailRow(icon: Symbols.location_on, text: 'Origem: Av. Eduardo Mondlane'),
          const _DetailRow(icon: Symbols.flag, text: 'Destino: Game Matola'),
          const _DetailRow(icon: Symbols.local_shipping, text: 'Transporte: Carro'),
          const _DetailRow(icon: Symbols.timer, text: 'Tempo total: 20 min'),
          const SizedBox(height: 16),
          const Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/images/avatar.jpg'),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Entregador: Shelton Macave', style: TextStyle(color: Colors.white)),
                  Text('+258 84 123 4567', style: TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              )
            ],
          ),
          const SizedBox(height: 16),
          const _DetailRow(icon: Symbols.attach_money, text: 'Valor Pago: 250MT'),
          const SizedBox(height: 16),
          const _DetailRow(icon: Symbols.notes, text: 'Observações: Urgente. Cliente solicita cuidado extra.'),
          const SizedBox(height: 24),
          const Text('Avaliação', style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 8),
          Row(
            children: List.generate(5, (index) => const Icon(Symbols.star_border, color: Colors.amber)),
          ),
          const SizedBox(height: 16),
          const TextField(
            maxLines: 4,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Comentário sobre a experiência...',
              hintStyle: TextStyle(color: Colors.white24),
              filled: true,
              fillColor: Color(0xFF2A2A2A),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () => context.go('/cliente/client_home'),
            style: FilledButton.styleFrom(
              backgroundColor: highlightColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            child: const Text('Fechar', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }

  Widget _buildStatusRow({required bool isDelivered}) {
    return Row(
      children: [
        Icon(
          isDelivered ? Symbols.check_circle : Symbols.cancel,
          color: isDelivered ? Colors.green : Colors.red,
          size: 24,
        ),
        const SizedBox(width: 8),
        Text(
          isDelivered ? ' Entregue' : ' Cancelado',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ],
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
