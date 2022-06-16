import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String result = '1728';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              calButton('AC', Colors.grey, Colors.black),
              calButton('+/-', Colors.grey, Colors.black),
              calButton('%', Colors.grey, Colors.black),
              calButton('/', Colors.amber.shade700, Colors.white),
            ],
          )
        ]),
      ),
    );
  }

  Widget calButton(String btnsymbol, Color symbolColor, Color btnColor) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: OutlinedButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(btnColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
        ),
        child: Text(
          btnsymbol,
          style: TextStyle(
            fontSize: getadaptiveTextSize(context, 20),
            fontWeight: FontWeight.bold,
            color: symbolColor,
          ),
        ),
      ),
    );
  }

  Container resultText() {
    return Container(
      alignment: Alignment.centerRight,
      child: Text(
        result,
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

dynamic getadaptiveTextSize(BuildContext context, dynamic value) {
  // 720 is medium screen height
  return (value / 720) * MediaQuery.of(context).size.height;
}
