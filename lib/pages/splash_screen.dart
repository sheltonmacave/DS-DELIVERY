import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Espera 2 segundos e navega
    Future.delayed(const Duration(seconds: 2), () {
      context.go('/onboarding'); // ou "/" se quiseres direto
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: Center(
        child: Image.asset(
          'assets/images/logo_two.png', // troca para tua imagem
          width: 200,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
