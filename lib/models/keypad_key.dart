class KeypadKey {
  static const numbers = [
    KeypadKey('1'),
    KeypadKey('2', 'A B C'),
    KeypadKey('3', 'D E F'),
    KeypadKey('4', 'G H I'),
    KeypadKey('5', 'J K L'),
    KeypadKey('6', 'M N O'),
    KeypadKey('7', 'P Q R S'),
    KeypadKey('8', 'T U V'),
    KeypadKey('9', 'W X Y Z'),
    KeypadKey('*'),
    KeypadKey('0', '+'),
    KeypadKey('#'),
  ];

  const KeypadKey(this.text, [this.subtext = '']);

  final String text;
  final String subtext;
}
