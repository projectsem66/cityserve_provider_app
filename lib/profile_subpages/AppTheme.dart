import 'package:flutter/material.dart';

class AppTheme extends StatefulWidget {
  const AppTheme({super.key});

  @override
  State<AppTheme> createState() => _AppThemeState();
}

class _AppThemeState extends State<AppTheme> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'App Theme',
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

                SizedBox(
                  width: 10,
                ),
                Text(
                  "Light Mode",
                ),
                Spacer(),
                Icon(
                  Icons.circle_outlined,
                  size: 30,
                )
              ],
            ),
          ),
          Container(
            height: 50,

            child: Row(
              children: [

                SizedBox(
                  width: 10,
                ),
                Text(
                  "Dark Mode",
                ),
                Spacer(),
                Icon(
                  Icons.circle_outlined,
                  size: 30,
                )
              ],
            ),
          ),
          Container(
            height: 50,

            child: Row(
              children: [

                SizedBox(
                  width: 10,
                ),
                Text(
                  "System Mode",
                ),
                Spacer(),
                Icon(
                  Icons.circle_outlined,
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
