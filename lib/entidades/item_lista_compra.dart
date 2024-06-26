import 'package:app_database_local/entidades/produto.dart';
import 'package:app_database_local/entidades/entidade.dart';
import 'package:app_database_local/banco_dados/dicionario_dados.dart';

class ItemListaCompra extends Entidade {
  int numeroItem = 0;
  int idProduto = 0;
  Produto _produto = Produto();
  double quantidade = 0.0;
  bool selecionado = false;
  Produto get produto => _produto;
  set produto(Produto produto) {
    _produto = produto;
    idProduto = produto.identificador;
  }

  ItemListaCompra(
      {int idListaCompra = 0,
      required this.numeroItem,
      required Produto produto,
      required this.quantidade,
      required this.selecionado})
      : super(idListaCompra) {
    this.produto = produto;
  }
  ItemListaCompra.criarDeMapa(Map<String, dynamic> mapaEntidade)
      : super.criarDeMapa(mapaEntidade) {
    identificador = mapaEntidade[DicionarioDados.idListaCompra];
    numeroItem = mapaEntidade[DicionarioDados.numeroItem];
    idProduto = mapaEntidade[DicionarioDados.idProduto];
    quantidade = mapaEntidade[DicionarioDados.quantidade];
    selecionado =
        mapaEntidade[DicionarioDados.selecionado] == 'S' ? true : false;
  }
  Entidade criarEntidade(Map<String, dynamic> mapaEntidade) {
    return ItemListaCompra.criarDeMapa(mapaEntidade);
  }

  Map<String, dynamic> converterParaMapa() {
    return {
      DicionarioDados.idListaCompra: identificador,
      DicionarioDados.numeroItem: numeroItem,
      DicionarioDados.idProduto: idProduto,
      DicionarioDados.quantidade: quantidade,
      DicionarioDados.selecionado: selecionado ? 'S' : 'N',
    };
  }
}
