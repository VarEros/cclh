import 'package:cclh/services/socket_service.dart';
import 'package:cclh/themes.dart';
import 'package:cclh/viewmodels/game_viewmodel.dart';
import 'package:cclh/views/game_view.dart';
import 'package:cclh/views/login_view.dart';
import 'package:cclh/views/select_view.dart';
import 'package:cclh/views/test_view.dart';
import 'package:cclh/views/waiting_view.dart';
import 'package:cclh/views/winner_view.dart';
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
          '/game': (context) => const GameView(),
        },
      ),
    );
  }
}

class Main extends StatelessWidget {
const Main({ super.key });

  @override
  Widget build(BuildContext context){
    final gameViewModel = Provider.of<GameViewModel>(context);
    
    return 
    gameViewModel.cardsPlayed.isNotEmpty ?
    const WinnerView() : 
    gameViewModel.roundStarted ?
    const SelectView() :
    const WaitingView();
  }
}