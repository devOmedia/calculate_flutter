import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double resultTxt = 0.0;
  final Color btnColor = Colors.grey.shade800;
  final Color symbolColor = Colors.white;

  bool showresult = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: numberList!
                    .map((number) => Text(
                          number.toString(),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ))
                    .toList(),
              ),
            ),
            showresult ? resultWidget() : const SizedBox(),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calButton('AC', Colors.grey, Colors.black),
                calButton('+/-', Colors.grey, Colors.black),
                calButton('%', Colors.grey, Colors.black),
                calButton('/', Colors.amber.shade700, Colors.white),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calButton('7', btnColor, symbolColor),
                calButton('8', btnColor, symbolColor),
                calButton('9', btnColor, symbolColor),
                calButton('x', Colors.amber.shade700, symbolColor),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calButton('4', btnColor, Colors.white),
                calButton('5', btnColor, Colors.white),
                calButton('6', Colors.grey.shade800, Colors.white),
                calButton('-', Colors.amber.shade700, Colors.white),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calButton('1', Colors.grey.shade800, Colors.white),
                calButton('2', Colors.grey.shade800, Colors.white),
                calButton('3', Colors.grey.shade800, Colors.white),
                calButton('+', Colors.amber.shade700, Colors.white),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calButton('0', btnColor, symbolColor),
                calButton('.', btnColor, symbolColor),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.39,
                    child: calButton('=', Colors.amber.shade700, symbolColor))
              ],
            )
          ],
        ),
      ),
    );
  }

  SingleChildScrollView resultWidget() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              resultTxt.toString(),
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 80,
              ),
            ),
          )
        ],
      ),
    );
  }

  ///======================================================calculation function
  List? numberList = [];
  int i = 0;
  String fstnumber = '';
  String lastnumber = '';
  bool isFstNumber = true;
  String operator = '';

  calculation(String symbol) {
    if (symbol == '=' || symbol == 'AC') {
      if (symbol == '=') {
        if (operator == '+') {
          resultTxt = sum(double.parse(fstnumber), double.parse(lastnumber));
        } else if (operator == '-') {
          resultTxt = subs(double.parse(fstnumber), double.parse(lastnumber));
        } else if (operator == '/') {
          resultTxt = div(double.parse(fstnumber), double.parse(lastnumber));
        } else if (operator == 'x') {
          resultTxt = multi(double.parse(fstnumber), double.parse(lastnumber));
        }

        fstnumber = '';
        lastnumber = '';
        operator = '';
        isFstNumber = true;
        numberList!.clear();

        setState(() {
          showresult = true;
          resultTxt;
        });
      } else {
        fstnumber = '';
        lastnumber = '';
        operator = '';
        isFstNumber = true;
        setState(() {
          resultTxt = 0.0;
          numberList!.clear();
        });
      }
    } else {
      setState(() {
        //numberList![i++] = symbol;
        numberList?.add(symbol);
      });

      if (symbol == '+' ||
          symbol == 'x' ||
          symbol == '-' ||
          symbol == '/' ||
          symbol == '%' ||
          symbol == '+/-') {
        isFstNumber = false;
        operator = symbol;
        print("operator $operator");
      } else {
        isFstNumber ? fstnumber += symbol : lastnumber += symbol;
        print("$fstnumber and $lastnumber");
      }
    }
  }

  double sum(double a, double b) => a + b;
  double div(double a, double b) => a / b;
  double multi(double a, double b) => a * b;
  double subs(double a, double b) => a - b;

  Widget calButton(String btnsymbol, Color btnColor, Color symbolColor) {
    return OutlinedButton(
      onPressed: () {
        calculation(btnsymbol);
      },
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
    );
  }

  dynamic getadaptiveTextSize(BuildContext context, dynamic value) {
    // 720 is medium screen height
    return (value / 720) * MediaQuery.of(context).size.height;
  }
}
