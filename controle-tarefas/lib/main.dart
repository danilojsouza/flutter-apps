import 'package:bot_toast/bot_toast.dart';
import 'package:controle.tarefas/screens/inicio.screen.dart';
import 'package:controle.tarefas/screens/tarefa.screen.dart';
import 'package:controle.tarefas/screens/usuario.screen.dart';
import 'package:controle.tarefas/service/tarefas.service.dart';
import 'package:controle.tarefas/service/usuario.service.dart';
import 'package:controle.tarefas/stores/tarefa.fazer.store.dart';
import 'package:controle.tarefas/stores/tarefa.feitas.store.dart';
import 'package:controle.tarefas/stores/usuario.store.dart';
import 'package:controle.tarefas/widgets/util/navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BotToastInit(
      child: MultiProvider(
        providers: [
          Provider<TarefaService>(
              create: (_) => TarefaService(TarefaFazerStore(), TarefaFeitasStore()),
              dispose: (ctx, tarefaService) {
                tarefaService.dispose();
              }),
          Provider<UsuarioService>(
            create: (_) => UsuarioService(UsuarioStore()),
            dispose: (ctx, usuarioService) {
              usuarioService.dispose();
            },
          ),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Controle de Tarefas',
            theme: ThemeData(
                primaryColor: Colors.indigo,
                accentColor: Colors.indigoAccent,
                primaryTextTheme: TextTheme(
                  title: TextStyle(color: Colors.white),
                  body1: TextStyle(color: Colors.white),
                  body2: TextStyle(color: Colors.white),
                  button: TextStyle(color: Colors.white),
                  caption: TextStyle(color: Colors.white),
                  subtitle: TextStyle(color: Colors.white),
                  display1: TextStyle(color: Colors.white),
                  display2: TextStyle(color: Colors.white),
                  display3: TextStyle(color: Colors.white),
                  display4: TextStyle(color: Colors.white),
                  headline: TextStyle(color: Colors.white),
                  overline: TextStyle(color: Colors.white),
                  subhead: TextStyle(color: Colors.white),
                ),
                brightness: Brightness.dark),
            routes: {
              '/usuario': (context) => UsuarioScreen(),
              '/inicio': (context) => InicioScreen(),
              '/novaTarefa': (context) => TarefaScreen(),
            },
            initialRoute: '/usuario',
            navigatorObservers: [BotToastNavigatorObserver()],
            navigatorKey: NavigatorUtils.nav),
      ),
    );
  }
}