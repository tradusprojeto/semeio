import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:semeio_app/app/core/constants/color_constants.dart';

class FieldLabelEdge extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final double width;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? formatter;

  final double? fontSize;

  const FieldLabelEdge({
    super.key,
    required this.hintText,
    required this.controller,
    required this.width,
    this.validator,
    this.formatter,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 40,
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: defaultCyan, fontSize: 14),
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle: TextStyle(
            color: defaultCyan,
            fontSize: fontSize,
          ),
          isDense: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: checkboxStroke, // Cor da borda quando não está focado
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: checkboxStroke, // Cor da borda quando o campo está focado
              width: 2.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.red, // Cor da borda quando há erro de validação
              width: 1.5,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.grey, // Cor da borda quando o campo está desativado
              width: 1.0,
            ),
          ),
        ),
        validator: validator,
        inputFormatters: formatter ?? [],
      ),
    );
  }
}
