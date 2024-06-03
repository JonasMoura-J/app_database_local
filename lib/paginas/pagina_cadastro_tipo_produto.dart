import 'package:flutter/material.dart';
import 'package:app_database_local/controles/controle_cadastro_tipo_produto.dart';
import 'package:app_database_local/entidades/tipo_produto.dart';
import 'package:app_database_local/paginas/pagina_cadastro.dart';
import 'package:app_database_local/paginas/pagina_tipo_produto.dart';
import 'package:app_database_local/paginas/pagina_entidade.dart';
import 'package:app_database_local/entidades/entidade.dart';

class EstadoPaginaCadastroTipoProduto extends StatefulWidget {

  @override
  _EstadoPaginaCadastroTipoProdutoState createState() => _EstadoPaginaCadastroTipoProdutoState();
}

class _EstadoPaginaCadastroTipoProdutoState extends State<EstadoPaginaCadastroTipoProduto> with EstadoPaginaCadastro {
  @override
  Widget criarPaginaEntidade(
      OperacaoCadastro operacaoCadastro, Entidade entidade) {
    return PaginaTipoProduto(
        operacaoCadastro: operacaoCadastro, entidade: entidade);
  }

  @override
  Entidade criarEntidade() {
    return TipoProduto(nome: '');
  }

  @override
  List<Widget> criarConteudoItem(Entidade entidade) {
    return [
      SizedBox(
        height: 35,
      ),
      Text(
        (entidade as TipoProduto).nome,
      ),
      SizedBox(
        height: 35,
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    controleCadastro = ControleCadastroTipoProduto();
    controleCadastro.emitirLista();
  }

  @override
  void dispose() {
    controleCadastro.finalizar();
    super.dispose();
  }

  @override
  Widget build(BuildContext contexto) {
    return criarPagina(contexto, 'Tipos de Produtos');
  }
}


