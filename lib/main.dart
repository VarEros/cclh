import 'package:cclh/services/socket_service.dart';
import 'package:cclh/themes.dart';
import 'package:cclh/viewmodels/game_viewmodel.dart';
import 'package:cclh/views/game_view.dart';
import 'package:cclh/views/login_view.dart';
import 'package:cclh/views/test_view.dart';
import 'package:cclh/views/waiting_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SocketService()),
        ChangeNotifierProvider(create: (context) => GameViewModel(context.read<SocketService>())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cartas contra la Humanidad',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.dark,
        initialRoute: '/',
        routes: {
          '/': (context) => LoginView(),
          '/game': (context) => const MainView(),
        },
      ),
    );
  }
}

class MainView extends StatelessWidget {
const MainView({ super.key });

  @override
  Widget build(BuildContext context){
    final gameViewModel = Provider.of<GameViewModel>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cartas contra la Humanidad"),
        elevation: 30,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: gameViewModel.gameStarted ?
          const GameView() :
          const WaitingView()
      )
    );
  }
}