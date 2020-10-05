import 'package:flutter/material.dart';

void main() {
  runApp(Calc());
}

class Calc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.grey),
      home: CalculatorFull(),
    );
  }
}

class CalculatorFull extends StatefulWidget {
  @override
  _CalculatorFullState createState() => _CalculatorFullState();
}

class _CalculatorFullState extends State<CalculatorFull> {
  String equation = '0';
  String result = '0';
  String expression = '';
  double equationFontSize = 38;
  double resultFontSize = 48;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'AC') {
        equation = '0';
        result = '0';
        expression = '';
        equationFontSize = 38;
        resultFontSize = 48;
      } else if (buttonText == '⌫') {
        equationFontSize = 38;
        resultFontSize = 48;
        equation = equation.substring(0, equation.length - 1);
        if (equation == '') {
          equation = '0';
        }
      } else if (buttonText == '=') {
        equationFontSize = 38;
        resultFontSize = 48;

        expression = equation;
        expression = expression.replaceAll('×', '*');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = 'Error';
        }

        // ignore: unrelated_type_equality_checks
        if (result == '${double.infinity}') {
          result = 'Error';
        }
      } else {
        equationFontSize = 38;
        resultFontSize = 48;
        if (equation == '0') {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(
              color: Colors.white, width: 1, style: BorderStyle.solid),
        ),
        padding: EdgeInsets.all(16.0),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.normal, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Calculator'),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton('AC', 1, Colors.grey),
                        buildButton('⌫', 1, Colors.greenAccent),
                        buildButton('/', 1, Colors.greenAccent),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('1', 1, Colors.black),
                        buildButton('2', 1, Colors.black),
                        buildButton('3', 1, Colors.black),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('4', 1, Colors.black),
                        buildButton('5', 1, Colors.black),
                        buildButton('6', 1, Colors.black),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('7', 1, Colors.black),
                        buildButton('8', 1, Colors.black),
                        buildButton('9', 1, Colors.black),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('.', 1, Colors.black),
                        buildButton('0', 1, Colors.black),
                        buildButton('00', 1, Colors.black),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton('×', 1, Colors.greenAccent),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('-', 1, Colors.greenAccent),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('+', 1, Colors.greenAccent),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('=', 2, Colors.grey),
                      ],
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
