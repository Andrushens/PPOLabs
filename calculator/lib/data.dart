import 'dart:math';

import 'package:flutter/material.dart';

class ButtonElement {
  final String symbol;
  final String? expression;
  final String? invSymbol;
  final String? invExpression;
  final Color? color;

  ButtonElement({
    required this.symbol,
    this.invSymbol,
    this.invExpression,
    this.expression,
    this.color,
  });
}

final defaultButtonElementsLists = <List<ButtonElement>>[
  <ButtonElement>[
    ButtonElement(
      symbol: 'AC',
      color: const Color(0xFFE9E697),
    ),
    ButtonElement(
      symbol: '(',
      color: const Color(0xFFFFDAC7),
    ),
    ButtonElement(
      symbol: ')',
      color: const Color(0xFFFFDAC7),
    ),
    ButtonElement(
      symbol: '÷',
      color: const Color(0xFFFFDAC7),
    ),
  ],
  <ButtonElement>[
    ButtonElement(
      symbol: '7',
      color: const Color(0xFFF9F1EE),
    ),
    ButtonElement(
      symbol: '8',
      color: const Color(0xFFF9F1EE),
    ),
    ButtonElement(
      symbol: '9',
      color: const Color(0xFFF9F1EE),
    ),
    ButtonElement(
      symbol: 'x',
      color: const Color(0xFFFFDAC7),
    )
  ],
  <ButtonElement>[
    ButtonElement(
      symbol: '4',
      color: const Color(0xFFF9F1EE),
    ),
    ButtonElement(
      symbol: '5',
      color: const Color(0xFFF9F1EE),
    ),
    ButtonElement(
      symbol: '6',
      color: const Color(0xFFF9F1EE),
    ),
    ButtonElement(
      symbol: '-',
      color: const Color(0xFFFFDAC7),
    )
  ],
  <ButtonElement>[
    ButtonElement(
      symbol: '1',
      color: const Color(0xFFF9F1EE),
    ),
    ButtonElement(
      symbol: '2',
      color: const Color(0xFFF9F1EE),
    ),
    ButtonElement(
      symbol: '3',
      color: const Color(0xFFF9F1EE),
    ),
    ButtonElement(
      symbol: '+',
      color: const Color(0xFFFFDAC7),
    )
  ],
  <ButtonElement>[
    ButtonElement(
      symbol: '0',
      color: const Color(0xFFF9F1EE),
    ),
    ButtonElement(
      symbol: '.',
      color: const Color(0xFFF9F1EE),
    ),
    ButtonElement(
      symbol: 'C',
      color: const Color(0xFFF9F1EE),
    ),
    ButtonElement(
      symbol: '=',
      color: const Color(0xFFFFDAC7),
    ),
  ],
];

final scientificButtonElementsLists = <List<ButtonElement>>[
  <ButtonElement>[
    ButtonElement(
      symbol: '√',
      invSymbol: '^2',
    ),
    ButtonElement(
      symbol: 'π',
      expression: pi.toString().substring(0, 6),
    ),
    ButtonElement(
      symbol: '^',
    ),
    ButtonElement(
      symbol: '%',
    ),
  ],
  <ButtonElement>[
    ButtonElement(
      symbol: 'sin',
      expression: 'sin(',
      invSymbol: 'asin',
      invExpression: 'asin(',
    ),
    ButtonElement(
      symbol: 'cos',
      expression: 'cos(',
      invSymbol: 'acos',
      invExpression: 'acos(',
    ),
    ButtonElement(
      symbol: 'tan',
      expression: 'tan(',
    ),
    ButtonElement(
      symbol: 'atan',
      expression: 'atan(',
    ),
  ],
  <ButtonElement>[
    ButtonElement(
      symbol: 'e',
      expression: e.toString().substring(0, 6),
    ),
    ButtonElement(
      symbol: 'ln',
      expression: 'ln(',
      invSymbol: 'e^',
    ),
    ButtonElement(
      symbol: 'log',
      expression: 'log(',
      invSymbol: '10^',
    ),
    ButtonElement(
      symbol: 'inv',
    ),
  ],
];
