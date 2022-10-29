import 'package:app/core/widget_ultil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ConsultarProdutosPage extends StatefulWidget {
  const ConsultarProdutosPage({super.key});

  @override
  State<ConsultarProdutosPage> createState() => _ConsultarProdutosPageState();
}

class _ConsultarProdutosPageState extends State<ConsultarProdutosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUltil.barWithArrowBackIos(context, "Consultar Produtos"),
    );
  }
}
