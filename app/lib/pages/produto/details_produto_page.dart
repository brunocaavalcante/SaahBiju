import 'dart:ui';

import 'package:app/core/date_ultils.dart';
import 'package:app/core/widget_ultil.dart';
import 'package:flutter/material.dart';

import '../../core/masks.dart';
import '../../models/produto.dart';
import 'cadastro_produto_page.dart';

class DatailsProdutoPage extends StatefulWidget {
  Produto produto;
  DatailsProdutoPage({super.key, required this.produto});

  @override
  State<DatailsProdutoPage> createState() => _DatailsProdutoPageState();
}

class _DatailsProdutoPageState extends State<DatailsProdutoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            tooltip: 'Editar',
            child: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CadastroProdutoPage(
                          produto: widget.produto,
                          operacao: "Editar Produto")));
            }),
        appBar: WidgetUltil.barWithArrowBackIos(context, ""),
        body: body());
  }

  body() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [ContainerImage(), ContainerInfo()]);

    //Container infos
  }

  ContainerImage() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: widget.produto.imagem == ""
          ? Image.asset("imagens/saah-biju-logo-sem-fundo.png",
              fit: BoxFit.cover)
          : Image.network(widget.produto.imagem ?? "", fit: BoxFit.cover),
    );
  }

  ContainerInfo() {
    return Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.55,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(widget.produto.nome,
              style:
                  const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Text(widget.produto.descricao,
              style:
                  TextStyle(fontSize: 20, color: Theme.of(context).hintColor)),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Text(FormatarMoeda.formatar(widget.produto.valor),
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).hintColor)),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          const Text("Estoque:",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Text(
              "Data cadastro: ${DateUltils.formatarData(widget.produto.dataCadastro)}",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).hintColor)),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Text("Código: ${widget.produto.codigo}",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).hintColor)),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Text("Custo: ${FormatarMoeda.formatar(widget.produto.valorCusto)}",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).hintColor)),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Text("Quantidade em estoque: 10",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).hintColor)),
        ]));
  }
}
