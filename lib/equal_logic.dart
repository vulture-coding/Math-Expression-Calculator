import 'dart:math';

import 'package:calculator2/buttons.dart';

String calculateMathExpr(String s) {
  // if input doesnt contain digits, returns error
  if (!s.contains(RegExp(r'\d'))) return expressionError;

  // if input contains repeated operators, returns error
  if (s.contains(RegExp('[${ButtonId.divide}^*+]{2,}')) ||
      s.contains('--') ||
      s.contains(ButtonId.squareRoot + ButtonId.squareRoot)) {
    return expressionError;
  }

  // gets rid of trailing .0s and returns it
  return parentheses(s).replaceAll(RegExp(r'\.0+$'), '');
}

const String expressionError = 'invalid expression';

String parentheses(String s) {
  // skips this function if no parentheses are found
  if (!s.contains('(')) return addSub(multDiv(powRoot(s)));
  int prths = 0;
  String tempS = '';

  for (int i = 0; i < s.length; i++) {
    if (s[i] == '(' || s[i] == ')') {
      if (s[i] == ')') {
        prths--;
      } else {
        prths++;
        if (i > 0 && isNum(s[i - 1])) tempS += '*';
      }
    }
    tempS += s[i];
  }
  // returns error if the number of '(' & ')' are different
  if (prths != 0) return expressionError;

  s = tempS;

  // Locates the first math espression between parentheses without any
  // parentheses within it
  String betweenPar = (RegExp(r'\([^\(\)]+\)').firstMatch(s)![0]!);

  // Removes the parentheses from both start and end, saving a clean expression
  betweenPar = betweenPar.replaceAll(RegExp(r'[\(\)]'), '');

  s = s.replaceAll('($betweenPar)', addSub(multDiv(powRoot(betweenPar))));
  if (s.contains('(')) {
    s = parentheses(s);
  }

  return addSub(multDiv(powRoot(s)));
}

bool isNum(String s) => '0123456789'.contains(s);

String addSub(String s) {
  //goes through a string and either adds or subtracts the next value
  //returns the sum of all operations

  if (s == expressionError) return expressionError;

  //skips this function if there's no adition or subtraction
  if (!s.contains('-') && !s.contains('+')) return s;

  List expr = cleaner(s);
  num result = 0;

  for (int i = 0; i < expr.length; i++) {
    if (expr[i] == '+') {
      result += num.parse(expr[i + 1]);
    } else if (expr[i] == '-') {
      result -= num.parse(expr[i + 1]);
    } else if (i == 0) {
      result += num.parse(expr[i]);
    }
  }

  return result.toString();
}

String powRoot(String s) {
  //goes through a string and executes all squareroots and power within it
  //while preserving all other symbols such as parentheses and/or sum/sub

  if (s == expressionError) return expressionError;

  //skips this function if there's no pow or sqrt
  if (!s.contains('\u221a') && !s.contains(ButtonId.power)) return s;

  List expr = cleaner(s);
  List result = [];

  for (int i = 0; i < expr.length; i++) {
    if (expr[i] == ButtonId.power || expr[i] == ButtonId.squareRoot) {
      num tempNum = expr[i + 1] == '-'
          ? num.parse(expr[i + 2]) * -1
          : num.parse(expr[i + 1]);
      if (expr[i] == ButtonId.power) {
        result.last = pow(num.parse(expr[i - 1]), tempNum);
      } else {
        if (tempNum < 0) return expressionError;
        if (i > 0 && isNum(result.last)) result.add('*');

        result.add(sqrt(tempNum));
      }
      expr[i + 1] == '-' ? i += 2 : i++;
    } else {
      result.add(expr[i]);
    }
  }
  return result.join(' ');
}

String multDiv(String s) {
  //goes through a string and executes all multiplications and divisions within it
  //while preserving all other symbols such as parentheses and/or sum/sub

  if (s == expressionError) return expressionError;

  //skips this function if there's no division or multiplication
  if (!s.contains(ButtonId.divide) && !s.contains(ButtonId.multiply)) return s;

  List expr = cleaner(s);
  List result = [];

  for (int i = 0; i < expr.length; i++) {
    if (expr[i] == ButtonId.multiply || expr[i] == ButtonId.divide) {
      num tempNum = expr[i + 1] == '-'
          ? num.parse(expr[i + 2]) * -1
          : num.parse(expr[i + 1]);

      if (expr[i] == ButtonId.divide) {
        if (tempNum == 0) return expressionError;
        result.last = (num.parse(result.last) / tempNum).toString();
      } else {
        result.last = (num.parse(result.last) * tempNum).toString();
      }
      expr[i + 1] == '-' ? i += 2 : i++;
    } else {
      result.add(expr[i]);
    }
  }
  return result.join(' ');
}

List cleaner(String s) {
  //removes all unecessary and/or redundant characters in string
  //returns a list with all separated elements
  s[0] == '(' ? s = '0+$s' : s;
  s = s
      .replaceAll(' ', '')
      .replaceAll('()', '')
      .replaceAll('--', '+')
      .replaceAll('-+ ', '-')
      .replaceAll('+-', '-')
      .split('')
      .map((e) => e = '0123456789.'.contains(e) ? e : ' $e ')
      .join();

  return s.replaceAll('  ', ' ').trim().split(' ');
}
