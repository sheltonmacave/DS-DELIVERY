import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class ClientCreateOrderPage extends StatefulWidget {
  const ClientCreateOrderPage({super.key});

  @override
  State<ClientCreateOrderPage> createState() => _ClientCreateOrderPageState();
}

class _ClientCreateOrderPageState extends State<ClientCreateOrderPage> {
  final Color highlightColor = const Color(0xFFFF6A00);
  final Set<int> _selectedTransportIndices = {};

  final List<Map<String, dynamic>> _transports = [
    {
      'name': 'Motorizada',
      'description': 'Entregas Mais Rápidas',
      'price': '15MT/km',
      'image': 'assets/images/moto.png',
    },
    {
      'name': 'Carro',
      'description': 'Maior Capacidade de Carga',
      'price': '30MT/km',
      'image': 'assets/images/carro.png',
    },
  ];

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A).withOpacity(0.75),
                  border: Border.all(color: highlightColor, width: 1),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Symbols.info, color: highlightColor, size: 48),
                    const SizedBox(height: 16),
                    const Text(
                      'Tens a certeza que queres confirmar o pedido?',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    const Divider(color: Colors.white24),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white70,
                            backgroundColor: const Color(0xFF2A2A2A),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                          child: const Text('Não'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            context.go('/cliente/client_orderstate');
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: highlightColor,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                          child: const Text('Sim'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showOrderSummarySheet() {
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
            _buildBottomSheetRow(Symbols.location_on, 'Origem', 'Av. Julius Nyerere'),
            _buildBottomSheetRow(Symbols.flag, 'Destino', 'Shoprite Matola'),
            _buildBottomSheetRow(Symbols.local_shipping, 'Transporte', 'Motorizada'),
            _buildBottomSheetRow(Symbols.timer, 'Tempo Estimado', '20 min'),
            _buildBottomSheetRow(Symbols.attach_money, 'Valor Estimado', '150 MT'),
            _buildBottomSheetRow(Symbols.person, 'Nome do Cliente', 'Carlos M.'),
            _buildBottomSheetRow(Symbols.call, 'Contacto', '+258 84 123 4567'),
            const SizedBox(height: 24),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: highlightColor,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: _showConfirmationDialog,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Confirmar Pedido',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Icon(
                    Symbols.send_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSheetRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: highlightColor, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(color: Colors.white54, fontSize: 12)),
                const SizedBox(height: 2),
                Text(value, style: const TextStyle(color: Colors.white, fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70)),
          Text(value, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: const MapOptions(
              center: LatLng(-25.9692, 32.5732),
              zoom: 13.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png',
                subdomains: const ['a', 'b', 'c'],
                userAgentPackageName: 'com.example.app',
              ),
            ],
          ),
          SafeArea(
            child: AppBar(
              backgroundColor: Colors.black.withOpacity(0.6),
              elevation: 0,
              title: const Text(
                'Criar Pedido',
                style: TextStyle(
                  fontFamily: 'SpaceGrotesk',
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              leading: IconButton(
                icon: const Icon(Symbols.arrow_back, color: Colors.white),
                onPressed: () => context.go('/cliente/client_home'),
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.4,
            maxChildSize: 0.9,
            builder: (context, scrollController) => Container(
              padding: const EdgeInsets.fromLTRB(24, 2, 24, 24),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                border: Border.all(color: highlightColor.withOpacity(0.2)),
              ),
              child: ListView(
                controller: scrollController,
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
                  _buildLabeledInput(Symbols.location_on, 'Origem', 'Ex: Av. Julius Nyerere, Maputo', true),
                  const SizedBox(height: 16),
                  _buildLabeledInput(Symbols.flag, 'Destino', 'Ex: Shoprite, Matola', true),
                  const SizedBox(height: 16),
                  _buildLabeledInput(Symbols.notes, 'Observações', 'Informações adicionais', false, multiline: true),
                  const SizedBox(height: 24),
                  const Text(
                    'Tipo de Transporte',
                    style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 160,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _transports.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final transport = _transports[index];
                        final selected = _selectedTransportIndices.contains(index);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (selected) {
                                _selectedTransportIndices.remove(index);
                              } else {
                                _selectedTransportIndices.add(index);
                              }
                            });
                          },
                          child: Container(
                            width: 240,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF2A2A2A),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: selected ? highlightColor : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Image.asset(
                                    transport['image'],
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      transport['name'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      transport['description'],
                                      style: const TextStyle(
                                        color: Colors.white54,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      'Preço por KM:',
                                      style: TextStyle(color: Colors.white54, fontSize: 12),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      transport['price'],
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: highlightColor,
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: _showOrderSummarySheet,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Criar Pedido',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Icon(
                          Symbols.send_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabeledInput(IconData icon, String label, String placeholder, bool showMapButton, {bool multiline = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.white70),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
                  if (showMapButton)
                    TextButton.icon(
                      onPressed: () {},
                      icon: Icon(Symbols.map, color: highlightColor, size: 18),
                      label: const Text('Selecionar no mapa', style: TextStyle(color: Colors.white70)),
                      style: TextButton.styleFrom(minimumSize: Size.zero, padding: EdgeInsets.zero),
                    ),
                ],
              ),
              const SizedBox(height: 6),
              TextField(
                style: const TextStyle(color: Colors.white),
                maxLines: multiline ? 4 : 1,
                decoration: InputDecoration(
                  hintText: placeholder,
                  hintStyle: const TextStyle(color: Colors.white24),
                  filled: true,
                  fillColor: const Color(0xFF2A2A2A),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
