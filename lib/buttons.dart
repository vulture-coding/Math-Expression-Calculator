import 'package:flutter/material.dart';
import 'style.dart';

class ButtonId {
  static const String zero = '0',
      one = '1',
      two = '2',
      three = '3',
      four = '4',
      five = '5',
      six = '6',
      seven = '7',
      eight = '8',
      nine = '9',
      equal = '=',
      add = '+',
      subtract = '-',
      multiply = '*',
      divide = '\u00f7',
      openParentheses = '(',
      closeParentheses = ')',
      dot = '.',
      squareRoot = '\u221a',
      c = 'C',
      ac = 'AC',
      delete = '<-',
      power = '^',
      mc = 'MC',
      mr = 'MR',
      mAdd = 'M+',
      mSub = 'M-',
      ms = 'MS',
      pi = 'pi';
  ButtonId();
}

class FunctionButton extends StatelessWidget {
  final String keyText;
  const FunctionButton(this.keyText, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: DefaultSizes.defaultKeyPadding),
        child: TextButton(
          style: functionButtonStyle(),
          onPressed: () {},
          child: Text(keyText),
        ),
      ),
    );
  }
}

class ButtonLabel extends StatelessWidget {
  final String buttonId;
  const ButtonLabel(this.buttonId, {super.key});

  @override
  Widget build(BuildContext context) {
    Widget label = const Placeholder();

    if ('0123456789.()AC'.contains(buttonId)) {
      label = Text(buttonId);
    } else {
      switch (buttonId) {
        case ButtonId.add:
          label = const Icon(Icons.add);
          break;
        case ButtonId.subtract:
          label = const Icon(Icons.remove);
          break;
        case ButtonId.multiply:
          label = const Icon(Icons.close);
          break;
        case ButtonId.divide:
          label = const Text(ButtonId.divide);
          break;
        case ButtonId.squareRoot:
          label = const Text('²${ButtonId.squareRoot}');
          break;
        case ButtonId.delete:
          label = const Icon(Icons.backspace_outlined);
          break;
        case ButtonId.power:
          label = const Text('xⁿ');
          break;
        case ButtonId.mc:
          break;
        case ButtonId.mr:
          break;
        case ButtonId.mAdd:
          break;
        case ButtonId.mSub:
          break;
        case ButtonId.ms:
          break;
        case ButtonId.pi:
          label = const Text('\u03c0');
          break;
      }
    }

    return label;
  }
}

class DefaultButton extends StatelessWidget {
  final String buttonId;
  final Function buttonFunction;
  const DefaultButton(this.buttonId, this.buttonFunction, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(DefaultSizes.defaultKeyPadding),
        child: ElevatedButton(
          onPressed: () => buttonFunction(buttonId),
          child: ButtonLabel(buttonId),
        ),
      ),
    );
  }
}

class EqualButton extends StatelessWidget {
  final Function buttonFunction;
  const EqualButton(this.buttonFunction, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: EdgeInsets.all(DefaultSizes.defaultKeyPadding),
        child: ElevatedButton(
          style: equalButtonStyle(),
          onPressed: () => buttonFunction(ButtonId.equal),
          child: Text(ButtonId.equal),
        ),
      ),
    );
  }
}
