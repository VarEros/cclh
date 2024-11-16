import 'package:flutter/material.dart';

class TestView extends StatelessWidget {
const TestView({ super.key });

  @override
  Widget build(BuildContext context){
    final colorScheme = Theme.of(context).colorScheme;
    final text = ['Primera respuesta', 'Segunda respuesta', 'Tercera respuesta', 'Cuarta respuesta', 'Quinta respuesta'];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cartas contra la Humanidad"),
        elevation: 30,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Card(
              margin: EdgeInsets.symmetric(horizontal: 60),
              elevation: 10,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Carta Negra",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Quien fue el pendejo que nose algo muy largo para ver q pasa cuadno se pasa de lacantidadd xddd __', // Mostrar la carta negra actual
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Elige la mejor respuesta",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (BuildContext context, int index) =>  Divider(height: 10, color: colorScheme.surface),
                itemCount: text.length,
                itemBuilder: (context, index) {
                  final playedCard = text[index];
                  return ListTile(
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    tileColor: playedCard == 'Segunda respuesta' ? colorScheme.surfaceContainerHigh : colorScheme.surface,
                    title: Text(playedCard, textScaler: const TextScaler.linear(1.3)),
                    subtitle: const Text('Respuesta de jugador X', textScaler: TextScaler.linear(1.2)),
                    onTap: () {
                        print('holaanuedo');
                      },
                      selectedColor: Colors.cyan,
                  );
                },
              ),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: OutlinedButton(
                onPressed: () {
                  print('object');
                }, 
                child: const Text('Elegir carta')
              ),
            ),
            // const SizedBox(width: 20,),
            // OutlinedButton(
            //   onPressed: () {
            //     print('fsdf');
            //   }, 
            //   child: const Text('Empezar siguiente ronda')
            // )
          ],
        ),
      ),
    );
  }
}
