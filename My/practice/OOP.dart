class Person{
  String? name;

Person(this.name);

 void displayName(){
    print("Name: $name");
  }
}

class Student extends Person{
  int? age;

  Student(super.name, this.age);

  

  void displayInfo() {
    print("Name: $name , Age: $age");
  }
}

// ==============================================
class Animal{
  
  void sound(){
    print("animal makes a sound");
  }
}

class Dog extends Animal{

  @override
  void sound(){
    print("Dog darks");
  }
}

class Cat extends Animal{
  @override
  void sound(){
    print("Cat sound");
  }
}



void main() {
  Student s1 = new Student("Murad", 27);
  s1.displayInfo();

  Student s2 = new Student("Habib", 27);
  s2.displayInfo();

  Person p = new Person("Ziaul");
  p.displayName();
  // ====================================

  Dog d = Dog();
  d.sound();

  Animal c = Cat();
  c.sound();
}
