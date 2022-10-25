import 'package:app/core/widget_ultil.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../core/masks.dart';

class CadastroUserPage extends StatefulWidget {
  const CadastroUserPage({super.key});

  @override
  State<CadastroUserPage> createState() => _CadastroUserPageState();
}

class _CadastroUserPageState extends State<CadastroUserPage> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final dataNascimento = TextEditingController();
  final telefone = TextEditingController();
  final nome = TextEditingController();
  final senha = TextEditingController();
  final confirmSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double? espaco = 10;

    return Scaffold(
      appBar: WidgetUltil.barWithArrowBackIos(context, "Cadastro de Usuário"),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: espaco),
              returnField("Nome: ", nome, TextInputType.text, null, ""),
              SizedBox(height: espaco),
              returnField("Telefone: ", telefone, TextInputType.phone,
                  [Masks.telefoneFormatter], "(##) ##### - ####"),
              SizedBox(height: espaco),
              returnField("Data Nascimento: ", dataNascimento,
                  TextInputType.datetime, [Masks.dataFormatter], "##/##/####"),
              SizedBox(height: espaco),
              returnField(
                  "E-mail: ", email, TextInputType.emailAddress, null, ""),
              SizedBox(height: espaco),
              fieldSenha(),
              SizedBox(height: espaco),
              fieldConfirmSenha(),
              SizedBox(height: espaco),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {}
                },
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Icon(Icons.save),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text("Salvar", style: TextStyle(fontSize: 20)),
                  ),
                ]),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget returnField(String? label, TextEditingController ctr,
      TextInputType? type, List<MaskTextInputFormatter>? masks, String hint) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: label, border: OutlineInputBorder(), hintText: hint),
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

  Widget fieldSenha() {
    return TextFormField(
        obscureText: true,
        controller: senha,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
            border: OutlineInputBorder(), labelText: 'Senha:'),
        validator: (value) {
          if (value!.isEmpty) {
            return "Campo obrigatório";
          }
          if (value.length < 6) {
            return "Senha deve ter no minímo 6 caracteres.";
          }
          return null;
        });
  }

  Widget fieldConfirmSenha() {
    return TextFormField(
        obscureText: true,
        controller: confirmSenha,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
            border: OutlineInputBorder(), labelText: 'Confirmar senha:'),
        validator: (value) {
          if (value!.isEmpty) {
            return "Campo obrigatório";
          }
          if (value.length < 6) {
            return "Senha deve ter no minímo 6 caracteres.";
          }
          if (value != senha.text) return "Senhas diferentes!";
          return null;
        });
  }
}
