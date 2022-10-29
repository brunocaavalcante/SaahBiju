import 'package:app/core/widget_ultil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CadastroProdutoPage extends StatefulWidget {
  const CadastroProdutoPage({super.key});

  @override
  State<CadastroProdutoPage> createState() => _CadastroProdutoPageState();
}

class _CadastroProdutoPageState extends State<CadastroProdutoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            WidgetUltil.barWithArrowBackIos(context, "Cadastro de Produto"));
  }
}
