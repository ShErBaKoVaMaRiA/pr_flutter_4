import 'package:flutter/material.dart';
import 'package:flutter_app_1/window_2.dart';
import 'package:flutter_app_1/work_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => WorkTheme(),
        builder: (context, _) {
          final themeProvider = Provider.of<WorkTheme>(context);

          return MaterialApp(
            title: "Практическая работа №5",
            themeMode: themeProvider.themeMode,
            theme: Themes_App.lightTheme,
            darkTheme: Themes_App.darkTheme,
            home: const _HomePage(title: 'Практическая работа №5'),
          );
        },
      );
}

class _HomePage extends StatefulWidget {
  const _HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<_HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_HomePage> {
  late bool isDark;
  TextEditingController text = TextEditingController();

  final Future<SharedPreferences> sharedPreferences =
      SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    isDark = Provider.of<WorkTheme>(context).themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: text,
              decoration: InputDecoration(
                hintText: "Введите текст",
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (c) => Window_2(text: text.text)));
                },
                child: const Text("Перейти на другую страницу")),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<WorkTheme>(context, listen: false).updateTheme(!isDark);
        },
      ),
    );
  }
}

//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Provider.of<WorkTheme>(context, listen: false).updateTheme(!isDark);
//         },
//       ),
//     );
//   }
// }
