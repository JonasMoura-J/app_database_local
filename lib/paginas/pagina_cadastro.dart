import 'package:app_database_local/controles/controle_cadastro.dart';
import 'package:app_database_local/entidades/entidade.dart';
import 'package:app_database_local/paginas/pagina_entidade.dart';
import 'package:flutter/material.dart';
import 'package:app_database_local/paginas/mensagem.dart';

mixin EstadoPaginaCadastro {
  late ControleCadastro controleCadastro;

  List<Entidade> entidades = <Entidade>[];

  List<Widget> criarConteudoItem(Entidade entidade);

  Widget criarPaginaEntidade(
      OperacaoCadastro operacaoCadastro, Entidade entidade);

  void mostrarBarraMensagem(BuildContext contexto, String mensagem) {
    final SnackBar barraMensagem = SnackBar(
      content: Text(mensagem),
    );
    ScaffoldMessenger.of(contexto).showSnackBar(barraMensagem);
  }

  void abrirPaginaEntidade(BuildContext contexto,
      OperacaoCadastro operacaoCadastro, Entidade entidade) async {
    bool confirmado =
        await Navigator.push(contexto, MaterialPageRoute(builder: (context) {
      return criarPaginaEntidade(operacaoCadastro, entidade);
    }));
    if (confirmado) {
      int resultado;
      if (operacaoCadastro == OperacaoCadastro.inclusao) {
        resultado = await controleCadastro.incluir(entidade);
      } else {
        resultado = await controleCadastro.alterar(entidade);
      }
      if (resultado > 0) {
        controleCadastro.emitirLista();
        mostrarBarraMensagem(
            contexto,
            operacaoCadastro == OperacaoCadastro.inclusao
                ? 'Inclusão realizada com sucesso.'
                : 'Alteração realizada com sucesso.');
      } else {
        mostrarBarraMensagem(contexto, 'Operação não foi realizada.');
      }
    }
  }

  Widget criarItemLista(contexto, indice) {
    return Dismissible(
      child: GestureDetector(
        child: Card(
          child: Container(
            width: MediaQuery.of(contexto).size.width,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(5.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: criarConteudoItem(entidades[indice])),
          ),
        ),
        onTap: () {
          abrirPaginaEntidade(contexto, OperacaoCadastro.edicao,
              entidades[indice].criarCopia());
        },
      ),
      key: Key(entidades[indice].identificador.toString()),
      background: Container(
        color: Colors.redAccent,
        alignment: Alignment.centerLeft,
        child: Align(
          alignment: Alignment(-0.9, 0),
          child: Icon(Icons.delete, color: Colors.white),
        ),
      ),
      confirmDismiss: (direcao) async {
        bool? confirmado =
            await confirmar(contexto, 'Deseja realmente excluir');
        return confirmado;
      },
      onDismissed: (direcao) async {
        int resultado =
            await controleCadastro.excluir(entidades[indice].identificador);
        if (resultado > 0) {
          controleCadastro.emitirLista();
          mostrarBarraMensagem(contexto, 'Exclusão realizada com sucesso');
        }
      },
    );
  }

  Widget criarLista() {
    if (controleCadastro == null) {
      return Container(
        child: Text(
          'Controle não instanciado',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      );
    }
    return StreamBuilder(
        stream: controleCadastro.fluxo,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            entidades = snapshot.data as List<Entidade>;
            return ListView.builder(
                padding: EdgeInsets.all(5.0),
                itemCount: entidades.length,
                itemBuilder: (context, index) {
                  return criarItemLista(context, index);
                });
          } else {
            return Container(
              alignment: Alignment.center,
              child: Text(
                'Inclua os itens!',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            );
          }
        });
  }

  Entidade criarEntidade();

  Widget? criarGaveta() {
    return null;
  }

  Widget criarPagina(BuildContext contexto, String titulo) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titulo,
        ),
        centerTitle: true,
      ),
      drawer: criarGaveta(),
      body: criarLista(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          abrirPaginaEntidade(
              contexto, OperacaoCadastro.inclusao, criarEntidade());
        },
      ),
    );
  }
}
