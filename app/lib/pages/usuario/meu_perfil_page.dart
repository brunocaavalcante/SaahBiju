import 'package:app/models/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/date_ultils.dart';
import '../../core/widget_ultil.dart';
import '../../services/usuario_service.dart';
import 'cadastro_user_page.dart';

class MeuPerfilPage extends StatefulWidget {
  const MeuPerfilPage({super.key});

  @override
  State<MeuPerfilPage> createState() => _MeuPerfilPageState();
}

class _MeuPerfilPageState extends State<MeuPerfilPage> {
  Usuario user = Usuario();

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
                      builder: (context) => CadastroUserPage(
                          user: user, operacao: "Editar Usuario")));
            }),
        appBar: WidgetUltil.barWithArrowBackIos(context, ""),
        body: body());
  }

  body() {
    UserService auth = Provider.of<UserService>(context);
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(auth.usuario!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          user = Usuario().toEntity(data);

          return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [containerImage(), containerInfo()]);
        }

        return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(strokeWidth: 10));
      },
    );
  }

  containerImage() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: user.photo == ""
          ? Image.asset("imagens/saah-biju-logo-sem-fundo.png",
              fit: BoxFit.cover)
          : Image.network(user.photo, fit: BoxFit.cover),
    );
  }

  containerInfo() {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.55,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(user.name,
              style:
                  const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          rowItem("Email: ", user.email),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          rowItem("Data Nascimento: ",
              DateUltils.formatarData(user.dataNascimento)),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          rowItem("Telefone: ", user.telefone),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01)
        ]));
  }

  rowItem(String text, String value) {
    return Row(children: [
      Text(text,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).hintColor)),
      Text(value,
          style: TextStyle(fontSize: 18, color: Theme.of(context).hintColor)),
    ]);
  }
}
