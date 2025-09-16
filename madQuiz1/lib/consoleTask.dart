import 'dart:io';

void main() {

  List<int> numbers = [];

  for (int i = 0; i < 6; i++) {
    stdout.write("Enter integer ${i + 1}: ");
    int value = int.parse(stdin.readLineSync()!);
    numbers.add(value);
  }

  int sumOdd = 0;
  for (int num in numbers) {
    if (num%2 != 0) {
      sumOdd += num;
    }
  }

  int smallest = numbers[0];
  for (int num in numbers) {
    if (num < smallest) {
      smallest = num;
    }
  }

  // Output
  print("Sum of odd numbers: $sumOdd");
  print("Smallest number: $smallest");
}
