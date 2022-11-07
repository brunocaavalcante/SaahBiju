import '../core/date_ultils.dart';

class Produto {
  String id = "";
  var nome = "";
  var descricao = "";
  var codigo = "";
  late DateTime dataCadastro;
  var valor;
  var imagem = "";

  Map<String, Object?> toJson() {
    return {
      'nome': nome,
      'descricao': descricao,
      'codigo': codigo,
      'dataCadastro': dataCadastro,
      'id': id,
      'valor': valor,
      'imagem': imagem
    };
  }

  Produto toEntity(Map<String, dynamic> map) {
    nome = map['nome'];
    descricao = map['descricao'];
    codigo = map['codigo'];
    dataCadastro =
        DateUltils.onlyDate(map['dataCadastro'].toDate() as DateTime);
    id = map['id'];
    valor = map['valor'];
    imagem = map['imagem'];
    return this;
  }

  void CoverterValorToDecimal(String valorTxt) {
    valor = double.tryParse(valorTxt
        .replaceRange(0, 3, "")
        .replaceAll(".", "")
        .replaceAll(",", "."));
  }
}
