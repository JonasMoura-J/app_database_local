import 'package:app_database_local/banco_dados/dicionario_dados.dart';
import 'package:app_database_local/entidades/entidade.dart';
import 'package:app_database_local/entidades/tipo_produto.dart';

const List<String> unidadesProdutos = ['', 'un', 'kg', 'g', 'mg', 'l', 'ml'];

class Produto extends Entidade {
  TipoProduto _tipoProduto = TipoProduto();
  String nome = '';
  double quantidade = 0.0;
  String unidade = '';
  int idTipoProduto = 0;
  Produto({
    int idProduto = 0,
    this.nome = '',
    this.quantidade = 0.0,
  }) : super(idProduto);
  Produto.criarDeMapa(Map<String, dynamic> mapaEntidade)
      : super.criarDeMapa(mapaEntidade) {
    identificador = mapaEntidade[DicionarioDados.idProduto];
    nome = mapaEntidade[DicionarioDados.nome];
    quantidade = mapaEntidade[DicionarioDados.quantidade];
    idTipoProduto = mapaEntidade[DicionarioDados.idTipoProduto];
    unidade = mapaEntidade[DicionarioDados.unidade];
  }
  @override
  Entidade criarEntidade(Map<String, dynamic> mapaEntidade) {
    return Produto.criarDeMapa(mapaEntidade);
  }

  TipoProduto get tipoProduto => _tipoProduto;
  set tipoProduto(TipoProduto tipoProduto) {
    _tipoProduto = tipoProduto;
    idTipoProduto = tipoProduto.identificador;
  }

  @override
  Map<String, dynamic> converterParaMapa() {
    Map<String, dynamic> valores;
    valores = {
      DicionarioDados.idTipoProduto: idTipoProduto,
      DicionarioDados.nome: nome,
      DicionarioDados.quantidade: quantidade,
      DicionarioDados.unidade: unidade,
    };
//Se identificador é maior que zero, é uma alteração!
    if (identificador > 0) {
      valores.addAll({DicionarioDados.idProduto: identificador});
    }
    return valores;
  }
}
