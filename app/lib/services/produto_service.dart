import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/custom_exception.dart';
import '../models/produto.dart';

class ProdutoService extends ChangeNotifier {
  CollectionReference produtos =
      FirebaseFirestore.instance.collection('produtos');
  static const String path = "produtos";

  salvar(Produto entity) async {
    DocumentReference docRef = await produtos.add(entity.toJson()).catchError(
        (error) => throw CustomException(
            "ocorreu um erro ao cadastrar tente novamente"));

    entity.id = docRef.id;
  }
}
