import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class DeliveryOrdersListPage extends StatefulWidget {
  const DeliveryOrdersListPage({super.key});

  @override
  State<DeliveryOrdersListPage> createState() => _DeliveryOrdersListPageState();
}

class _DeliveryOrdersListPageState extends State<DeliveryOrdersListPage> {
  final Color highlightColor = const Color(0xFFFF6A00);
  int _currentIndex = 1;
  final bool _showUI = true;

  final List<Map<String, String>> _orders = [
    {
      'id': '#2001',
      'origin': 'Bairro Central, Maputo',
      'destination': 'Matola A',
      'distance': '12 km',
      'price': '200 MT',
      'duration': '25 min',
      'transport': 'Motorizada',
      'notes': 'Entregar antes das 15h. Cliente estará à porta.',
    },
    {
      'id': '#2002',
      'origin': 'Costa do Sol',
      'destination': 'Baixa Maputo',
      'distance': '8 km',
      'price': '150 MT',
      'duration': '18 min',
      'transport': 'Carro',
      'notes': 'Carga frágil. Evitar buracos.',
    },
  ];

  void _onTabTapped(int index) {
    setState(() => _currentIndex = index);
    switch (index) {
      case 0:
        context.go('/entregador/delivery_history');
        break;
      case 1:
        context.go('/entregador/delivery_orderslist');
        break;
      case 2:
        context.go('/entregador/delivery_home');
        break;
      case 3:
        context.go('/entregador/delivery_profile');
        break;
    }
  }

  void _showOrderDetails(Map<String, String> order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: highlightColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Wrap(
              spacing: 16,
              runSpacing: 12,
              children: [
                _buildDetail(Symbols.confirmation_number, 'ID', order['id']!),
                _buildDetail(Symbols.location_on, 'Origem', order['origin']!),
                _buildDetail(Symbols.flag, 'Destino', order['destination']!),
                _buildDetail(Symbols.route, 'Distância', order['distance']!),
                _buildDetail(Symbols.access_time, 'Duração', order['duration']!),
                _buildDetail(Symbols.directions_car, 'Transporte', order['transport']!),
                _buildDetail(Symbols.attach_money, 'Valor', order['price']!),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Observações:', style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text(order['notes']!, style: const TextStyle(color: Colors.white, fontSize: 14)),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 160,
                child: FlutterMap(
                  options: const MapOptions(
                    center: LatLng(-25.9692, 32.5732),
                    zoom: 12,
                    interactiveFlags: InteractiveFlag.none,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: const ['a', 'b', 'c'],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {context.go('/entregador/delivery_orderstate');},
                style: FilledButton.styleFrom(
                  backgroundColor: highlightColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('Aceitar Pedido', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDetail(IconData icon, String label, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: highlightColor, size: 18),
        const SizedBox(width: 6),
        Text('$label: ', style: const TextStyle(color: Colors.white70, fontSize: 13)),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 13)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const double horizontalMargin = 20;

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.6),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Pedidos Disponíveis',
          style: TextStyle(
            fontFamily: 'SpaceGrotesk',
            fontWeight: FontWeight.w700,
            color: highlightColor,
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        itemCount: _orders.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final order = _orders[index];
          return Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: highlightColor.withOpacity(0.4), width: 1),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetail(Symbols.confirmation_number, 'ID', order['id']!),
                _buildDetail(Symbols.location_on, 'Origem', order['origin']!),
                _buildDetail(Symbols.flag, 'Destino', order['destination']!),
                _buildDetail(Symbols.route, 'Distância', order['distance']!),
                _buildDetail(Symbols.access_time, 'Duração', order['duration']!),
                _buildDetail(Symbols.directions_car, 'Transporte', order['transport']!),
                _buildDetail(Symbols.attach_money, 'Valor', order['price']!),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () => _showOrderDetails(order),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color.fromARGB(255, 165, 165, 165),
                        side: BorderSide(color: highlightColor),
                      ),
                      child: const Text('Ver Detalhes'),
                    ),
                    FilledButton(
                      onPressed: () {context.go('/entregador/delivery_orderstate');},
                      style: FilledButton.styleFrom(backgroundColor: highlightColor),
                      child: const Text('Aceitar Pedido', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: AnimatedOpacity(
        opacity: _showUI ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: Container(
          margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
          height: 70,
          decoration: BoxDecoration(
            color: const Color.fromARGB(200, 15, 15, 15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: highlightColor, width: 1),
            boxShadow: [
              BoxShadow(
                color: highlightColor.withAlpha(100),
                blurRadius: 12,
                spreadRadius: 2,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(Symbols.history, 'Histórico', 0, _currentIndex == 0, highlightColor),
              _buildNavItem(Symbols.list_alt, 'Pedidos', 1, _currentIndex == 1, highlightColor),
              _buildNavItem(Symbols.home, 'Início', 2, _currentIndex == 2, highlightColor),
              _buildNavItem(Symbols.person, 'Perfil', 3, _currentIndex == 3, highlightColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index, bool selected, Color highlightColor) {
    return GestureDetector(
      onTap: () => _onTabTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: selected ? highlightColor : Colors.white54),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: selected ? highlightColor : Colors.white54,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
