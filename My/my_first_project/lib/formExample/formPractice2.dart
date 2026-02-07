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
      home: PracticeForm2(),
    );
  }
}

class PracticeForm2 extends StatefulWidget {
  const PracticeForm2({super.key});

  @override
  State<PracticeForm2> createState() => _PracticeForm2State();
}

class _PracticeForm2State extends State<PracticeForm2> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _email;
  String? _password;
  String? _gender;
  bool _subscribe = false;
  String? _country;
  bool _switchValue = false;
  DateTime? _dob;

  final countries = ["Bangladesh", "India", "USA", "UK"];

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _dob = picked;
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print("Name; $_name");
      print("Email: $_email");
      print("password: $_password");
      print("gender: $_gender");
      print("subscribe: $_subscribe");
      print("country: $_country");
      print("switchValue: $_switchValue");
      print("DOB: $_dob");

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Form submitted successfully!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Form Practice 2")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Center(
                  child: Text(
                    "Form Practice 2",
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),

                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.near_me),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Name is required" : null,
                  onSaved: (newValue) => _name = newValue,
                ),
                SizedBox(height: 10),

                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Email is required" : null,
                  onSaved: (newValue) => _email = newValue,
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Email is required" : null,
                  onSaved: (newValue) => _email = newValue,
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "password",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Password is required" : null,
                  onSaved: (newValue) => _password = newValue,
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
                          Radio(value: "Other"),
                          Text("Other"),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _dob == null
                                ? "Select Date of Birth"
                                : "DOB: ${_dob!.day}/${_dob!.month}/${_dob!.year}",
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _pickDate,
                          child: Text("Pick Date"),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),

                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: "Select your Country",
                        border: OutlineInputBorder(),
                      ),
                      value: _country,
                      onChanged: (value) => setState(() => _country = value),
                      items: countries
                          .map(
                            (country) => DropdownMenuItem(
                              value: country,
                              child: Text(country),
                            ),
                          )
                          .toList(),
                      validator: (value) =>
                          value == null ? "Please select a country" : null,
                      onSaved: (value) => _country = value,
                    ),

                    SizedBox(height: 10),
                    CheckboxListTile(
                      title: Text("Subscribe to newsletter"),
                      value: _subscribe,
                      onChanged: (value) => setState(() {
                        _subscribe = value!;
                      }),
                    ),
                    SizedBox(height: 10),
                    SwitchListTile(
                      title: Text("Enable Notifications"),
                      value: _switchValue,
                      onChanged: (value) => setState(() {
                        _switchValue = value;
                      }),
                    ),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submit,
                        child: Text("Submit"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
