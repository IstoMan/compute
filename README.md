# Compute

A cross-platform calculator built with Flutter. Enter arithmetic expressions with standard operators, evaluate them with a custom infix-to-postfix engine, and see results in a dark-themed UI.

## Features

- Basic arithmetic: `+`, `-`, `×`, `÷`, `%`
- Decimal numbers and parentheses
- Unary minus (e.g. `-5 + 3`)
- Clear (`AC`), backspace (`⌫`), and equals (`=`)
- Color-coded display for normal input, results, and errors
- Runs on Android, iOS, web, Linux, macOS, and Windows

## Getting started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Dart ^3.11.5)

### Install dependencies

```bash
flutter pub get
```

### Run the app

```bash
flutter run
```

Pick a target device when prompted, or pass one explicitly:

```bash
flutter run -d chrome    # web
flutter run -d linux     # desktop
```

### Development with hot reload

`flutter-dev.sh` runs the app and watches `lib/` for changes, triggering hot reload on save (requires [entr](https://eradman.com/entrproject/)):

```bash
./flutter-dev.sh
```

## Project structure

```
lib/
├── main.dart           # App entry point
├── app.dart            # State, input handling, theme
├── calc.dart           # Expression parser and evaluator
├── models/
│   └── types.dart      # TextType and DigitType enums
└── widgets/
    ├── display.dart    # Result/input display
    ├── digit_button.dart
    └── main_board.dart # Calculator keypad layout
```

## How evaluation works

`calc.dart` implements a classic two-phase approach:

1. **Tokenize** the infix string into numbers, operators, and parentheses.
2. **Convert** to postfix (Reverse Polish Notation) using the shunting-yard algorithm.
3. **Evaluate** the postfix expression with a stack.

The public API is a single function:

```dart
double evaluate(String infix);
```

Invalid expressions (mismatched parentheses, division by zero, malformed input) throw `FormatException`, which the UI surfaces as an error state.

## License

Private project — not published to pub.dev.
