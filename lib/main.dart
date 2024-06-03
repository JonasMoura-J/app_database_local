import 'package:flutter/material.dart';
import 'package:app_database_local/paginas/pagina_principal.dart';
import 'package:app_database_local/paginas/pagina_cadastro_tipo_produto.dart';
import 'package:app_database_local/paginas/pagina_cadastro_produto.dart';
import 'package:app_database_local/paginas/navegacao.dart';

void main() {
  runApp(ListaCompras());
}

class ListaCompras extends StatelessWidget {
  const ListaCompras({Key? key}) : super(key: key);

  static Map<String, WidgetBuilder> criarRotasNavegacao() {
    return <String, WidgetBuilder>{
      Navegacao.principal: (BuildContext context) => PaginaPrincipal(),
      Navegacao.tipoProduto: (BuildContext context) =>
          EstadoPaginaCadastroTipoProduto(),
      Navegacao.produto: (BuildContext context) =>
          EstadoPaginaCadastroProduto(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Listas de Compras',
      theme: ThemeData(),
      routes: criarRotasNavegacao(),
      home: PaginaPrincipal(),
    );
  }
}
