class CalculatorModel {
  double calculate(double a, double b, String op) {
    switch (op) {
      case '+':
        return a + b;
      case '-':
        return a - b;
      case '*':
        return a * b;
      case '/':
        return b == 0 ? double.nan : a / b;
      case '%':
        return a % b;
      default:
        return 0;
    }
  }
}