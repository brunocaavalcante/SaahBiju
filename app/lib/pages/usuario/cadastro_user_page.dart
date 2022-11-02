import 'package:app/core/widget_ultil.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import '../../core/date_ultils.dart';
import '../../core/masks.dart';
import '../../models/custom_exception.dart';
import '../../models/usuario.dart';
import '../../services/usuario_service.dart';

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
              WidgetUltil.returnField(
                  "Nome: ", nome, TextInputType.name, null, ""),
              SizedBox(height: espaco),
              WidgetUltil.returnField(
                  "Telefone: ",
                  telefone,
                  TextInputType.phone,
                  [Masks.telefoneFormatter],
                  "(##) ##### - ####"),
              SizedBox(height: espaco),
              WidgetUltil.returnField("Data Nascimento: ", dataNascimento,
                  TextInputType.datetime, [Masks.dataFormatter], "##/##/####"),
              SizedBox(height: espaco),
              WidgetUltil.returnField(
                  "E-mail: ", email, TextInputType.emailAddress, null, ""),
              SizedBox(height: espaco),
              fieldSenha(),
              SizedBox(height: espaco),
              fieldConfirmSenha(),
              SizedBox(height: espaco),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    registrar();
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
      )),
    );
  }

  registrar() async {
    try {
      var usuario = Usuario();
      usuario.name = nome.text;
      usuario.telefone = telefone.text;
      usuario.email = email.text;
      usuario.senha = senha.text;
      usuario.confirmSenha = confirmSenha.text;
      usuario.dataNascimento = DateUltils.stringToDate(dataNascimento.text);
      await Provider.of<UserService>(context, listen: false).registrar(usuario);
      Navigator.pop(context);
    } on CustomException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
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
