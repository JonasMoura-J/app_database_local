import 'package:app_database_local/banco_dados/dicionario_dados.dart';
import 'package:app_database_local/controles/controle_cadastro.dart';
import 'package:app_database_local/entidades/entidade.dart';
import 'package:app_database_local/entidades/tipo_produto.dart';

class ControleCadastroTipoProduto extends ControleCadastro {
  ControleCadastroTipoProduto()
      : super(DicionarioDados.tabelaTipoProduto, DicionarioDados.idTipoProduto);
  Future<Entidade> criarEntidade(Map<String, dynamic> mapaEntidade) async {
    return TipoProduto.criarDeMapa(mapaEntidade);
  }
}
