import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class DeliveryOrderSummaryPage extends StatelessWidget {
  final Color highlightColor = const Color(0xFFFF6A00);

  const DeliveryOrderSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.6),
        elevation: 0,
        title: const Text(
          'Resumo da Entrega',
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
          const _DetailRow(icon: Symbols.confirmation_number, text: 'ID da Entrega: #1342'),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FlutterMap(
                options: const MapOptions(
                  center: LatLng(-25.9692, 32.5732),
                  zoom: 13.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: const ['a', 'b', 'c'],
                    userAgentPackageName: 'com.example.app',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const _DetailRow(icon: Symbols.calendar_today, text: 'Data: 15/07/2025 às 13:30'),
          const _DetailRow(icon: Symbols.location_on, text: 'Origem: Av. Eduardo Mondlane'),
          const _DetailRow(icon: Symbols.flag, text: 'Destino: Game Matola'),
          const _DetailRow(icon: Symbols.local_shipping, text: 'Transporte: Carro'),
          const _DetailRow(icon: Symbols.timer, text: 'Tempo total: 20 min'),
          const SizedBox(height: 16),

          // Informações do cliente (em vez do entregador)
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
                  Text('Cliente: Inês Fernandes', style: TextStyle(color: Colors.white)),
                  Text('+258 82 456 7890', style: TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              )
            ],
          ),
          const SizedBox(height: 16),

          const _DetailRow(icon: Symbols.attach_money, text: 'Valor Recebido: 250MT'),
          const SizedBox(height: 16),
          const _DetailRow(icon: Symbols.notes, text: 'Observações: Urgente. Cliente solicita cuidado extra.'),
          const SizedBox(height: 24),

          const Text('Avaliação do Cliente', style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 8),
          Row(
            children: List.generate(5, (index) => const Icon(Symbols.star, color: Colors.amber)),
          ),
          const SizedBox(height: 16),
          const TextField(
            maxLines: 4,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Comentário do cliente...',
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

          // Botão final adaptado
          FilledButton(
            onPressed: () => context.go('/entregador/delivery_home'),
            style: FilledButton.styleFrom(
              backgroundColor: highlightColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            child: const Text('Fechar Resumo', style: TextStyle(color: Colors.white)),
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
          isDelivered ? ' Entrega concluída' : ' Entrega cancelada',
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
