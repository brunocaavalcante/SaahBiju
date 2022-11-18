import '../core/date_ultils.dart';

class Produto {
  String id = "";
  var nome = "";
  var descricao = "";
  var codigo = "";
  late DateTime dataCadastro;
  var valor;
  var valorCusto;
  String? imagem = "";
  String? refImagem = "";

  Map<String, Object?> toJson() {
    return {
      'nome': nome,
      'descricao': descricao,
      'codigo': codigo,
      'dataCadastro': dataCadastro,
      'id': id,
      'valor': valor,
      'valorCusto': valorCusto,
      'imagem': imagem,
      'refImagem': refImagem
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
    valorCusto = map['valorCusto'];
    imagem = map['imagem'];
    refImagem = map['refImagem'];
    return this;
  }

  double? CoverterValorToDecimal(String valorTxt) {
    return double.tryParse(valorTxt
        .replaceRange(0, 3, "")
        .replaceAll(".", "")
        .replaceAll(",", "."));
  }
}
