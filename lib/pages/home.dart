// ignore_for_file: unused_import, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import '../theme/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text(
          "Página de Testes",
          style: TextStyle(
            fontFamily: 'SpaceGrotesk',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: DefaultTextStyle(
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Colors.black87,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Botões",
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontFamily: 'SpaceGrotesk',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                FilledButton(
                  onPressed: () {},
                  child: const Text("Botão Principal"),
                ),
                const SizedBox(height: 10),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text("Botão Secundário"),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {},
                  child: const Text("Botão de Texto"),
                ),

                const SizedBox(height: 30),
                Text(
                  "Campos de Texto",
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontFamily: 'SpaceGrotesk',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                const TextField(
                  decoration: InputDecoration(
                    labelText: "Nome do Produto",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 30),
                Text(
                  "Cores de Fundo",
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontFamily: 'SpaceGrotesk',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 50,
                  width: double.infinity,
                  color: theme.colorScheme.primary,
                  child: const Center(
                    child: Text(
                      "Cor Primária",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
                Text(
                  "Ícones",
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontFamily: 'SpaceGrotesk',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: const [
                    Icon(Symbols.home, size: 32),
                    SizedBox(width: 16),
                    Icon(Symbols.delivery_dining, size: 32),
                    SizedBox(width: 16),
                    Icon(Symbols.shopping_cart, size: 32),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
