/*
===========================================================
 ALL-IN-ONE DART PROGRAMMING TUTORIAL
 Beginner → Advanced (Single File)
===========================================================

HOW TO USE:
- This file contains MANY examples.
- Only ONE main() can run at a time.
- Uncomment the section you want to test inside main().

===========================================================
*/

import 'dart:async';
import 'dart:io';
import 'dart:isolate';

void main() async {
  print('\n===== DART ALL-IN-ONE TUTORIAL =====\n');

  // Uncomment ONE section at a time 👇

  // part1_intro();
  // part2_variables();
  // part3_operators();
  // part4_controlFlow();
  // part5_functions();
  // part6_oop();
  // part6_mixins();
  // part7_collections();
  // part8_futures();
  // part8_streams();
  // part9_errorHandling();
  // part10_generics();
  // part10_extensions();
  // await part10_isolates();
  // await todoAppDemo();

  print('\n===== END =====');
}

/* =========================================================
 PART 1: INTRODUCTION
========================================================= */
void part1_intro() {
  print('Hello, Dart!');
  print('Result: ${2 + 3}');
}

/* =========================================================
 PART 2: VARIABLES & DATA TYPES
========================================================= */
void part2_variables() {
  var name = 'John';
  String city = 'New York';
  dynamic value = 10;
  value = 'Changed';

  const pi = 3.14159;
  final time = DateTime.now();

  int age = 25;
  double price = 19.99;
  bool isActive = true;

  List<int> numbers = [1, 2, 3];
  Set<String> countries = {'USA', 'UK', 'USA'};
  Map<String, dynamic> user = {'name': 'Alice', 'age': 30};

  String? nullableText;
  print(nullableText ?? 'Default Value');

  print(name);
  print(numbers);
  print(countries);
  print(user);
}

/* =========================================================
 PART 3: OPERATORS
========================================================= */
void part3_operators() {
  int a = 10, b = 3;
  print(a + b);
  print(a ~/ b);
  print(a > b);

  String? text;
  print(text ?? 'Fallback');

  var list = [1, 2, 3]
    ..add(4)
    ..remove(2);
  print(list);
}

/* =========================================================
 PART 4: CONTROL FLOW
========================================================= */
void part4_controlFlow() {
  int age = 18;

  if (age >= 18) {
    print('Adult');
  } else {
    print('Minor');
  }

  for (int i = 1; i <= 3; i++) {
    print('Loop $i');
  }

  String day = 'Monday';
  switch (day) {
    case 'Monday':
      print('Start');
      break;
    default:
      print('Other');
  }
}

/* =========================================================
 PART 5: FUNCTIONS
========================================================= */
void part5_functions() {
  greet();
  print(add(5, 3));
  print(square(4));

  displayDetails(name: 'Alice', age: 25);
}

void greet() => print('Hello!');
int add(int a, int b) => a + b;
int square(int n) => n * n;

void displayDetails({required String name, int age = 20}) {
  print('$name is $age years old');
}

/* =========================================================
 PART 6: OOP
========================================================= */
void part6_oop() {
  var car = Car('Toyota', 2020);
  car.drive();

  var tesla = ElectricCar('Tesla', 2023, 75);
  tesla.drive();
  tesla.charge();

  print('Cars created: ${Car.totalCars}');
}

class Car {
  String brand;
  int year;
  static int totalCars = 0;

  Car(this.brand, this.year) {
    totalCars++;
  }

  void drive() {
    print('$brand driving');
  }
}

class ElectricCar extends Car {
  double battery;

  ElectricCar(String brand, int year, this.battery) : super(brand, year);

  @override
  void drive() {
    print('$brand driving silently');
  }

  void charge() {
    print('Charging $battery kWh');
  }
}

/* =========================================================
 PART 6.2: MIXINS
========================================================= */
void part6_mixins() {
  var dog = Dog();
  dog.eat();
  dog.swim();
}

mixin Swimmer {
  void swim() => print('Swimming...');
}

class Animal {
  void eat() => print('Eating...');
}

class Dog extends Animal with Swimmer {}

/* =========================================================
 PART 7: COLLECTIONS
========================================================= */
void part7_collections() {
  List<String> fruits = ['Apple', 'Banana'];
  fruits.add('Mango');

  Map<String, int> scores = {'Math': 90};
  scores['English'] = 85;

  Set<int> numbers = {1, 2, 2, 3};

  print(fruits);
  print(scores);
  print(numbers);
}

/* =========================================================
 PART 8.1: FUTURES
========================================================= */
void part8_futures() async {
  print('Fetching...');
  var data = await fetchData();
  print(data);
}

Future<String> fetchData() async {
  await Future.delayed(Duration(seconds: 2));
  return 'Data Loaded';
}

/* =========================================================
 PART 8.2: STREAMS
========================================================= */
void part8_streams() async {
  await for (var value in numberStream()) {
    print(value);
  }
}

Stream<int> numberStream() async* {
  for (int i = 1; i <= 5; i++) {
    await Future.delayed(Duration(milliseconds: 500));
    yield i;
  }
}

/* =========================================================
 PART 9: ERROR HANDLING
========================================================= */
void part9_errorHandling() {
  try {
    int result = 10 ~/ 0;
    print(result);
  } catch (e) {
    print('Error: $e');
  }
}

/* =========================================================
 PART 10.1: GENERICS
========================================================= */
void part10_generics() {
  var box = Box<String>('Secret');
  print(box.getItem());

  print(findMax(10, 20));
}

class Box<T> {
  T item;
  Box(this.item);
  T getItem() => item;
}

T findMax<T extends Comparable>(T a, T b) =>
    a.compareTo(b) > 0 ? a : b;

/* =========================================================
 PART 10.2: EXTENSIONS
========================================================= */
void part10_extensions() {
  print('dart'.capitalize());
  print(5.square());
}

extension StringExt on String {
  String capitalize() => this[0].toUpperCase() + substring(1);
}

extension IntExt on int {
  int square() => this * this;
}

/* =========================================================
 PART 10.3: ISOLATES
========================================================= */
Future<void> part10_isolates() async {
  final receivePort = ReceivePort();

  await Isolate.spawn(isolateTask, receivePort.sendPort);

  receivePort.listen((msg) {
    print(msg);
    receivePort.close();
  });
}

void isolateTask(SendPort sendPort) {
  int sum = 0;
  for (int i = 0; i < 1000000; i++) {
    sum += i;
  }
  sendPort.send('Isolate result: $sum');
}

/* =========================================================
 PART 11: MINI TODO APP (CLI)
========================================================= */
Future<void> todoAppDemo() async {
  List<String> todos = [];

  while (true) {
    print('\n1.Add  2.View  3.Exit');
    stdout.write('Choose: ');
    var choice = stdin.readLineSync();

    if (choice == '1') {
      stdout.write('Todo: ');
      var t = stdin.readLineSync();
      if (t != null) todos.add(t);
    } else if (choice == '2') {
      todos.asMap().forEach((i, v) => print('${i + 1}. $v'));
    } else {
      break;
    }
  }
}
