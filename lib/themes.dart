import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final lightScheme = ColorScheme.fromSeed(
  seedColor: Colors.indigo,
  brightness: Brightness.light,
);
final darkScheme = ColorScheme.fromSeed(
  seedColor: Colors.blue,
  brightness: Brightness.dark,
);

final lightTheme = ThemeData(
  fontFamily: GoogleFonts.kanit().fontFamily,
  colorScheme: lightScheme,
  appBarTheme: AppBarTheme(
    backgroundColor: lightScheme.onSurface,
    foregroundColor: lightScheme.surface,
    centerTitle: true,
  ),
  inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder())
);

final darkTheme = ThemeData(
  fontFamily: GoogleFonts.josefinSans().fontFamily,
  colorScheme: darkScheme,
  appBarTheme: AppBarTheme(
    // centerTitle: true, 
    titleTextStyle: TextStyle(
      fontFamily: GoogleFonts.bebasNeue().fontFamily,
      fontSize: 40,
      letterSpacing: 5,
      color: darkScheme.onSurface,
    )
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      padding: const WidgetStatePropertyAll(EdgeInsets.all(30)), 
      textStyle: WidgetStatePropertyAll(TextStyle(inherit: true,fontWeight: FontWeight.bold, fontSize: 20, fontFamily: GoogleFonts.josefinSans().fontFamily)),
      shape: const WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16)))),
      minimumSize: const WidgetStatePropertyAll(Size.fromHeight(40)),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered)) {
          return darkScheme.primaryContainer;
        }
        return null;
      }),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder()),
  listTileTheme: ListTileThemeData(tileColor: darkScheme.surfaceContainer)
);

// Widget getLogo(BuildContext context) {
//   return Column(
//     children: [
//       Image.asset(
//         'assets/images/logo.png', 
//         color: Theme.of(context).colorScheme.onSurface,
//         filterQuality: FilterQuality.medium,
//         scale: 8,
//       ),
//       Text('Med Copilot', style: TextStyle(fontFamily: GoogleFonts.oswald().fontFamily, fontWeight: FontWeight.bold)),
//       const SizedBox(height: 20)
//     ],
//   );
// } 