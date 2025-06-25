import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:semeio_app/app/core/constants/color_constants.dart';

class Field extends StatelessWidget {
  const Field({
    super.key,
    required this.hintText,
    required this.controller,
    required this.width,
    this.formatter,
    this.validator,
    this.focusNode,
    this.readOnly,
  });
  final formatter;
  final hintText;
  final width;
  final validator;
  final controller;
  final focusNode;
  final readOnly;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      alignment: Alignment.center,
      width: width,
      child: TextFormField(
        style: const TextStyle(color: defaultCyan),
        textAlign: TextAlign.start,
        readOnly: readOnly ?? false,
        focusNode: focusNode,
        controller: controller,
        validator: validator,
        inputFormatters: formatter ?? [],
        decoration: InputDecoration(
            labelText: hintText,
            labelStyle: const TextStyle(
              color: defaultCyan,
              fontSize: 16,
            ),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: checkboxStroke),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            isDense: true,
            fillColor: readOnly != null ? defaultLightCyan : Colors.white,
            filled: true,
            hintStyle: const TextStyle(color: defaultCyan, fontSize: 20),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: checkboxStroke),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            hintText: hintText),
      ),
    );
  }
}
