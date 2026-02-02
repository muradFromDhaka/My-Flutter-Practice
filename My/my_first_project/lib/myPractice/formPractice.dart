import 'package:flutter/material.dart';
import 'package:my_first_project/tostEx.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: FormPractice());
  }
}

class FormPractice extends StatefulWidget {
  const FormPractice({super.key});

  @override
  State<FormPractice> createState() => _FormPracticeState();
}

class _FormPracticeState extends State<FormPractice> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _email;
  String? _password;
  String? _gender;
  DateTime? _dob;
  String? _country;
  bool? _agree;
  bool _switch = false;
  List<String> countries = ["Bangladesh", "USA", "Pakisthan"];

  Future<void> _pickDate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2032),
    );

    if (_picked != null) {
      setState(() {
        _dob = _picked;
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Form data show in dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Form Data"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text("Name: $_name"),
                Text("Email: $_email"),
                Text("Password: $_password"),
                Text("Gender: ${_gender ?? 'Not selected'}"),
                Text(
                  "DOB: ${_dob != null ? '${_dob!.day}/${_dob!.month}/${_dob!.year}' : 'Not selected'}",
                ),
                Text("Country: ${_country ?? 'Not selected'}"),
                Text("Switch: ${_switch ? 'On' : 'Off'}"),
                Text("Agree: ${_agree == true ? 'Yes' : 'No'}"),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Form Practice")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.near_me),
                ),
                validator: (value) =>
                    value == null ? "Please enter your name" : null,
                onSaved: (value) => _name = value,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "email",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) => value == null ? "enter your email" : null,
                onSaved: (value) => _email = value,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "password",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.password),
                ),
                obscureText: true,
                validator: (value) =>
                    value == null ? "enter your password." : null,
                onSaved: (value) => _password = value,
              ),
              SizedBox(height: 10),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Gender", style: TextStyle(fontSize: 20)),
                  SizedBox(height: 15),
                  RadioGroup(
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value;
                      });
                    },
                    child: Row(
                      children: [
                        Radio(value: "Male"),
                        Text("Male"),
                        Radio(value: "Female"),
                        Text("Female"),
                        Radio(value: "Other"),
                        Text("other"),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),

                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                      labelText: "Country",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.map),
                    ),
                    items: countries
                        .map(
                          (country) => DropdownMenuItem(
                            value: country,
                            child: Text(country),
                          ),
                        )
                        .toList(),
                    onChanged: (value) => setState(() => _country = value),
                  ),
                  SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _dob == null
                              ? "select your dob"
                              : "DOB: ${_dob!.day}/${_dob!.month}/${_dob!.year}",
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _pickDate,
                        child: Text("PickDate"),
                      ),
                    ],
                  ),

                  SizedBox(height: 15),
                  SwitchListTile(
                    title: const Text("I agree to receive newsletter"),
                    value: _switch,
                    onChanged: (value) => setState(() {
                      _switch = value;
                    }),
                  ),
                ],
              ),

              SizedBox(height: 15),
              CheckboxListTile(
                title: const Text("I agree to terms."),
                value: _agree ?? false,
                onChanged: (value) => setState(() {
                  _agree = value!;
                }),
              ),
              SizedBox(height: 15),
              ElevatedButton(onPressed: _submit, child: const Text("submit")),
            ],
          ),
        ),
      ),
    );
  }
}
