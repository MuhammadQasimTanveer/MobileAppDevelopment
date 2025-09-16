import 'dart:io';

void main() {

                               /*Task2*/

  // Step 1: Take user input for name and age
  stdout.write("Enter your name: ");
  String name = stdin.readLineSync()!;

  stdout.write("Enter your age: ");
  int age = int.parse(stdin.readLineSync()!);

  // Condition check
  if (age < 18) {
    print("Sorry $name, you are not eligible to register.");
    return; // stop execution
  }

  // Step 2: Ask how many numbers user wants to enter
  stdout.write("How many numbers do you want to enter? ");
  int n = int.parse(stdin.readLineSync()!);

  // Step 3: Take numbers input and store in list
  List<int> numbers = [];
  for (int i = 0; i < n; i++) {
    stdout.write("Enter number ${i + 1}: ");
    int num = int.parse(stdin.readLineSync()!);
    numbers.add(num);
  }

  // Step 4: Calculate results
  int evenSum = 0;
  int oddSum = 0;

  // Initialize largest and smallest with first element
  int largest = numbers[0];
  int smallest = numbers[0];

  for (int num in numbers) {
    // Even / odd check
    if (num % 2 == 0) {
      evenSum += num;
    } else {
      oddSum += num;
    }

    // Largest check
    if (num > largest) {
      largest = num;
    }

    // Smallest check
    if (num < smallest) {
      smallest = num;
    }
  }

  // Step 5: Print results
  print("\nResults:");
  print("Sum of even numbers: $evenSum");
  print("Sum of odd numbers: $oddSum");
  print("Largest number: $largest");
  print("Smallest number: $smallest");
  print("");


                                  /*Task3*/

  stdout.write("Enter an integer to make Pattern: ");
  int num = int.parse(stdin.readLineSync()!);

  for (int i = 1; i <= num; i++) {
    for (int j = 1; j <= i; j++) {
      stdout.write("$j ");
    }
    print(""); // new line after each row
  }
}
