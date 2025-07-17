import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:go_router/go_router.dart';

class ClientProfilePage extends StatefulWidget {
  const ClientProfilePage({super.key});

  @override
  State<ClientProfilePage> createState() => _ClientProfilePageState();
}

class _ClientProfilePageState extends State<ClientProfilePage> {
  final Color highlightColor = const Color(0xFFFF6A00);
  int _currentIndex = 2;

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

  void _openEditSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
            _buildInputField('Nome'),
            _buildInputField('Número'),
            _buildInputField('Email'),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => Navigator.pop(context),
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
                  Icon(Symbols.save, color: Colors.white, size: 20),
                  SizedBox(width: 8),
                  Text('Guardar Alterações', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.white30),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: highlightColor, width: 2),
          ),
        ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F0F),
        title: Text(
          'Perfil',
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
            icon: Icon(Symbols.edit, color: highlightColor),
            onPressed: _openEditSheet,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/avatar.jpg'),
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Symbols.person, color: Colors.white70, size: 20),
                SizedBox(width: 8),
                Text('Cliente', style: TextStyle(color: Colors.white70)),
              ],
            ),
            const SizedBox(height: 8),
            const Text('Na plataforma há 3 meses', style: TextStyle(color: Colors.white38)),
            const SizedBox(height: 24),
            const ListTile(
              leading: Icon(Symbols.badge, color: Colors.white),
              title: Text('Shelton Macave', style: TextStyle(color: Colors.white)),
            ),
            const ListTile(
              leading: Icon(Symbols.phone, color: Colors.white),
              title: Text('+258 84 123 4567', style: TextStyle(color: Colors.white)),
            ),
            const ListTile(
              leading: Icon(Symbols.mail, color: Colors.white),
              title: Text('shelton@email.com', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text('Área Perigosa', style: TextStyle(color: Color.fromARGB(255, 168, 168, 168))),
            ),
            const Divider(color: Color.fromARGB(255, 168, 168, 168)),
            const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Symbols.logout, color: Colors.white),
              label: const Text('Logout', style: TextStyle(color: Colors.white)),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.redAccent,
                minimumSize: const Size(200, 48),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Symbols.delete_forever, color: Colors.white),
              label: const Text('Eliminar Perfil', style: TextStyle(color: Colors.white)),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(200, 48),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
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
    );
  }
}
