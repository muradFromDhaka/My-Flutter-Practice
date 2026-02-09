import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../db/database_helper2.dart';
import '../model/user2.dart';

class UserForm extends StatefulWidget {
  final User? user;
  const UserForm({super.key, this.user});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers (for text inputs)
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final ageCtrl = TextEditingController();
  final salaryCtrl = TextEditingController();

  // State variables (non-text inputs)
  Gender gender = Gender.male;
  String? department;
  bool isActive = true;
  DateTime? dob;
  File? _image;
  List<String> selectedSkills = [];

  final allSkills = ['Flutter', 'Java', 'Spring', 'SQL', 'Docker'];
  final allDepartments = ['IT', 'HR', 'Finance', 'Marketing'];

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      final u = widget.user!;
      nameCtrl.text = u.name;
      emailCtrl.text = u.email;
      phoneCtrl.text = u.phone;
      addressCtrl.text = u.address;
      ageCtrl.text = u.age.toString();
      salaryCtrl.text = u.salary.toStringAsFixed(2);
      gender = u.gender;
      department = u.department;
      isActive = u.isActive;
      dob = u.dob;
      selectedSkills = List.from(u.skills);
      if (u.imagePath != null) _image = File(u.imagePath!);
    }
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    addressCtrl.dispose();
    ageCtrl.dispose();
    salaryCtrl.dispose();
    super.dispose();
  }

  // ========================
  // Pick DOB
  // ========================
  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: dob ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => dob = picked);
  }

  // ========================
  // Pick Image (Camera / Gallery)
  // ========================
  Future<void> pickImage() async {
    final source = await showDialog<ImageSource>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Select Image Source'),
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.photo_camera),
            label: const Text('Camera'),
            onPressed: () => Navigator.pop(ctx, ImageSource.camera),
          ),
          TextButton.icon(
            icon: const Icon(Icons.photo_library),
            label: const Text('Gallery'),
            onPressed: () => Navigator.pop(ctx, ImageSource.gallery),
          ),
        ],
      ),
    );

    if (source != null) {
      final picked = await ImagePicker().pickImage(source: source);
      if (picked != null) setState(() => _image = File(picked.path));
    }
  }

  // ========================
  // Save User
  // ========================
  void saveUser() async {
    if (!_formKey.currentState!.validate() ||
        dob == null ||
        department == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    final user = User(
      id: widget.user?.id,
      name: nameCtrl.text.trim(),
      email: emailCtrl.text.trim(),
      phone: phoneCtrl.text.trim(),
      address: addressCtrl.text.trim(),
      age: int.parse(ageCtrl.text),
      salary: double.parse(salaryCtrl.text),
      gender: gender,
      department: department!,
      dob: dob!,
      createdAt: widget.user?.createdAt ?? DateTime.now(),
      isActive: isActive,
      skills: selectedSkills,
      imagePath: _image?.path,
    );

    final db = DatabaseHelper();
    widget.user == null ? await db.insertUser(user) : await db.updateUser(user);
    Navigator.pop(context);
  }

  // ========================
  // Helper to create text fields
  // ========================
  Widget buildTextField(
    String label,
    TextEditingController ctrl, {
    TextInputType type = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 12.0),
      child: TextFormField(
        controller: ctrl,
        keyboardType: type,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: validator,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user == null ? 'Add User' : 'Edit User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Image Picker
              GestureDetector(
                onTap: pickImage,
                child: Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    child: _image == null
                        ? const Icon(Icons.camera_alt, size: 40)
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Text Inputs
              buildTextField(
                'Name',
                nameCtrl,
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              buildTextField(
                'Email',
                emailCtrl,
                type: TextInputType.emailAddress,
                validator: (v) =>
                    v == null || !v.contains('@') || !v.contains('.')
                    ? 'Invalid email'
                    : null,
              ),
              buildTextField('Phone', phoneCtrl, type: TextInputType.phone),
              buildTextField('Address', addressCtrl),
              buildTextField(
                'Age',
                ageCtrl,
                type: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (v) =>
                    int.tryParse(v ?? '') == null ? 'Invalid age' : null,
              ),
              buildTextField(
                'Salary',
                salaryCtrl,
                type: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                validator: (v) =>
                    double.tryParse(v ?? '') == null ? 'Invalid salary' : null,
              ),
              const SizedBox(height: 10),

              // DOB
              ListTile(
                title: Text(
                  dob == null
                      ? 'Select Date of Birth'
                      : 'DOB: ${dob!.toIso8601String().split('T')[0]}',
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: pickDate,
              ),
              const SizedBox(height: 10),

              // Gender (Radio)
              const Text(
                'Gender',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),
              RadioGroup<Gender>(
                groupValue: gender,
                onChanged: (v) => setState(() => gender = v!),
                child: Row(
                  children: Gender.values.map((g) {
                    return Row(
                      children: [
                        Radio<Gender>(value: g),
                        Text(g.name.toUpperCase()),
                        const SizedBox(width: 16),
                      ],
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 10),

              // Department (Dropdown)
              DropdownButtonFormField<String>(
                value: department,
                decoration: const InputDecoration(
                  labelText: 'Department',
                  border: OutlineInputBorder(),
                ),
                items: allDepartments
                    .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                    .toList(),
                onChanged: (v) => setState(() => department = v),
                validator: (v) => v == null ? 'Select department' : null,
              ),
              const SizedBox(height: 10),

              // Active switch
              SwitchListTile(
                title: const Text('Active'),
                value: isActive,
                onChanged: (v) => setState(() => isActive = v),
              ),

              const Divider(),

              // // Skills (Checkboxes)
              // const Text(
              //   'Skills',
              //   style: TextStyle(fontWeight: FontWeight.bold),
              // ),

              // ...allSkills.map(
              //   (s) => CheckboxListTile(
              //     title: Text(s),
              //     value: skills.contains(s),
              //     onChanged: (v) =>
              //         setState(() => v! ? skills.add(s) : skills.remove(s)),
              //   ),
              // ),
              // const SizedBox(height: 20),
              const Text(
                'Skills',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              Column(
                children: allSkills.map((s) {
                  return CheckboxListTile(
                    title: Text(s),
                    value: selectedSkills.contains(s),
                    onChanged: (v) {
                      setState(
                        () => v!
                            ? selectedSkills.add(s)
                            : selectedSkills.remove(s),
                      );
                    },
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),

              // Save Button
              ElevatedButton(onPressed: saveUser, child: const Text('SAVE')),
            ],
          ),
        ),
      ),
    );
  }
}
