import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class ClientHistoryPage extends StatefulWidget {
  const ClientHistoryPage({super.key});

  @override
  State<ClientHistoryPage> createState() => _ClientHistoryPageState();
}

class _ClientHistoryPageState extends State<ClientHistoryPage> {
  final Color highlightColor = const Color(0xFFFF6A00);
  int _currentIndex = 0;
  final bool _showUI = true;

  final List<Map<String, String>> _orders = [
    {
      'id': '#1342',
      'date': '15/07/2025 13:30',
      'origin': 'Av. Eduardo Mondlane',
      'destination': 'Game Matola',
      'transport': 'Carro',
      'duration': '20 min',
      'price': '150 MT',
      'image': 'assets/images/route_placeholder.png',
    },
    {
      'id': '#1343',
      'date': '14/07/2025 16:10',
      'origin': 'Av. Julius Nyerere',
      'destination': 'Shoprite Maputo',
      'transport': 'Motorizada',
      'duration': '15 min',
      'price': '90 MT',
      'image': 'assets/images/route_placeholder.png',
    },
  ];

  void _onTabTapped(int index) {
    setState(() => _currentIndex = index);
    if (index == 1) context.go('/cliente/client_home');
    if (index == 2) context.go('/cliente/client_profile');
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
          'Histórico',
          style: TextStyle(
            fontFamily: 'SpaceGrotesk',
            fontWeight: FontWeight.w700,
            color: highlightColor,
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            itemCount: _orders.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final order = _orders[index];
              return GestureDetector(
                onTap: () => context.go('/cliente/client_ordersummary'),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: highlightColor.withOpacity(0.4), width: 1),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 12,
                        runSpacing: 4,
                        children: [
                          _buildInlineDetail('ID', order['id']!),
                          _buildInlineDetail('Data', order['date']!),
                          _buildInlineDetail('Origem', order['origin']!),
                          _buildInlineDetail('Destino', order['destination']!),
                          _buildInlineDetail('Transporte', order['transport']!),
                          _buildInlineDetail('Duração', order['duration']!),
                          _buildInlineDetail('Valor', order['price']!),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: SizedBox(
                          height: 140,
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
                    ],
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 20,
            left: horizontalMargin,
            right: horizontalMargin,
            child: AnimatedOpacity(
              opacity: _showUI ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Container(
                height: 70,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
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
                    _buildNavItem(Symbols.history, 'Histórico', 0, _currentIndex == 0),
                    _buildNavItem(Symbols.home, 'Início', 1, _currentIndex == 1),
                    _buildNavItem(Symbols.person, 'Perfil', 2, _currentIndex == 2),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInlineDetail(String label, String value) {
    return Text.rich(
      TextSpan(
        text: '$label: ',
        style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w600),
        children: [
          TextSpan(
            text: value,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index, bool selected) {
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
