import 'package:flutter/material.dart';
import 'package:app_database_local/controles/controle_cadastro_lista_compra.dart';
import 'package:app_database_local/main.dart';
import 'package:app_database_local/paginas/pagina_cadastro.dart';
import 'package:app_database_local/paginas/pagina_entidade.dart';
import 'package:app_database_local/entidades/entidade.dart';
import 'package:app_database_local/entidades/lista_compra.dart';
import 'package:app_database_local/paginas/pagina_lista_compra.dart';
import 'package:app_database_local/paginas/navegacao.dart';

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({Key? key}) : super(key: key);
  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal>
    with EstadoPaginaCadastro {
  Widget _criarItemGaveta(
      int indicePagina, IconData icone, String titulo, String pagina) {
    return ListTile(
      leading: Icon(
        icone,
        color: Colors.black,
        size: 25,
      ),
      title: Text(
        titulo,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      onTap: () {
// blocInterfacePrincipal.eventoAba.add(indicePagina);
// scaffoldKey.currentState.openEndDrawer();
        Navigator.pushNamed(context, pagina);
      },
    );
  }

  @override
  Widget criarGaveta() {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.all(0.0),
          children: <Widget>[
            SafeArea(
              child: Container(),
            ),
            _criarItemGaveta(
                1, Icons.apps, 'Tipos de Produtos', Navegacao.tipoProduto),
            _criarItemGaveta(
                2, Icons.shopping_cart, 'Produtos', Navegacao.produto),
          ],
        ),
      ),
    );
  }

  @override
  Widget criarPaginaEntidade(
      OperacaoCadastro operacaoCadastro, Entidade entidade) {
    return PaginaListaCompra(
        operacaoCadastro: operacaoCadastro, entidade: entidade);
  }

  @override
  Entidade criarEntidade() {
    return ListaCompra(idCompra: 0, nome: '');
  }

  @override
  List<Widget> criarConteudoItem(Entidade entidade) {
    return [
      SizedBox(
        height: 50,
      ),
      Text(
        (entidade as ListaCompra).nome,
      ),
      SizedBox(
        height: 50,
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    controleCadastro = ControleCadastroListaCompra();
    controleCadastro.emitirLista();
  }

  @override
  void dispose() {
    controleCadastro.finalizar();
    super.dispose();
  }

  @override
  Widget build(BuildContext contexto) {
    return criarPagina(contexto, 'Listas de Compras');
  }
}
