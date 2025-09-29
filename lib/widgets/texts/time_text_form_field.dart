import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/theme/provider/theme_provider.dart';

class AppTimePickerField extends StatefulWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final bool isRequired;

  const AppTimePickerField({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.isRequired = false,
  });

  @override
  State<AppTimePickerField> createState() => _AppTimePickerFieldState();
}

class _AppTimePickerFieldState extends State<AppTimePickerField> {
  Future<void> _pickTime(BuildContext context, bool dark) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input,
      builder: (context, child) {
        final scheme = dark
            ? const ColorScheme.dark(
          primary: AppColors.blue,
          onPrimary: Colors.white,
          surface: Color(0xFF121212),
          onSurface: Colors.white,
        )
            : const ColorScheme.light(
          primary: AppColors.orange,
          onPrimary: Colors.white,
          surface: Colors.white,
          onSurface: Colors.black,
        );
        return Theme(
          data: Theme.of(context).copyWith(colorScheme: scheme),
          child: child!,
        );
      },
    );

    if (pickedTime != null && widget.controller != null) {
      final formattedTime = pickedTime.format(context); // Example: 10:30 AM
      widget.controller!.text = formattedTime;
      widget.onChanged?.call(formattedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = context.watch<ThemeProvider>().isDarkMode;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        _pickTime(context, dark);
      },
      child: AbsorbPointer(
        child: TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onFieldSubmitted,
          readOnly: true,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            label: RichText(
              text: TextSpan(
                text: widget.label,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
                children: widget.isRequired
                    ? const [
                  TextSpan(
                    text: ' *',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ]
                    : [],
              ),
            ),
            hintText: widget.hint,
            suffixIcon: const Icon(FontAwesomeIcons.clock, size: 18),
          ),
        ),
      ),
    );
  }
}
