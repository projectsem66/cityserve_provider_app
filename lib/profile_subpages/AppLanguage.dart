import 'package:flutter/material.dart';

class AppLanguage extends StatefulWidget {
  const AppLanguage({super.key});

  @override
  State<AppLanguage> createState() => _AppLanguageState();
}

class _AppLanguageState extends State<AppLanguage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'App Language',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 50,

            child: Row(
              children: [
                Icon(Icons.flag),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "English",
                ),
                Spacer(),
                Icon(
                  Icons.add_task_rounded,
                  size: 30,
                )
              ],
            ),
          ),
          Container(
            height: 50,

            child: Row(
              children: [
                Icon(Icons.flag),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Hindi",
                ),
                Spacer(),
                Icon(
                  Icons.add_task_rounded,
                  size: 30,
                )
              ],
            ),
          ),
          Container(
            height: 50,

            child: Row(
              children: [
                Icon(Icons.flag),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Gujrati",
                ),
                Spacer(),
                Icon(
                  Icons.add_task_rounded,
                  size: 30,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
