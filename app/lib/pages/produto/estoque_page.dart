import 'package:app/core/widget_ultil.dart';
import 'package:flutter/material.dart';

class EstoquePage extends StatefulWidget {
  const EstoquePage({super.key});

  @override
  State<EstoquePage> createState() => _EstoquePageState();
}

class _EstoquePageState extends State<EstoquePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            WidgetUltil.barWithArrowBackIos(context, "Estoque de Produtos"));
  }
}
