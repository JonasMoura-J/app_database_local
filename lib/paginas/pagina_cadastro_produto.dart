import 'package:flutter/material.dart';
import 'package:app_database_local/paginas/pagina_cadastro.dart';
import 'package:app_database_local/paginas/pagina_entidade.dart';
import 'package:app_database_local/entidades/entidade.dart';
import 'package:app_database_local/paginas/pagina_produto.dart';
import 'package:app_database_local/entidades/produto.dart';
import 'package:app_database_local/controles/controle_cadastro_produto.dart';

class EstadoPaginaCadastroProduto extends StatefulWidget {
  const EstadoPaginaCadastroProduto({Key? key}) : super(key: key);
  @override
  State<EstadoPaginaCadastroProduto> createState() =>
      _EstadoPaginaCadastroProdutoState();
}

class _EstadoPaginaCadastroProdutoState
    extends State<EstadoPaginaCadastroProduto> with EstadoPaginaCadastro {
  @override
  Widget criarPaginaEntidade(
      OperacaoCadastro operacaoCadastro, Entidade entidade) {
    return PaginaProduto(
        operacaoCadastro: operacaoCadastro, entidade: entidade);
  }

  @override
  Entidade criarEntidade() {
    return Produto(nome: '', quantidade: 0.0);
  }

  @override
  List<Widget> criarConteudoItem(Entidade entidade) {
    Produto produto = entidade as Produto;
    return [
      Text(
        produto.nome,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 2,
      ),
      Text(
        'Quantidade: ${produto.quantidade.toString()} ${produto.unidade}',
      ),
      SizedBox(
        height: 2,
      ),
      Text(produto.tipoProduto != null
          ? 'Tipo: ${produto.tipoProduto.nome}'
          : '')
    ];
  }

  @override
  void initState() {
    super.initState();
    controleCadastro = ControleCadastroProduto();
    controleCadastro.emitirLista();
  }

  @override
  void dispose() {
    controleCadastro.finalizar();
    super.dispose();
  }

  @override
  Widget build(BuildContext contexto) {
    return criarPagina(contexto, 'Produtos');
  }
}
