import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:go_router/go_router.dart';

class DeliveryAuthPage extends StatefulWidget {
  const DeliveryAuthPage({super.key});

  @override
  State<DeliveryAuthPage> createState() => _DeliveryAuthPageState();
}

class _DeliveryAuthPageState extends State<DeliveryAuthPage> {
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
                context.go('/entregador/delivery_home');
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

class _PhotoPickerField extends StatelessWidget {
  const _PhotoPickerField();

  @override
  Widget build(BuildContext context) {
    final highlightColor = const Color(0xFFFF6A00);
    return GestureDetector(
      onTap: () {
        // TODO: lógica para escolher a imagem
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white24),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(Symbols.image, color: highlightColor),
            const SizedBox(width: 12),
            const Text(
              'Selecionar Foto',
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}

class _DropdownField extends StatefulWidget {
  final String label;
  final IconData icon;
  final List<String> options;

  const _DropdownField({
    required this.label,
    required this.icon,
    required this.options,
  });

  @override
  State<_DropdownField> createState() => _DropdownFieldState();
}

class _DropdownFieldState extends State<_DropdownField> {
  String? selectedValue;
  final highlightColor = const Color(0xFFFF6A00);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        dropdownColor: const Color(0xFF1C1C1C),
        iconEnabledColor: Colors.white70,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: TextStyle(color: Colors.white70),
          prefixIcon: Icon(widget.icon, color: Colors.white54),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.white30),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: highlightColor, width: 2),
          ),
        ),
        items: widget.options
            .map((value) => DropdownMenuItem(
                  value: value,
                  child: Text(value),
                ))
            .toList(),
        onChanged: (value) => setState(() => selectedValue = value),
      ),
    );
  }
}

class _ColorPickerDropdown extends StatefulWidget {
  const _ColorPickerDropdown();

  @override
  State<_ColorPickerDropdown> createState() => _ColorPickerDropdownState();
}

class _ColorPickerDropdownState extends State<_ColorPickerDropdown> {
  final highlightColor = const Color(0xFFFF6A00);
  String? selectedColor;
  final Map<String, Color> colorMap = {
    'Preto': Colors.black,
    'Branco': Colors.white,
    'Cinzento': Colors.grey,
    'Vermelho': Colors.red,
    'Azul': Colors.blue,
    'Verde': Colors.green,
    'Amarelo': Colors.yellow,
    'Laranja': Colors.orange,
    'Roxo': Colors.purple,
  };

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedColor,
      dropdownColor: const Color(0xFF1C1C1C),
      iconEnabledColor: Colors.white70,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: 'Cor do Veículo',
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon: const Icon(Symbols.palette, color: Colors.white54),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white30),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: highlightColor, width: 2),
        ),
      ),
      items: colorMap.entries
          .map((entry) => DropdownMenuItem(
                value: entry.key,
                child: Row(
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: entry.value,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.white24),
                      ),
                    ),
                    Text(entry.key),
                  ],
                ),
              ))
          .toList(),
      onChanged: (value) => setState(() => selectedColor = value),
    );
  }
}


class _RegisterSection extends StatelessWidget {
  const _RegisterSection();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        SizedBox(height: 16),
        _PhotoPickerField(),
        SizedBox(height: 16),
        _DropdownField(
          label: 'Zona de atuação',
          icon: Symbols.location_on,
          options: [
            'Maputo Cidade',
            'Maputo Província',
            'Gaza',
            'Inhambane',
            'Sofala',
            'Manica',
            'Tete',
            'Zambézia',
            'Nampula',
            'Niassa',
            'Cabo Delgado',
          ],
        ),
        _DropdownField(
          label: 'Tipo de Transporte',
          icon: Symbols.emoji_transportation,
          options: ['Motorizada', 'Carro'],
        ),
        _InputField(label: 'Marca', icon: Symbols.directions_car),
        _InputField(label: 'Modelo', icon: Symbols.build),
        _InputField(label: 'Matrícula', icon: Symbols.confirmation_number),
        _ColorPickerDropdown(),
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