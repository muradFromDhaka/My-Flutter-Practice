void main() {
  print("===============for loop================");
  int i = 1;
  for (int a = 1; a <= 5; a++) {
    print("Hello : ${i}");
    i++;
  }

  print("===============switch-case================");

  String day = "sdsd";
  switch (day) {
    case "Friday":
      print("The day is good day" + day);
      break;
    case "sunday":
      print("The day is " + day);
      break;
    case "saturday":
      print("The day is " + day);
      break;
    case "monday":
      print("The day is " + day);
      break;
    case "Tuesday":
      print("The day is " + day);
      break;
    case "Wednesday":
      print("The day is " + day);
      break;
    case "Thursday":
      print("The day is " + day);
      break;
    default:
      print("invalid day");
  }

  print("===============while loop================");
  double b = 1;
  while (b <= 5) {
    print("Hello world: ${b + 1}");
    b++;
  }

  do {
    print("do while: $b");
    print("Bangladesh:" + b.toString());
    b++;
  } while (b <= 7);

  print("===============for-in loop================");

  List<String> fruits = ["Apple","Orange","Banana","Mango","Pineapple","Watermelon","Papaya","Strawberry"];
  for (String fruit in fruits) {
    if (fruit == "Apple") {
      continue;
    } else if (fruit == "Orange") {
      continue;
    } else if(fruit == "Pineapple") {
      print("$fruit is an excellent fruit");
    }else if (fruit == "Watermelon") {
      continue;
    }else if (fruit == "Papaya") {
      continue;
    }else if (fruit == "Strawberry") {
      continue;
    }
  }

  print("===============for-in loop================");

fruits.forEach((fruit) {
    switch (fruit) {
      case "Apple":
        print("$fruit is an excellent fruit");
        break;
      case "Papaya":
        print("$fruit helps digestion");
        break;
      case "Strawberry":
        print("$fruit is red and tasty");
        break;
      default:
        print("Unknown fruit");
    }
  });


}
