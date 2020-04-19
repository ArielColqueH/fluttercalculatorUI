import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Ariel\'s Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(
            color: Colors.white,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        padding: EdgeInsets.all(16),
        onPressed: () => buttonPressed(buttonText),
        onLongPress: () => buttonLongPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.normal, color: Colors.white),
        ),
      ),
    );
  }

  String equation = "";
  String result = "";
  String expression = "";
  double aux = 0;
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;
  bool primerIngreso = false;
  //bool verificarPrimero = true;

  buttonPressed(String buttonText) {
    print(buttonText);
    setState(() {
      if (buttonText == "Del") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "";
        }
      } else if (buttonText == "Enter") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (result == "") {
          //equation = result;
        } else if (result == "Error" || result == "Infinity") {
          //print("here");
          equation = "";
          result = "";
        } else {
          equation = result;
          result = "";
        }
        primerIngreso = true;
        //flag2 = true;
      } else {
        equationFontSize = 38.0;
        resultFontSize = 48.0;
        if (equation == "") {
          equation = buttonText;
        } else {
          if (primerIngreso &&
              buttonText != "+" &&
              buttonText != "-" &&
              buttonText != "x" &&
              buttonText != "/" &&
              buttonText != "%") {
            equation = "";
            equation += buttonText;
            expression = equation;
            expression = expression.replaceAll('x', '*');
            primerIngreso = false;
            //verificarPrimero = false;
            try {
              Parser p = new Parser();
              Expression exp = p.parse(expression);
              ContextModel cm = ContextModel();
              result = "${exp.evaluate(EvaluationType.REAL, cm)}";
              aux = double.parse(result);
              result = aux.toStringAsFixed(2);
            } catch (e) {
              result = "Error";
            }
          } else {
            equation += buttonText;
            expression = equation;
            expression = expression.replaceAll('x', '*');
            //verificarPrimero = true;
            primerIngreso = false;
            try {
              Parser p = new Parser();
              Expression exp = p.parse(expression);
              ContextModel cm = ContextModel();
              result = "${exp.evaluate(EvaluationType.REAL, cm)}";
              aux = double.parse(result);
              result = aux.toStringAsFixed(2);
            } catch (e) {
              result = "Error";
            }
          }
        }
      }
    });
  }

  buttonLongPressed(String buttonText) {
    print("long");
    setState(() {
      if (buttonText == "Del") {
        equation = "";
        result = "";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
        primerIngreso = false;
        //verificarPrimero = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: new Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(
                equation,
                style: new TextStyle(
                  fontSize: equationFontSize,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(
                result,
                style: new TextStyle(
                  fontSize: resultFontSize,
                ),
              ),
            ),
            Expanded(
              child: Divider(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                          buildButton("(", 1, Colors.black54),
                          buildButton(")", 1, Colors.black54),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.60,
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                          buildButton("7", 1, Colors.black54),
                          buildButton("8", 1, Colors.black54),
                          buildButton("9", 1, Colors.black54),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton("4", 1, Colors.black54),
                          buildButton("5", 1, Colors.black54),
                          buildButton("6", 1, Colors.black54),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton("1", 1, Colors.black54),
                          buildButton("2", 1, Colors.black54),
                          buildButton("3", 1, Colors.black54),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton("0", 1, Colors.black54),
                          buildButton(".", 1, Colors.black54),
                          buildButton("Del", 1, Colors.black54),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.40,
                  child: Column(
                    children: [
                      Row(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.20,
                            child: Table(
                              children: [
                                TableRow(children: [
                                  buildButton("/", 1, Colors.redAccent),
                                ]),
                                TableRow(children: [
                                  buildButton("+", 2, Colors.redAccent),
                                ]),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.20,
                            child: Table(
                              children: [
                                TableRow(children: [
                                  buildButton("x", 1, Colors.redAccent),
                                ]),
                                TableRow(children: [
                                  buildButton("-", 1, Colors.redAccent),
                                ]),
                                TableRow(children: [
                                  buildButton("%", 1, Colors.redAccent),
                                ]),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.40,
                            child: Table(
                              children: [
                                TableRow(children: [
                                  buildButton("Enter", 1, Colors.redAccent),
                                ]),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
