import 'dart:math';

import 'package:calculator/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final TextEditingController _resultController = TextEditingController();
  bool _isScientific = false;
  bool _isInv = false;
  bool _isDemo = false;
  final List<String> nums = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  final List<String> longFuncs = [
    'sin(',
    'cos(',
    'tan(',
    'atan(',
    'ln(',
    'log(',
    'asin(',
    'acos(',
  ];
  final List<String> funcs = [
    'sin',
    'cos',
    'tan',
    'atan',
    'ln',
    'log',
    'asin',
    'acos',
    '+',
    '-',
    'x',
    '^',
    '÷',
    '√',
    '%',
  ];

  @override
  void initState() {
    super.initState();
    _resultController.text = 'Pudge';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.of(context).orientation == Orientation.portrait
          ? _portraitBody(context)
          : _landscapeBody(context),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height / 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                mini: true,
                child: const Icon(Icons.accessible_forward),
                onPressed: () => _changeDemo(context),
              ),
              FloatingActionButton(
                mini: true,
                child: const Icon(Icons.rotate_left),
                onPressed: () => _changeOrientation(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _changeOrientation(BuildContext context) {
    MediaQuery.of(context).orientation == Orientation.landscape
        ? setState(() {
            SystemChrome.setPreferredOrientations(
              [
                DeviceOrientation.portraitDown,
                DeviceOrientation.portraitUp,
              ],
            );
          })
        : setState(() {
            SystemChrome.setPreferredOrientations(
              [
                DeviceOrientation.landscapeLeft,
                DeviceOrientation.landscapeRight,
              ],
            );
          });
  }

  void _changeDemo(BuildContext context) {
    setState(() {
      _isDemo = !_isDemo;
      if (_isDemo) {
        _isScientific = false;
      }
    });
  }

  Widget _landscapeBody(BuildContext context) {
    return Column(
      children: [
        _inputBox(context, 0.4),
        _landscapeButtonsList(context),
      ],
    );
  }

  Widget _portraitBody(BuildContext context) {
    return Column(
      children: [
        _inputBox(context, 0.3),
        _portraitButtonsList(context),
      ],
    );
  }

  ClipRRect _inputBox(BuildContext context, double size) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        bottom: Radius.circular(25),
      ),
      child: Container(
        padding: const EdgeInsets.all(40),
        alignment: Alignment.bottomRight,
        height: MediaQuery.of(context).size.height * size,
        decoration: const BoxDecoration(
          color: Color(0xFFF0E2d7),
        ),
        child: Container(
          alignment: Alignment.bottomRight,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: SelectableText(
              _resultController.text,
              maxLines: 1,
              style: const TextStyle(fontSize: 28),
            ),
          ),
        ),
      ),
    );
  }

  Widget _landscapeButtonsList(BuildContext context) {
    final int rowCount = _isDemo ? 6 : 8;
    const int colCount = 4;
    return Row(
      children: [
        Row(
          children: [
            ...scientificButtonElementsLists
                .map(
                  (list) => Column(
                    children: list
                        .map(
                          (e) => _calcButton(
                              element: e,
                              rowElementsCount: rowCount,
                              colElementsCount: colCount,
                              size: 0.6),
                        )
                        .toList(),
                  ),
                )
                .toList()
              ..removeRange(1, 9 - rowCount),
          ],
        ),
        Column(
          children: [
            ...(defaultButtonElementsLists
                .map(
                  (list) => Row(
                    children: list
                        .map(
                          (e) => _calcButton(
                              element: e,
                              rowElementsCount: rowCount,
                              colElementsCount: colCount,
                              size: 0.6),
                        )
                        .toList(),
                  ),
                )
                .toList()
              ..removeAt(0)),
          ],
        ),
        Column(
          children: defaultButtonElementsLists.first
              .map(
                (e) => _calcButton(
                    element: e,
                    rowElementsCount: rowCount,
                    colElementsCount: colCount,
                    size: 0.6),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _portraitButtonsList(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Row(
            children: [
              ...scientificButtonElementsLists[0]
                  .map(
                    (e) => _calcButton(
                      element: e,
                      rowElementsCount: 5,
                      colElementsCount: 8,
                      size: 0.6,
                    ),
                  )
                  .toList(),
              if (!_isDemo) _changeModeButton(),
            ],
          ),
        ),
        if (_isScientific && !_isDemo)
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    ...scientificButtonElementsLists[1]
                        .map(
                          (e) => _calcButton(
                            element: e,
                            rowElementsCount: 5,
                            colElementsCount: 8,
                            size: 0.6,
                          ),
                        )
                        .toList(),
                  ],
                ),
                Row(
                  children: [
                    ...scientificButtonElementsLists[2]
                        .map(
                          (e) => _calcButton(
                            element: e,
                            rowElementsCount: 5,
                            colElementsCount: 8,
                            size: 0.6,
                          ),
                        )
                        .toList(),
                  ],
                ),
              ],
            ),
          ),
        ...defaultButtonElementsLists.map(
          (list) => Row(
            children: list
                .map(
                  (e) => _calcButton(
                    element: e,
                    rowElementsCount: 4,
                    colElementsCount: _isScientific ? 5 : 4,
                    size: 0.5,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _changeModeButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: IconButton(
        iconSize: 20,
        splashRadius: 20,
        onPressed: () => setState(() {
          _isScientific = !_isScientific;
        }),
        icon: _isScientific
            ? const Icon(Icons.keyboard_arrow_up)
            : const Icon(Icons.keyboard_arrow_down),
      ),
    );
  }

  Widget _calcButton({
    required ButtonElement element,
    required int rowElementsCount,
    required int colElementsCount,
    required double size,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 8),
      child: TextButton(
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(
            Size(
              (MediaQuery.of(context).size.width -
                      10 * (rowElementsCount + 1)) /
                  rowElementsCount,
              (MediaQuery.of(context).size.height * size -
                      10 * (colElementsCount + 1)) /
                  colElementsCount,
            ),
          ),
          shape: _isScientific ||
                  MediaQuery.of(context).orientation == Orientation.landscape
              ? MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                )
              : MaterialStateProperty.all(const CircleBorder()),
          backgroundColor: MaterialStateProperty.all(
            element.color ?? Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
        onPressed: () {
          late final String expr;
          if (_isInv && element.invSymbol != null) {
            expr = element.invExpression ?? element.invSymbol!;
          } else {
            expr = element.expression ?? element.symbol;
          }
          if (_resultController.text == 'Format Error!') {
            if (expr == 'AC' || expr == 'C') {
              setState(() {
                _resultController.text = '';
              });
            } else {
              setState(() {
                _resultController.text = expr;
              });
            }
          } else {
            switch (expr) {
              case '=':
                _evaluate();
                break;
              case 'AC':
                setState(() {
                  _resultController.text = '';
                });
                break;
              case 'inv':
                setState(() {
                  _isInv = !_isInv;
                });
                break;
              case '.':
                var index = 0;
                var current = _resultController.text;
                var num = '';
                var flag = true;

                while (index < current.length) {
                  num += current[current.length - 1 - index];
                  for (var func in funcs) {
                    if (num.contains(func)) {
                      print(num.contains(func));
                      flag = false;
                      break;
                    }
                  }
                  if (!flag) {
                    break;
                  }
                  if (num.contains('.')) {
                    return;
                  }
                  index++;
                }

                if (_resultController.text.isEmpty ||
                    _resultController.text[_resultController.text.length - 1] !=
                        '.') {
                  setState(() {
                    _resultController.text += expr;
                  });
                }
                break;
              case 'C':
                try {
                  var index = 0;
                  var current = _resultController.text;
                  var func = '';
                  while (index < current.length) {
                    func += current[current.length - 1 - index];
                    index++;
                    var copy = func.split('').reversed.join('');
                    if (longFuncs.contains(copy)) {
                      setState(() {
                        _resultController.text =
                            _resultController.text.substring(
                          0,
                          _resultController.text.length - copy.length + 1,
                        );
                      });
                      break;
                    }
                  }

                  setState(() {
                    _resultController.text = _resultController.text
                        .substring(0, _resultController.text.length - 1);
                  });
                } catch (e) {
                  setState(() {
                    _resultController.text = '';
                  });
                }
                break;
              default:
                var isValid = true;
                var current =
                    '${_resultController.text}$expr'.split('').reversed.join();
                for (var i = 0; i < 16 && i < current.length; i++) {
                  if (!nums.contains(current[i])) {
                    break;
                  }
                  if (current[current.length - 1 - i] == '0') {
                    var copy = i;
                    while (copy < current.length && current[copy] == '0') {
                      copy++;
                    }
                    if (copy == current.length && current.length != 1) {
                      isValid = false;
                    }
                  }
                  if (i == 15) {
                    isValid = false;
                  }
                }
                if (isValid) {
                  setState(() {
                    _resultController.text += expr;
                  });
                }
            }
          }
        },
        child: Center(
          child: Text(
            _isInv && element.invSymbol != null
                ? element.invSymbol!
                : element.symbol,
            style: const TextStyle(
              fontSize: 23,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  void _evaluate() {
    try {
      Parser p = Parser();
      String expression = _resultController.text
          .replaceAll('x', '*')
          .replaceAll('÷', '/')
          .replaceAll('log(', 'log(10,')
          .replaceAll('acos', 'arccos')
          .replaceAll('asin', 'arcsin')
          .replaceAll('√', 'sqrt')
          .replaceAll('atan', 'arctan')
          .replaceAll('π', pi.toString())
          .replaceAll('e', e.toString());
      if ('('.allMatches(expression).length >
          ')'.allMatches(expression).length) {
        expression += ')';
      }

      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      var res = exp.evaluate(EvaluationType.REAL, cm);
      var ans = '';

      if (res > 999999999999999 || res.toString().contains('e+')) {
        throw 'pudge';
      } else if ((res - res.round()).abs() < 0.000001) {
        ans = res.round().toString();
      } else if (res == pi) {
        ans = 'π';
      } else if (res == e) {
        ans = 'e';
      } else {
        ans = '$res';
      }
      setState(() {
        _resultController.text = ans;
      });
    } catch (e) {
      setState(() {
        switch (e) {
          case 'pudge':
            _resultController.text = 'infinity';
            break;
          default:
            _resultController.text = 'Format Error!';
        }
      });
    }
  }
}
