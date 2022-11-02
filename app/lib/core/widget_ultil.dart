import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class WidgetUltil {
  static barWithArrowBackIos(BuildContext context, String title) {
    return AppBar(
        title: Text(title),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context, true);
            }));
  }

  static Widget returnField(String? label, TextEditingController ctr,
      TextInputType? type, List<MaskTextInputFormatter>? masks, String hint) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: label, border: const OutlineInputBorder(), hintText: hint),
      controller: ctr,
      inputFormatters: masks,
      keyboardType: type,
      validator: (value) {
        if (value!.isEmpty) {
          return "Campo obrigatório";
        }
        return null;
      },
    );
  }
}
