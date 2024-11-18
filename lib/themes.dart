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
  fontFamily: GoogleFonts.josefinSans().fontFamily,
  colorScheme: lightScheme,
  appBarTheme: AppBarTheme(
    // centerTitle: true, 
    titleTextStyle: TextStyle(
      fontFamily: GoogleFonts.bebasNeue().fontFamily,
      fontSize: 40,
      color: lightScheme.onSurface,
    )
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: ButtonStyle(
      padding: const WidgetStatePropertyAll(EdgeInsets.all(30)), 
      textStyle: WidgetStatePropertyAll(TextStyle(inherit: true,fontWeight: FontWeight.bold, fontSize: 20, fontFamily: GoogleFonts.josefinSans().fontFamily)),
      shape: const WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16)))),
      minimumSize: const WidgetStatePropertyAll(Size.fromHeight(40)),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered)) {
          return lightScheme.inversePrimary;
        }
        if (states.contains(WidgetState.disabled)) {
          return null;
        }
        return lightScheme.primaryContainer;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered)) {
          return lightScheme.onSurface;
        }
        if (states.contains(WidgetState.disabled)) {
          return null;
        }
        return lightScheme.primaryFixedDim;
      }),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder()),
  listTileTheme: ListTileThemeData(tileColor: lightScheme.surfaceContainer)
);

final darkTheme = ThemeData(
  fontFamily: GoogleFonts.josefinSans().fontFamily,
  colorScheme: darkScheme,
  appBarTheme: AppBarTheme(
    // centerTitle: true, 
    titleTextStyle: TextStyle(
      fontFamily: GoogleFonts.bebasNeue().fontFamily,
      fontSize: 40,
      color: darkScheme.onSurface,
    )
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: ButtonStyle(
      padding: const WidgetStatePropertyAll(EdgeInsets.all(30)), 
      textStyle: WidgetStatePropertyAll(TextStyle(inherit: true,fontWeight: FontWeight.bold, fontSize: 20, fontFamily: GoogleFonts.josefinSans().fontFamily)),
      shape: const WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16)))),
      minimumSize: const WidgetStatePropertyAll(Size.fromHeight(40)),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered)) {
          return darkScheme.inversePrimary;
        }
        if (states.contains(WidgetState.disabled)) {
          return null;
        }
        return darkScheme.primaryContainer;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered)) {
          return darkScheme.onSurface;
        }
        if (states.contains(WidgetState.disabled)) {
          return null;
        }
        return darkScheme.primaryFixedDim;
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