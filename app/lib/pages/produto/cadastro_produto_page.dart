import 'package:app/core/widget_ultil.dart';
import 'package:app/core/widgets/file_widget.dart';
import 'package:app/models/produto.dart';
import 'package:app/services/file_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../core/masks.dart';
import '../../models/custom_exception.dart';
import '../../services/produto_service.dart';

class CadastroProdutoPage extends StatefulWidget {
  Produto produto;
  CadastroProdutoPage({super.key, required this.produto});

  @override
  State<CadastroProdutoPage> createState() => _CadastroProdutoPageState();
}

class _CadastroProdutoPageState extends State<CadastroProdutoPage> {
  final formKey = GlobalKey<FormState>();
  final nome = TextEditingController();
  final codigo = TextEditingController();
  final descricao = TextEditingController();
  final valor = TextEditingController();
  final imagem = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: WidgetUltil.barWithArrowBackIos(context, "Cadastro de Produto"),
        body: body());
  }

  body() {
    double? espaco = 10;
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            FileWidget(urlImagem: "", destino: 'produtos'),
            SizedBox(height: espaco),
            WidgetUltil.returnField(
                "Código: ", codigo, TextInputType.number, null, ""),
            SizedBox(height: espaco),
            WidgetUltil.returnField(
                "Nome: ", nome, TextInputType.name, null, ""),
            SizedBox(height: espaco),
            WidgetUltil.returnField(
                "Descrição: ", descricao, TextInputType.text, null, ""),
            SizedBox(height: espaco),
            WidgetUltil.returnField(
                "Valor: ",
                valor,
                TextInputType.number,
                [
                  FilteringTextInputFormatter.digitsOnly,
                  CurrencyInputFormatter()
                ],
                'R\$ 0,00'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  editarProduto();
                }
              },
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.save),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text("Salvar", style: TextStyle(fontSize: 20)),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    ));
  }

  editarProduto() async {
    setState(() => loading = true);

    try {
      var produto = Produto();
      produto.nome = nome.text;
      produto.descricao = descricao.text;
      produto.imagem = context.read<FileService>().destino;
      produto.codigo = codigo.text;
      produto.dataCadastro = DateTime.now();
      produto.CoverterValorToDecimal(valor.text);
      await context.read<ProdutoService>().salvar(produto);

      Navigator.pop(context, true);
    } on CustomException catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }
}
