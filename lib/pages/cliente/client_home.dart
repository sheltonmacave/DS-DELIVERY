import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

class ClientHomePage extends StatefulWidget {
  const ClientHomePage({super.key});

  @override
  State<ClientHomePage> createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {
  late VideoPlayerController _videoController;
  late Timer _timer;
  bool _showGreeting = true;
  bool _showUI = true;
  int _currentIndex = 1;

  final Color highlightColor = const Color(0xFFFF6A00);

  @override
  void initState() {
    super.initState();

    _videoController = VideoPlayerController.asset('assets/videos/sondella.mp4')
      ..initialize().then((_) {
        setState(() {});
        _videoController.setLooping(true);
        _videoController.setVolume(0);
        _videoController.play();
      }).catchError((e) {
        debugPrint("Erro ao carregar vídeo: \$e");
      });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        if (mounted) {
          setState(() {
            _showGreeting = !_showGreeting;
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _videoController.dispose();
    _timer.cancel();
    super.dispose();
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 6 && hour < 12) return 'Bom dia';
    if (hour >= 12 && hour < 18) return 'Boa tarde';
    if (hour >= 18 && hour <= 23) return 'Boa noite';
    return 'Boa madrugada';
  }

  void _onTabTapped(int index) {
    setState(() => _currentIndex = index);
    switch (index) {
      case 0:
        context.go('/cliente/client_history');
        break;
      case 1:
        context.go('/cliente/client_home');
        break;
      case 2:
        context.go('/cliente/client_profile');
        break;
    }
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

  @override
  Widget build(BuildContext context) {
    final double horizontalMargin = MediaQuery.of(context).size.width * 0.05;

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F0F),
        title: Text(
          _showGreeting ? _getGreeting() : 'DS Delivery',
          style: TextStyle(
            color: highlightColor,
            fontFamily: 'SpaceGrotesk',
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(_showUI ? Symbols.visibility_off : Symbols.visibility, color: highlightColor),
            onPressed: () => setState(() => _showUI = !_showUI),
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
                urlTemplate: 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png',
                subdomains: const ['a', 'b', 'c'],
                userAgentPackageName: 'com.exemplo.app',
              ),
            ],
          ),

          AnimatedOpacity(
            opacity: _showUI ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Chame Um Motorista Onde Estiveres!',
                    style: TextStyle(
                      fontFamily: 'SpaceGrotesk',
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),

                  FilledButton(
                    onPressed: () {
                      context.go('/cliente/client_createorder');
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: highlightColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Symbols.add_circle, color: Colors.white, size: 26),
                        SizedBox(width: 8),
                        Text(
                          'Criar Pedido',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: _videoController.value.isInitialized
                          ? VideoPlayer(_videoController)
                          : Container(
                              color: Colors.white10,
                              child: Center(
                                child: CircularProgressIndicator(color: highlightColor),
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
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
                    _buildNavItem(Symbols.history, 'Histórico', 0, _currentIndex == 0, highlightColor),
                    _buildNavItem(Symbols.home, 'Início', 1, _currentIndex == 1, highlightColor),
                    _buildNavItem(Symbols.person, 'Perfil', 2, _currentIndex == 2, highlightColor),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}