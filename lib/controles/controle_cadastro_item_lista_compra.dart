import 'package:app_database_local/banco_dados/acesso_banco_dados.dart';
import 'package:app_database_local/banco_dados/dicionario_dados.dart';
import 'package:app_database_local/entidades/entidade.dart';
import 'package:app_database_local/entidades/item_lista_compra.dart';
import 'package:app_database_local/entidades/produto.dart';
import 'package:app_database_local/controles/controle_cadastro.dart';
import 'package:app_database_local/controles/controle_cadastro_produto.dart';

class ControleCadastroItemListaCompra extends ControleCadastro {
  ControleCadastroProduto controleCadastroProduto = ControleCadastroProduto();
  ControleCadastroItemListaCompra()
      : super(DicionarioDados.tabelaItemListaCompra,
            DicionarioDados.idListaCompra);
  Future<Entidade> criarEntidade(Map<String, dynamic> mapaEntidade) async {
    ItemListaCompra itemListaCompra = ItemListaCompra.criarDeMapa(mapaEntidade);
    Produto produto = await controleCadastroProduto
        .selecionar(itemListaCompra.idProduto) as Produto;
    itemListaCompra.produto = produto;
    return itemListaCompra;
  }

  Future<List<Entidade>> selecionarDaListaCompra(int idListaCompra) async {
    final bancoDados = await AcessoBancoDados().bancoDados;
    List<Map> mapaEntidades = await bancoDados!.query(tabela,
        where: '${DicionarioDados.idListaCompra} = ? ',
        whereArgs: [idListaCompra]);
    List<Entidade> entidades = await criarListaEntidades(mapaEntidades);
    return entidades;
  }

  Future<int> excluirDaListaCompra(int idListaCompra) async {
    final bancoDados = await AcessoBancoDados().bancoDados;
    int resultado = await bancoDados!.delete(tabela,
        where: '${DicionarioDados.idListaCompra} = ? ',
        whereArgs: [idListaCompra]);
    return resultado;
  }
}
