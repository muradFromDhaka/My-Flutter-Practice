/*
===========================================================
 ALL-IN-ONE DART DATA TYPES DEMO
===========================================================
*/

import 'dart:core';

void main() {
  print('===== DART DATA TYPES DEMO =====\n');

  // -------------------------------
  // 1️⃣ Numbers
  // -------------------------------
  int age = 25;
  double price = 19.99;
  num anyNumber = 10; // can be int
  anyNumber = 10.5; // can also be double

  print('--- Numbers ---');
  print('Int: $age' + 'sdasdfsd ${50}');
  print('Double: $price');
  print('Num: $anyNumber\n');

  // -------------------------------
  // 2️⃣ Strings
  // -------------------------------
  String name = 'Alice';
  String multiLine = '''
                          This is
                        a multi-line
                          string
                    ''';

  print('--- Strings ---');
  print('Name: $name');
  print(multiLine);

  int year = 2026;
  print('Interpolation: My name is $name and year is $year\n');

  // -------------------------------
  // 3️⃣ Booleans
  // -------------------------------
  bool isActive = true;
  bool isCompleted = false;

  print('--- Booleans ---');
  print('Active: $isActive, Completed: $isCompleted\n');

  // -------------------------------
  // 4️⃣ Lists
  // -------------------------------
  List<int> numbers = [1, 2, 3, 4, 5];
  var fruits = ['Apple', 'Banana', 'Orange', '50'];

  print('--- Lists ---');
  print('Numbers: $numbers');
  print('Fruits: $fruits');
  fruits.add('Mango');
  fruits.remove('Banana');
  print('Updated Fruits: $fruits\n');

  // -------------------------------
  // 5️⃣ Sets
  // -------------------------------
  Set<String> colors = {'Red', 'Green', 'Blue', 'Red'}; // duplicates removed
  colors.add('Yellow');
  colors.remove('Green');
  colors.addAll(['Purple', 'Orange']);

  print('--- Sets ---');
  print('Colors: $colors\n');

  // -------------------------------
  // 6️⃣ Maps
  // -------------------------------
  Map<String, dynamic> person = {'name': 'Alice', 'age': 25, 'isStudent': true};

  person['city'] = 'New York'; // add key
  person['age'] = 26; // update key
  person.remove('isStudent'); // remove key

  print(person['name']);
  print('--- Maps ---');
  print('Person Map: $person\n');

  // -------------------------------
  // 7️⃣ Runes & Symbols
  // -------------------------------
  String heart = '\u2665'; // Unicode for ♥
  Symbol sym = #mySymbol;

  print('--- Runes & Symbols ---');
  print('Heart symbol: $heart');
  print('Symbol: $sym\n');

  // -------------------------------
  // 8️⃣ Null & Nullable Types
  // -------------------------------

  int? abc;
  abc = null;
  print(abc);

  int? nullableValue;
  nullableValue = null;
  String? nullableName;
  print('--- Null & Nullable ---');
  print('Nullable Int: ${nullableValue ?? -1}');
  print('Nullable Name: ${nullableName ?? 'Default Name'}\n');

  // -------------------------------
  // 9️⃣ Dynamic & Object
  // -------------------------------
  dynamic value = 'Hello';
  value = 100;

  Object obj = 'Hi';
  String xyz = "Dart";
  //obj = 10; // Object cannot call string methods

  print('--- Dynamic & Object ---');
  print('Dynamic value: $value');
  print('Object: $obj\n');

  // -------------------------------
  // DONE
  // -------------------------------
  print('===== END OF DATA TYPES DEMO =====');
}
