import 'equal_logic.dart';

class Logic {
  final String buttonId;
  final String currentScreen;

  Logic(this.buttonId, this.currentScreen);

  static String newScreenValue(buttonId, currentScreen) {
    if (buttonId == '=') {
      print('equal pressed');
      return equalButtonPressed(currentScreen);
    } else if (buttonId == 'CE' || buttonId == 'AC') {
      return '0';
    } else if (buttonId == 'DEL') {
      if (currentScreen.length <= 1) return currentScreen;

      var temp = currentScreen.split('');
      temp.removeLast();
      return temp.join();
    } else if ('0123456789+-*/()DEL'.contains(buttonId)) {
      currentScreen == '0' ? currentScreen = '' : null;
      return currentScreen + buttonId;
    } else {
      return 'work in progress';
    }
  }
}