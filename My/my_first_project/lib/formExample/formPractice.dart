import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      darkTheme: ThemeData(primarySwatch: Colors.yellow),
      home: PracticeForm(),
    );
  }
}

class PracticeForm extends StatefulWidget {
  const PracticeForm({super.key});

  @override
  State<PracticeForm> createState() => _PracticeFormState();
}

class _PracticeFormState extends State<PracticeForm> {
  final _formKey = GlobalKey<FormState>();

  String? _name;
  String? _email;
  String? _passwrod;
  String? _gender;
  DateTime? _dob;
  String? _country;
  bool _subscribe = false;
  bool _switchValue = false;

  List<String> countries = ["Bangladesh", "India", "USA", "UK"];

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _dob = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("practice form")),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.near_me),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Please Enter your name" : null,
                onSaved: (value) => _name = value,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Enter your email" : null,
                onSaved: (newValue) => _email = newValue,
              ),
              SizedBox(height: 10),

              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.password),
                ),
                obscureText: true,
                validator: (value) =>
                    value!.isEmpty ? "enter valid password" : null,
                onSaved: (newValue) => _passwrod = newValue,
              ),
              SizedBox(height: 10),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Gender"),
                  SizedBox(height: 10),

                  RadioGroup(
                    groupValue: _gender,
                    onChanged: (value) => setState(() {
                      _gender = value;
                    }),
                    child: Row(
                      children: [
                        Radio(value: "Male"),
                        Text("Male"),
                        Radio(value: "Female"),
                        Text("Female"),
                        Radio(value: "Others"),
                        Text("Others"),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10),

              DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: "Country",
                  border: OutlineInputBorder(),
                ),
                items: countries.map((country) {
                  return DropdownMenuItem(value: country, child: Text(country));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _country = value as String?;
                  });
                },
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Subscribe to newsletter"),
                  Switch(
                    value: _switchValue,
                    onChanged: (value) {
                      setState(() {
                        _switchValue = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Process the data
                    }
                  },
                  child: Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
