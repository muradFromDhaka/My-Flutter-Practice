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
      theme: ThemeData(useMaterial3: true),
      home: const EmployeeForm(),
    );
  }
}

class EmployeeForm extends StatefulWidget {
  const EmployeeForm({super.key});

  @override
  State<EmployeeForm> createState() => _EmployeeFormState();
}

class _EmployeeFormState extends State<EmployeeForm> {
  final _formKey = GlobalKey<FormState>();

  String? _name;
  String? _email;
  String? _phone;
  String? _gender;
  DateTime? _dob;
  String? _country;
  String? _city;
  String? _department;
  DateTime? _joinDate;
  double? _salary;
  bool _isActive = false;
  bool _subscribe = false;

  List<String> countries = ["Bangladesh", "India", "USA", "UK", "Pakistan"];
  List<String> cities = [
    "Dhaka",
    "Chittagong",
    "Khulna",
    "Rajshahi",
    "Sylhet",
    "Barishal",
  ];
  List<String> departments = ["HR", "IT", "Sales", "Marketing", "Finance"];

  List<String> skills = ['Android', 'Flutter', 'Angular', 'Java', 'SQL'];
  List<String> selectedSkills = [];

  // ---------- DATE PICKER ----------
  Future<void> _pickDate({required bool isDob}) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        if (isDob) {
          _dob = picked;
        } else {
          _joinDate = picked;
        }
      });
    }
  }

  // ---------- SUBMIT ----------
  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      String skillResult = selectedSkills.join(", ");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Form submitted successfully!")),
      );

      debugPrint("Name: $_name");
      debugPrint("Email: $_email");
      debugPrint("Phone: $_phone");
      debugPrint("Gender: $_gender");
      debugPrint("DOB: $_dob");
      debugPrint("Country: $_country");
      debugPrint("City: $_city");
      debugPrint("Department: $_department");
      debugPrint("Join Date: $_joinDate");
      debugPrint("Salary: $_salary");
      debugPrint("Skills: $skillResult");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Employee Form")),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // ---------- NAME ----------
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.person),
                  ),
                  validator: (v) => v!.isEmpty ? "Name is required" : null,
                  onSaved: (v) => _name = v,
                ),

                const SizedBox(height: 10),

                // ---------- EMAIL ----------
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.email),
                  ),
                  validator: (v) => v!.isEmpty ? "Email is required" : null,
                  onSaved: (v) => _email = v,
                ),

                const SizedBox(height: 10),

                // ---------- PHONE ----------
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Phone",
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => v!.isEmpty ? "Phone is required" : null,
                  onSaved: (v) => _phone = v,
                ),

                const SizedBox(height: 15),

                // ---------- GENDER ----------
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Gender"),
                    RadioGroup(
                      groupValue: _gender,
                      onChanged: (v) => setState(() {
                        _gender = v;
                      }),
                      child: Row(
                        children: [
                          Radio(value: "Male"),
                          Text("Male"),
                          SizedBox(width: 20),
                          Radio(value: "Female"),
                          Text("Female"),
                          SizedBox(width: 20),
                          Radio(value: "Others"),
                          Text("Others"),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                // ---------- DOB ----------
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _dob == null
                            ? "Date of Birth"
                            : "DOB: ${_dob!.day}/${_dob!.month}/${_dob!.year}",
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _pickDate(isDob: true),
                      child: const Text("Pick DOB"),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                // ---------- COUNTRY ----------
                DropdownButtonFormField<String>(
                  initialValue: _country,
                  decoration: const InputDecoration(
                    labelText: "Country",
                    border: OutlineInputBorder(),
                  ),
                  items: countries
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (v) => setState(() => _country = v),
                ),

                const SizedBox(height: 10),

                // ---------- CITY ----------
                DropdownButtonFormField<String>(
                  initialValue: _city,
                  decoration: const InputDecoration(
                    labelText: "City",
                    border: OutlineInputBorder(),
                  ),
                  items: cities
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (v) => setState(() => _city = v),
                ),

                const SizedBox(height: 10),

                // ---------- DEPARTMENT ----------
                DropdownButtonFormField<String>(
                  initialValue: _department,
                  decoration: const InputDecoration(
                    labelText: "Department",
                    border: OutlineInputBorder(),
                  ),
                  items: departments
                      .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                      .toList(),
                  onChanged: (v) => setState(() => _department = v),
                ),

                const SizedBox(height: 15),

                // ---------- JOIN DATE ----------
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _joinDate == null
                            ? "Join Date"
                            : "Join: ${_joinDate!.day}/${_joinDate!.month}/${_joinDate!.year}",
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _pickDate(isDob: false),
                      child: const Text("Pick Join Date"),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                // ---------- SALARY ----------
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Salary",
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => v!.isEmpty ? "Salary is required" : null,
                  onSaved: (v) => _salary = double.tryParse(v!),
                ),

                const SizedBox(height: 15),

                // ---------- SKILLS ----------
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Skills: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  children: skills.map((skill) {
                    return CheckboxListTile(
                      title: Text(skill),
                      value: selectedSkills.contains(skill),
                      onChanged: (checked) {
                        setState(() {
                          checked == true
                              ? selectedSkills.add(skill)
                              : selectedSkills.remove(skill);
                        });
                      },
                    );
                  }).toList(),
                ),
                const Divider(),

                SwitchListTile(
                  title: const Text("Subscribe to Newsletter"),
                  value: _subscribe,
                  onChanged: (v) => setState(() {
                    _subscribe = v;
                  }),
                ),

                CheckboxListTile(
                  title: const Text("is Active?"),
                  value: _isActive,
                  onChanged: (v) => setState(() {
                    _isActive = v!;
                  }),
                ),
                const SizedBox(height: 20),

                // ---------- SUBMIT ----------
                ElevatedButton(onPressed: _submit, child: const Text("Submit")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
