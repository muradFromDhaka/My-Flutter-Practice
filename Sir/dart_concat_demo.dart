/*
===========================================================
 DART CONCATENATION DEMO - STRINGS + NUMBERS + OTHER TYPES
===========================================================
*/

void main() {
  print('===== DART CONCATENATION DEMO =====\n');

  // -------------------------------
  // 1️⃣ String + String using '+'
  // -------------------------------
  String firstName = 'John';
  String lastName = 'Doe';
  // String fullName = firstName + ' ' + lastName;
  String fullName = '$firstName $lastName';

  print('String + String: $fullName'); // John Doe

  // -------------------------------
  // 2️⃣ String + Number using '+'
  // -----------------------------{--
  int age = 25;
  String ageInfo = 'Age: ${age + 5}'; // convert number to string

  print('String + Number: $ageInfo');

  double price = 19.99;
  String priceInfo = 'Price: ' + price.toString();
  print('String + Double: $priceInfo');

  // -------------------------------
  // 3️⃣ Using String Interpolation
  // -------------------------------
  String greeting = 'Hello, $firstName $lastName! You are $age years old.';
  print('Interpolation: $greeting');

  String calc = 'Next year, you will be ${age + 1} years old.';
  print('Interpolation with expression: $calc');

  // -------------------------------
  // 4️⃣ Concatenation with boolean
  // -------------------------------
  bool isStudent = true;
  String status = 'Is student: ' + isStudent.toString();
  print('Boolean concatenation: $status');

  String status2 = 'Is student: $isStudent';
  print('Boolean interpolation: $status2');

  // -------------------------------
  // 5️⃣ Concatenation with Lists
  // -------------------------------
  List<String> fruits = ['Apple', 'Banana', 'Orange'];
  String fruitString = 'Fruits: ' + fruits.join(', ');
  print('List concatenation: $fruitString');

  String fruitString2 = 'Fruits: ${fruits.join(' | ')}';
  print('List interpolation: $fruitString2');

  // -------------------------------
  // 6️⃣ Concatenation with Maps
  // -------------------------------
  Map<String, dynamic> person = {
    'name': 'Alice',
    'age': 30,
    'city': 'New York',
  };

  String personInfo =
      'Person: ' + person['name'] + ', Age: ' + person['age'].toString();
  print('Map concatenation: $personInfo');

  String personInfo2 =
      'Person: ${person['name']}, Age: ${person['age']}, City: ${person['city']}';
  print('Map interpolation: $personInfo2');

  // -------------------------------
  // 7️⃣ Using StringBuffer (efficient concatenation)
  // -------------------------------
  var buffer = StringBuffer();
  buffer.write('Hello');
  buffer.write(' ');
  buffer.write('World');
  buffer.write('! ');
  buffer.write('You are $age years old.');
  print('StringBuffer: ${buffer.toString()}');

  // -------------------------------
  // 8️⃣ Concatenation with other types using toString()
  // -------------------------------
  double temperature = 36.6;
  String tempInfo = 'Temperature: ' + temperature.toString() + '°C';
  print('Double concatenation: $tempInfo');

  DateTime now = DateTime.now();
  String dateInfo = 'Today is: ' + now.toString();
  print('DateTime concatenation: $dateInfo');

  // -------------------------------
  // 9️⃣ Multi-line concatenation
  // -------------------------------
  String multiLine = 'Line1\n' + 'Line2\n' + 'Line3';
  print('Multi-line concatenation:\n$multiLine');

  String multiLine2 = '''
Line1
Line2
Line3
''';
  print('Multi-line using triple quotes:\n$multiLine2');

  // -------------------------------
  // DONE
  // -------------------------------
  print('\n===== END OF CONCATENATION DEMO =====');
}
