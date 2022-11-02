import 'package:app/pages/produto/cadastro_produto_page.dart';
import 'package:app/pages/produto/consultar_produtos_page.dart';
import 'package:app/pages/produto/estoque_page.dart';
import 'package:flutter/material.dart';

import '../../core/widget_ultil.dart';
import '../../core/widgets/main_drawer.dart';
import '../../models/produto.dart';

class HomeProdutoPage extends StatefulWidget {
  const HomeProdutoPage({super.key});

  @override
  State<HomeProdutoPage> createState() => _HomeProdutoPageState();
}

class _HomeProdutoPageState extends State<HomeProdutoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: WidgetUltil.barWithArrowBackIos(context, "Produtos"),
        drawer: const MainDrawer(),
        body: body());
  }

  body() {
    return Column(children: [
      Row(children: [
        itenMenu(
            Icons.search, "Consultar produtos", const ConsultarProdutosPage()),
        itenMenu(Icons.inventory, "Estoque", const EstoquePage())
      ]),
      SizedBox(height: MediaQuery.of(context).size.height * 0.05),
      Row(children: [
        itenMenu(Icons.new_label, "Cadastrar Produto",
            CadastroProdutoPage(produto: Produto())),
      ])
    ]);
  }

  itenMenu(IconData ic, String text, Widget page) {
    double space = MediaQuery.of(context).size.width * 0.07;

    return GestureDetector(
        onTap: () async {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => page));
        },
        child: Container(
            margin: EdgeInsets.only(left: space, right: space, top: space),
            child: Column(children: [
              Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.85),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30.0))),
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.height * 0.12,
                  child: Icon(ic, size: 55, color: Colors.white)),
              Text(
                text,
                style:
                    TextStyle(fontSize: 19, color: Theme.of(context).hintColor),
              )
            ])));
  }
}
