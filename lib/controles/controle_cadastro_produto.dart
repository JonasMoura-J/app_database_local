import 'package:app_database_local/banco_dados/dicionario_dados.dart';
import 'package:app_database_local/controles/controle_cadastro.dart';
import 'package:app_database_local/controles/controle_cadastro_tipo_produto.dart';
import 'package:app_database_local/entidades/entidade.dart';
import 'package:app_database_local/entidades/produto.dart';
import 'package:app_database_local/entidades/tipo_produto.dart';
import 'package:app_database_local/banco_dados/acesso_banco_dados.dart';

class ControleCadastroProduto extends ControleCadastro {
  ControleCadastroTipoProduto controleCadastroTipoProduto =
      ControleCadastroTipoProduto();
  ControleCadastroProduto()
      : super(DicionarioDados.tabelaProduto, DicionarioDados.idProduto);
  Future<Entidade> criarEntidade(Map<String, dynamic> mapaEntidade) async {
    Produto produto = Produto.criarDeMapa(mapaEntidade);
    TipoProduto tipoProduto = await controleCadastroTipoProduto
        .selecionar(produto.idTipoProduto) as TipoProduto;
    produto.tipoProduto = tipoProduto;
    return produto;
  }

  Future<List<Entidade>> selecionarPorTipo(int idTipoProduto) async {
    final bancoDados = await AcessoBancoDados().bancoDados;

    List<Map> mapaEntidades;
    if (idTipoProduto > 0) {
      mapaEntidades = await bancoDados.query(tabela,
          where: '${DicionarioDados.idTipoProduto} = ? ',
          whereArgs: [idTipoProduto]);
    } else {
      mapaEntidades = await bancoDados.query(tabela);
    }
    List<Entidade> entidades = await criarListaEntidades(mapaEntidades);
    return entidades;
  }
}
