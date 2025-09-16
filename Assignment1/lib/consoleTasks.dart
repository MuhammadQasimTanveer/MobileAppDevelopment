import 'dart:io';

void main() {
  //TASK # 2
// Step 1: Take user name and age
  stdout.write("Enter your name: ");
  String name = stdin.readLineSync()!;

  stdout.write("Enter your age: ");
  int age  = int.parse(stdin.readLineSync()!);

  if (age < 18) {
    print("Sorry $name, you are not eligible to register.");
    return; // stop execution
  }

  // Step 2: Ask user how many numbers they want to enter
  stdout.write("How many numbers do you want to enter? ");
  int n = int.parse(stdin.readLineSync()!);

  List<int> numbers = [];

  // Step 2: Input numbers and store in list
  for (int i = 0; i < n; i++) {
    stdout.write("Enter number ${i + 1}: ");
    int num = int.parse(stdin.readLineSync()!);
    numbers.add(num);
  }

  // Step 3: Calculate sums and find largest/smallest
  int sumEven = 0;
  int sumOdd = 0;
  int largest = numbers[0];
  int smallest = numbers[0];

  for (int num in numbers)
  {
    if (num % 2 == 0) {
      sumEven += num;
    } else {
      sumOdd += num;
    }

    if (num > largest) largest = num;
    if (num < smallest) smallest = num;
  }

  // Step 4: Print results
  print("\nResults:");
  print("Sum of even numbers: $sumEven");
  print("Sum of odd numbers: $sumOdd");
  print("Largest number: $largest");
  print("Smallest number: $smallest");


  //TASK # 3

  stdout.write("Enter an integer to make Pattern : ");

  // Read input as String and convert it to int
  // The '!' tells Dart we are sure this value is not null
  int num = int.parse(stdin.readLineSync()!);

  for (int i = 1; i <= num; i++)
  {
    for (int j = 1; j <= i; j++)
    {
      stdout.write("$j "); // Print numbers on the same line with space
    }
    print(""); // Move to the next line after finishing a row
  }
  print("");
}