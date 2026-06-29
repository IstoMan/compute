library;

const _operators = {'+', '-', '*', '/', '%'};

int _precedence(String op) {
  return switch (op) {
    '+' || '-' => 1,
    '*' || '/' || '%' => 2,
    _ => 0,
  };
}

bool _isDigit(String c) => c.codeUnitAt(0) >= 48 && c.codeUnitAt(0) <= 57;

bool _isOperator(String token) => _operators.contains(token);

String _normalizeOperator(String c) {
  return switch (c) {
    '×' => '*',
    '÷' => '/',
    _ => c,
  };
}

bool _isOperatorChar(String c) =>
    _operators.contains(c) || c == '×' || c == '÷';

List<String> _tokenizeInfix(String infix) {
  if (infix.isEmpty) return [];

  final tokens = <String>[];
  final buffer = StringBuffer();
  var i = 0;

  while (i < infix.length) {
    final c = infix[i];

    if (c == ' ') {
      i++;
      continue;
    }

    if (_isDigit(c) || c == '.') {
      buffer.write(c);
      i++;
      while (i < infix.length && (_isDigit(infix[i]) || infix[i] == '.')) {
        buffer.write(infix[i]);
        i++;
      }
      tokens.add(buffer.toString());
      buffer.clear();
      continue;
    }

    if (c == '-' &&
        (tokens.isEmpty || _isOperator(tokens.last) || tokens.last == '(')) {
      buffer.write(c);
      i++;
      continue;
    }

    if (c == '(' || c == ')') {
      tokens.add(c);
      i++;
      continue;
    }

    if (_isOperatorChar(c)) {
      tokens.add(_normalizeOperator(c));
      i++;
      continue;
    }

    throw FormatException('Invalid character in expression: $c');
  }

  if (buffer.isNotEmpty) {
    tokens.add(buffer.toString());
  }

  return tokens;
}

List<String> _infixToPostfix(String infix) {
  final tokens = _tokenizeInfix(infix);
  if (tokens.isEmpty) return [];

  final output = <String>[];
  final stack = <String>[];

  for (final token in tokens) {
    if (double.tryParse(token) != null) {
      output.add(token);
      continue;
    }

    if (token == '(') {
      stack.add(token);
      continue;
    }

    if (token == ')') {
      while (stack.isNotEmpty && stack.last != '(') {
        output.add(stack.removeLast());
      }
      if (stack.isEmpty) {
        throw FormatException('Mismatched parentheses');
      }
      stack.removeLast();
      continue;
    }

    if (_isOperator(token)) {
      while (stack.isNotEmpty &&
          stack.last != '(' &&
          _precedence(stack.last) >= _precedence(token)) {
        output.add(stack.removeLast());
      }
      stack.add(token);
      continue;
    }

    throw FormatException('Unexpected token: $token');
  }

  while (stack.isNotEmpty) {
    final op = stack.removeLast();
    if (op == '(' || op == ')') {
      throw FormatException('Mismatched parentheses');
    }
    output.add(op);
  }

  return output;
}

double _applyOperator(double a, double b, String op) {
  return switch (op) {
    '+' => a + b,
    '-' => a - b,
    '*' => a * b,
    '/' => b == 0 ? throw FormatException('Division by zero') : a / b,
    '%' => b == 0 ? throw FormatException('Division by zero') : a % b,
    _ => throw FormatException('Unknown operator: $op'),
  };
}

double _evaluatePostfix(List<String> postfix) {
  if (postfix.isEmpty) return 0;

  final stack = <double>[];

  for (final token in postfix) {
    final value = double.tryParse(token);
    if (value != null) {
      stack.add(value);
      continue;
    }

    if (!_isOperator(token)) {
      throw FormatException('Invalid postfix token: $token');
    }

    if (stack.length < 2) {
      throw FormatException('Invalid expression');
    }

    final b = stack.removeLast();
    final a = stack.removeLast();
    stack.add(_applyOperator(a, b, token));
  }

  if (stack.length != 1) {
    throw FormatException('Invalid expression');
  }

  return stack.single;
}

/// Parses an infix expression and returns its numeric value.
double evaluate(String infix) {
  return _evaluatePostfix(_infixToPostfix(infix));
}
