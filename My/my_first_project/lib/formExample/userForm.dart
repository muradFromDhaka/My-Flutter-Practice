import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true), // enable Material 3
      home: const Userform(),
    );
  }
}

class Userform extends StatefulWidget {
  const Userform({super.key});

  @override
  State<Userform> createState() => _UserformState();
}

class _UserformState extends State<Userform> {
  final _formKey = GlobalKey<FormState>();

  String? _name;
  String? _email;
  String? _age;
  DateTime? _dob;
  String? _gender;
  String? _country;
  bool _active = false;

  final List<String> countries = ["Bangladesh", "USA", "Pakisthan", "UK"];

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
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

      print("Name: $_name");
      print("Email: $_email");
      print("Age: $_age");
      print("DOB: $_dob");
      print("Gender: $_gender");
      print("Country: $_country");
      print("Active: $_active");

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("User form submitted.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Form"),
        titleSpacing: 15,
        backgroundColor: Colors.purple,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.only(top: 100)),
              Center(child: Icon(Icons.camera_enhance, size: 100)),
              SizedBox(height: 20),

              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Please enter your name" : null,
                onSaved: (value) => _name = value,
              ),
              const SizedBox(height: 16),

              // Email
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    value!.isEmpty ? "Please enter your email" : null,
                onSaved: (value) => _email = value,
              ),
              const SizedBox(height: 16),

              // Age
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Age",
                  border: OutlineInputBorder(),
                  // prefixIcon: Icon(Icons.age),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    value!.isEmpty ? "Please enter your age" : null,
                onSaved: (value) => _age = value,
              ),
              const SizedBox(height: 16),

              // Date Picker
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
                    child: const Text("Pick Date"),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Gender",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),

                  RadioGroup(
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value;
                      });
                    },
                    child: Row(
                      children: const [
                        Radio(value: "Male"),
                        Text("Male"),
                        SizedBox(width: 15),
                        Radio(value: "Female"),
                        Text("Female"),
                        SizedBox(width: 15),
                        Radio(value: "Others"),
                        Text("Others"),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Country Dropdown
              DropdownButtonFormField<String>(
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
                onChanged: (value) {
                  setState(() {
                    _country = value;
                  });
                },
                validator: (value) =>
                    value == null ? "Please select your country" : null,
              ),
              const SizedBox(height: 16),

              // Notifications Switch
              SwitchListTile(
                title: const Text("active"),
                value: _active,
                onChanged: (value) {
                  setState(() {
                    _active = value;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  child: const Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
