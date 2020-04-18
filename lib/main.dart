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

  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    print(buttonText);
    setState(() {
      if (buttonText == "Del") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "Enter") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;
        expression = equation;
        expression = expression.replaceAll('x', '*');
        try {
          Parser p = new Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = "${exp.evaluate(EvaluationType.REAL, cm)}";
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation += buttonText;
        }
      }
    });
  }

  buttonLongPressed(String buttonText) {
    print("long");
    setState(() {
      if (buttonText == "Del") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
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
