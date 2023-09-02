import 'package:flutter/material.dart';
import 'buttons.dart';
import 'package:math_expressions/math_expressions.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var userQuestion = "";
  var userAnswer = "";

  final List<String> button = [
    "c",
    "DEL",
    "%",
    "/",
    "9",
    "8",
    "7",
    "×",
    "6",
    "5",
    "4",
    "-",
    "3",
    "2",
    "1",
    "+",
    "0",
    ".",
    "ANS",
    "=",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 50),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      userQuestion,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userAnswer,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                itemCount: button.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                itemBuilder: (context, i) {
                  if (i == 0) {
                    return MyButton(
                      onTap: () {
                        setState(() {
                          userQuestion = "";
                          userAnswer = "";
                        });
                      },
                      color: Colors.green,
                      textColor: Colors.white,
                      buttonText: button[i],
                    );
                  } else if (i == 1) {
                    return MyButton(
                      onTap: () {
                        if (userQuestion != '') {
                          setState(() {
                            userQuestion = userQuestion.substring(0, userQuestion.length - 1);
                          });
                        }
                      },
                      color: Colors.red,
                      textColor: isOperator(button[i]) ? Colors.white : Colors.deepPurple,
                      buttonText: button[i],
                    );
                  } else if (i == button.length - 1) {
                    return MyButton(
                      onTap: () {
                        if (userQuestion != '') {
                          setState(() {
                            equalPressed();
                          });
                        }
                      },
                      color: Colors.deepPurple,
                      textColor: isOperator(button[i]) ? Colors.white : Colors.deepPurple,
                      buttonText: button[i],
                    );
                  } else {
                    return MyButton(
                      onTap: () {
                        setState(() {
                          // userQuestion = userQuestion + button[i];
                          userQuestion += button[i];
                        });
                      },
                      color: isOperator(button[i]) ? Colors.deepPurple : Colors.white,
                      textColor: isOperator(button[i]) ? Colors.white : Colors.deepPurple,
                      buttonText: button[i],
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == "/" || x == "×" || x == "-" || x == "+" || x == "=" || x == "%") {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll("×", "*");
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer = eval.toString();
  }
}
