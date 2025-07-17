import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:go_router/go_router.dart';

class ClientAuthPage extends StatefulWidget {
  const ClientAuthPage({super.key});

  @override
  State<ClientAuthPage> createState() => _ClientAuthPageState();
}

class _ClientAuthPageState extends State<ClientAuthPage> {
  final highlightColor = const Color(0xFFFF6A00);

  bool isLoginTab = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFF0F0F0F),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0F0F0F),
          leading: IconButton(
            icon: const Icon(Symbols.arrow_back, color: Colors.white),
            onPressed: () => context.go('/account_selection'),
          ),
          title: const Text(
            'DS Delivery',
            style: TextStyle(
              color: Color(0xFFFF6A00),
              fontFamily: 'SpaceGrotesk',
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color.fromARGB(80, 255, 255, 255), width: 0.5),
                  ),
                ),
                child: TabBar(
                  onTap: (index) => setState(() => isLoginTab = index == 1),
                  labelColor: highlightColor,
                  unselectedLabelColor: Colors.white54,
                  indicatorColor: highlightColor,
                  tabs: const [
                    Tab(text: 'Registrar'),
                    Tab(text: 'Login'),
                  ],
                ),
              ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Image.asset(
                isLoginTab ? 'assets/images/login.png' : 'assets/images/cliente.png',
                height: 120,
              ),
              const SizedBox(height: 16),
              Text(
                isLoginTab ? 'Login como Cliente' : 'Registro como Cliente',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: TabBarView(
                  children: [
                    _RegisterSection(),
                    _LoginSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 6, top: 6),
            child: FilledButton(
              onPressed: () {
                context.go('/cliente/client_home');
              },
              style: FilledButton.styleFrom(
                backgroundColor: highlightColor,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isLoginTab ? 'Login' : 'Registrar',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const Icon(
                    Symbols.check,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RegisterSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        SizedBox(height: 16),
        _InputField(label: 'Nome', icon: Symbols.person),
        _InputField(label: 'E-mail', icon: Symbols.mail),
        _InputField(label: 'Número', icon: Symbols.phone),
        _InputField(label: 'Senha', icon: Symbols.lock, obscure: true),
        _InputField(label: 'Confirmação de Senha', icon: Symbols.lock_reset, obscure: true),
      ],
    );
  }
}

class _LoginSection extends StatefulWidget {
  @override
  State<_LoginSection> createState() => _LoginSectionState();
}

class _LoginSectionState extends State<_LoginSection> {
  bool forgotPassword = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 16),
        const _InputField(label: 'Número / E-mail', icon: Symbols.mail),
        const _InputField(label: 'Senha', icon: Symbols.lock, obscure: true),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => setState(() => forgotPassword = !forgotPassword),
            child: const Text(
              'Esqueci a senha',
              style: TextStyle(color: Colors.white70),
            ),
          ),
        ),
        if (forgotPassword) ...[
          const _InputField(label: 'Número', icon: Symbols.phone),
          _OtpButtonRow(),
          const _InputField(label: 'Código OTP', icon: Symbols.lock_clock),
          const SizedBox(height: 8),
          const _ValidateButton(),
        ],
        const SizedBox(height: 24),
        const _GoogleLoginRow(),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _InputField extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool obscure;

  const _InputField({
    required this.label,
    required this.icon,
    this.obscure = false,
  });

  @override
  State<_InputField> createState() => __InputFieldState();
}

class __InputFieldState extends State<_InputField> {
  final TextEditingController _controller = TextEditingController();
  final Color highlightColor = const Color(0xFFFF6A00);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: _controller,
        obscureText: widget.obscure,
        style: const TextStyle(color: Colors.white),
        cursorColor: highlightColor,
        onChanged: (_) => setState(() {}),
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: TextStyle(
            color: _controller.text.isNotEmpty ? highlightColor : Colors.white70,
          ),
          prefixIcon: Icon(widget.icon, color: _controller.text.isNotEmpty ? highlightColor : Colors.white54),
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
}

class _OtpButtonRow extends StatelessWidget {
  final Color highlightColor = const Color(0xFFFF6A00);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: highlightColor),
            foregroundColor: highlightColor,
          ),
          child: const Text('Enviar OTP'),
        ),
        TextButton(
          onPressed: () {},
          child: Text('Reenviar código', style: TextStyle(color: highlightColor)),
        ),
      ],
    );
  }
}

class _ValidateButton extends StatelessWidget {
  const _ValidateButton();

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: () {},
      icon: const Icon(Symbols.verified, color: Colors.white),
      label: const Text('Validar', style: TextStyle(color: Colors.white)),
      style: FilledButton.styleFrom(
        backgroundColor: const Color(0xFFFF6A00),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}

class _GoogleLoginRow extends StatelessWidget {
  const _GoogleLoginRow();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: Image.asset(
          'assets/icon/google.png',
          height: 20,
          width: 20,
        ),
        label: const Text("Google"),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.white24),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
      ),
    );
  }
}