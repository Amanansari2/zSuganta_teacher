import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/theme/provider/theme_provider.dart';

class AppDatePickerField extends StatefulWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final bool isRequired;

  const AppDatePickerField({
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
  State<AppDatePickerField> createState() => _AppDatePickerFieldState();
}

class _AppDatePickerFieldState extends State<AppDatePickerField> {
  Future<void> _pickDate(BuildContext context, bool dark) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        final scheme = dark
            ?  ColorScheme.dark(
          primary: AppColors.blue,
          onPrimary: Colors.white,
          surface: Color(0xFF121212),
          onSurface: Colors.white,
        )
            :  ColorScheme.light(
          primary: AppColors.orange,
          onPrimary: Colors.white,
          surface: Colors.white,
          onSurface: Colors.black,
        );
        return Theme(
          data:  Theme.of(context).copyWith(colorScheme: scheme),
          child: child!,
        );
      },
    );

    if (pickedDate != null && widget.controller != null) {
      widget.controller!.text =
      "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
      widget.onChanged?.call(widget.controller!.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = context.watch<ThemeProvider>().isDarkMode;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        _pickDate(context, dark);
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
                    ? [
                  const TextSpan(
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
            suffixIcon: const Icon(FontAwesomeIcons.calendarCheck, size: 18),
          ),
        ),
      ),
    );
  }
}
