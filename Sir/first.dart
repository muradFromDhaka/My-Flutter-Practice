void main() {
  
  print('Hello, Dart!');
  print('Result: ${2 + 3}');


  var name = 'John';  String city = 'New York';
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
  print('\n===== END =====');   

}