import 'package:app/core/widget_ultil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../core/masks.dart';
import '../../models/produto.dart';
import 'details_produto_page.dart';

class ConsultarProdutosPage extends StatefulWidget {
  const ConsultarProdutosPage({super.key});

  @override
  State<ConsultarProdutosPage> createState() => _ConsultarProdutosPageState();
}

class _ConsultarProdutosPageState extends State<ConsultarProdutosPage> {
  String nome = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUltil.barWithArrowBackIos(context, "Consultar Produtos"),
      body: body(),
    );
  }

  body() {
    return Column(children: [
      Container(padding: const EdgeInsets.all(15), child: barraConsulta()),
      SizedBox(
          height: MediaQuery.of(context).size.height * .75,
          width: MediaQuery.of(context).size.width * .9,
          child: listaProdutos())
    ]);
  }

  listaProdutos() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('produtos').snapshots(),
        builder: (context, snapshots) {
          return (snapshots.connectionState == ConnectionState.waiting)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: snapshots.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshots.data!.docs[index].data()
                        as Map<String, dynamic>;

                    data["id"] = snapshots.data!.docs[index].id;
                    var produto = Produto().toEntity(data);

                    if (nome.isEmpty) {
                      return item(produto);
                    }
                    if (produto.nome
                        .toString()
                        .toLowerCase()
                        .startsWith(nome.toLowerCase())) {
                      return item(produto);
                    }
                    return Container();
                  });
        });
  }

  item(Produto produto) {
    return SizedBox(
        height: 100,
        child: Card(
            margin: const EdgeInsets.only(bottom: 20),
            child: ListTile(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          DatailsProdutoPage(produto: produto))),
              title: Text(
                produto.nome,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                FormatarMoeda.formatar(produto.valor),
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              leading: Container(
                  width: 70,
                  height: 70,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: produto.imagem == ""
                      ? Image.asset("imagens/saah-biju-logo-sem-fundo.png",
                          fit: BoxFit.cover)
                      : Image.network(produto.imagem, fit: BoxFit.cover)),
            )));
  }

  Widget barraConsulta() {
    return TextField(
        decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search, size: 35),
            border: OutlineInputBorder(),
            hintText: "Procurar..."),
        onChanged: (val) {
          setState(() {
            nome = val;
          });
        });
  }
}
