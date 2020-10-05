import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calc());
}

class Calc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora',
      theme: ThemeData(primarySwatch: Colors.amber),
      home: CalculatorFull(),
    );
  }
}

class CalculatorFull extends StatefulWidget {
  @override
  _CalculatorFullState createState() => _CalculatorFullState();
}

class _CalculatorFullState extends State<CalculatorFull> {
  String operacion = '0';
  String resultado = '0';
  String eje = '';
  double operacionFontSize = 30;
  double resultadoFontSize = 45;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'ac') {
        operacion = '0';
        resultado = '0';
        eje = '';
        operacionFontSize = 30;
        resultadoFontSize = 45;
      } else if (buttonText == '⌫') {
        operacionFontSize = 30;
        resultadoFontSize = 45;
        operacion = operacion.substring(0, operacion.length - 1);
        if (operacion == '') {
          operacion = '0';
        }
      } else if (buttonText == '=') {
        operacionFontSize = 30;
        resultadoFontSize = 45;

        eje = operacion;
        eje = eje.replaceAll('×', '*');

        try {
          Parser p = Parser();
          Expression exp = p.parse(eje);

          ContextModel cm = ContextModel();
          resultado = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          resultado = 'Intente otra operación';
        }

        // ignore: unrelated_type_equality_checks
        if (resultado == '${double.infinity}') {
          resultado = 'Intente otra operación';
        }
      } else if (buttonText == 'c') {
        operacion = '0';
        resultado = '0';
        eje = '';
        operacionFontSize = 30;
        resultadoFontSize = 45;
      } else {
        operacionFontSize = 30;
        resultadoFontSize = 45;
        if (operacion == '0') {
          operacion = buttonText;
        } else {
          operacion = operacion + buttonText;
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
        title: Text('Calculadora'),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              operacion,
              style: TextStyle(fontSize: operacionFontSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              resultado,
              style: TextStyle(fontSize: resultadoFontSize),
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
                        buildButton('ac', 1, Colors.black),
                        buildButton('c', 1, Colors.black),
                        buildButton('/', 1, Colors.amber),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('1', 1, Colors.blueAccent),
                        buildButton('2', 1, Colors.blueAccent),
                        buildButton('3', 1, Colors.blueAccent),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('4', 1, Colors.blueAccent),
                        buildButton('5', 1, Colors.blueAccent),
                        buildButton('6', 1, Colors.blueAccent),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('7', 1, Colors.blueAccent),
                        buildButton('8', 1, Colors.blueAccent),
                        buildButton('9', 1, Colors.blueAccent),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('.', 1, Colors.blueAccent),
                        buildButton('0', 1, Colors.blueAccent),
                        buildButton('⌫', 1, Colors.amber),
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
                        buildButton('×', 1, Colors.amber),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('-', 1, Colors.amber),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('+', 1, Colors.amber),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('=', 2, Colors.red),
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
