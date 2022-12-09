import 'package:flutter/material.dart';
import 'package:flutter_app_1/cubit/cubit.dart';
import 'package:flutter_app_1/cubit/work_theme.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            title: "Практическая работа №4",
            themeMode: themeProvider.themeMode,
            theme: Themes_App.lightTheme,
            darkTheme: Themes_App.darkTheme,
            home: BlocProvider(
              create: (_) => Cubit_File(),
              child: _HomePage(),
            ),
          );
        },
      );
}

class _HomePage extends StatefulWidget {
  @override
  HomePage createState() => HomePage();
}

List<Widget> history = [];

class HomePage extends State<_HomePage> {
  late bool isDark; //темная ли тема

  @override
  Widget build(BuildContext context) {
    isDark = Provider.of<WorkTheme>(context).themeMode == ThemeMode.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text("Практическая работа №4"), //Заголовок
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          //Объекты формы
          children: <Widget>[
            BlocBuilder<Cubit_File, HomeState>(
                builder: (context, state) => Text(
                      state.counter.toString(),
                      style: Theme.of(context).textTheme.headline4,
                    )),
            //Кнопка +
            ElevatedButton(
              style: ElevatedButton.styleFrom(shape: const CircleBorder()),
              child: Container(
                width: 70,
                height: 70,
                alignment: Alignment.center,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: const Text("+"),
              ),
              onPressed: () {
                context.read<Cubit_File>().plus(isDark ? 2 : 1);

                if (isDark)
                  addItem('2 - темная тема');
                else
                  addItem('1 - светлая тема');
              },
            ),
            //Кнопка -
            ElevatedButton(
                style: ElevatedButton.styleFrom(shape: const CircleBorder()),
                child: Container(
                  width: 70,
                  height: 70,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: const Text("-"),
                ),
                onPressed: () {
                  context.read<Cubit_File>().minus(isDark ? 2 : 1);
                  if (isDark)
                    addItem('-2 - темная тема');
                  else
                    addItem('-1 - светлая тема');
                }),

            Expanded(
                child: ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) => history[index],
            ))
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

  void addItem(String th) {
    {
      setState(
        () {
          history.add(
            Text(th),
          );
        },
      );
    }
  }
}
