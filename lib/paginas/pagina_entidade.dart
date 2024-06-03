import 'package:app_database_local/entidades/entidade.dart';
import 'package:flutter/material.dart';

enum OperacaoCadastro { inclusao, edicao, selecao }

mixin PaginaEntidade {
  late OperacaoCadastro operacaoCadastro;
  late Entidade entidade;
}

mixin EstadoPaginaEntidade {
  List<Widget> criarConteudoFormulario(BuildContext contexto);

  void transferirDadosParaEntidade();

  bool dadosCorretos(BuildContext contexto);

  String prepararTitulo(OperacaoCadastro operacao, String titulo) {
    switch (operacao) {
      case OperacaoCadastro.inclusao:
        return 'Inclusão de ' + titulo;
      case OperacaoCadastro.edicao:
        return 'Edição de ' + titulo;
      case OperacaoCadastro.selecao:
        return 'Seleção de ' + titulo;
    }
  }

  Widget criarFormulario(BuildContext contexto) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: criarConteudoFormulario(contexto) +
            [
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    child: Text('Salvar'),
                    onPressed: () {
                      transferirDadosParaEntidade();
                      if (dadosCorretos(contexto)) {
                        Navigator.pop(contexto, true);
                      }
                    },
                  ),
                  SizedBox(
                    width: 50.0,
                  ),
                  TextButton(
                    child: Text('Cancelar'),
                    onPressed: () {
                      Navigator.pop(contexto, false);
                    },
                  )
                ],
              )
            ],
      ),
    );
  }

  Widget criarPagina(
      BuildContext contexto, OperacaoCadastro operacao, String titulo) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          prepararTitulo(operacao, titulo),
        ),
        centerTitle: true,
      ),
      body: criarFormulario(contexto),
    );
  }
}
