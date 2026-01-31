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

  // Controllers
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final ageCtrl = TextEditingController();
  final salaryCtrl = TextEditingController();

  // State
  Gender gender = Gender.male;
  String? department;
  bool isActive = true;
  DateTime? dob;
  File? _image;
  List<String> skills = [];

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
      skills = List.from(u.skills);
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
      skills: skills,
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
    return TextFormField(
      controller: ctrl,
      keyboardType: type,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(labelText: label),
      validator: validator,
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
                    v == null || !v.contains('@') ? 'Invalid email' : null,
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
              Column(
                children: Gender.values
                    .map(
                      (g) => RadioListTile<Gender>(
                        title: Text(g.name.toUpperCase()),
                        value: g,
                        groupValue: gender,
                        onChanged: (v) => setState(() => gender = v!),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 10),

              // Department (Dropdown)
              DropdownButtonFormField<String>(
                value: department,
                decoration: const InputDecoration(labelText: 'Department'),
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

              // Skills (Checkboxes)
              const Text(
                'Skills',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ...allSkills.map(
                (s) => CheckboxListTile(
                  title: Text(s),
                  value: skills.contains(s),
                  onChanged: (v) =>
                      setState(() => v! ? skills.add(s) : skills.remove(s)),
                ),
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

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// import '../db/database_helper2.dart';
// import '../model/user2.dart';

// class UserForm extends StatefulWidget {
//   final User? user;

//   const UserForm({super.key, this.user});

//   @override
//   State<UserForm> createState() => _UserFormState();
// }

// class _UserFormState extends State<UserForm> {
//   final _formKey = GlobalKey<FormState>();

//   // ==============================
//   // CONTROLLERS
//   // ==============================
//   final nameCtrl = TextEditingController();
//   final emailCtrl = TextEditingController();
//   final phoneCtrl = TextEditingController();
//   final addressCtrl = TextEditingController();
//   final ageCtrl = TextEditingController();
//   final salaryCtrl = TextEditingController();

//   // ==============================
//   // STATE VALUES
//   // ==============================
//   Gender gender = Gender.male; // RADIO BUTTON FIELD
//   String? department; // DROPDOWN FIELD
//   bool isActive = true;
//   DateTime? dob;
//   File? _image;

//   List<String> skills = [];
//   final List<String> allSkills = ['Flutter', 'Java', 'Spring', 'SQL', 'Docker'];

//   final List<String> departments = [
//     'IT',
//     'HR',
//     'Finance',
//     'Marketing',
//   ]; // Example dropdown options

//   // ==============================
//   // INIT
//   // ==============================
//   @override
//   void initState() {
//     super.initState();

//     if (widget.user != null) {
//       final u = widget.user!;
//       nameCtrl.text = u.name;
//       emailCtrl.text = u.email;
//       phoneCtrl.text = u.phone;
//       addressCtrl.text = u.address;
//       ageCtrl.text = u.age.toString();
//       salaryCtrl.text = u.salary.toStringAsFixed(2);
//       gender = u.gender;
//       department = u.department; // NEW DROPDOWN FIELD
//       isActive = u.isActive;
//       dob = u.dob;
//       skills = List.from(u.skills);

//       if (u.imagePath != null) {
//         _image = File(u.imagePath!);
//       }
//     }
//   }

//   @override
//   void dispose() {
//     nameCtrl.dispose();
//     emailCtrl.dispose();
//     phoneCtrl.dispose();
//     addressCtrl.dispose();
//     ageCtrl.dispose();
//     salaryCtrl.dispose();
//     super.dispose();
//   }

//   // ==============================
//   // DATE PICKER
//   // ==============================
//   Future<void> pickDOB() async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: dob ?? DateTime.now(),
//       firstDate: DateTime(1950),
//       lastDate: DateTime.now(),
//     );

//     if (picked != null) {
//       setState(() => dob = picked);
//     }
//   }

//   // ==============================
//   // IMAGE PICKER
//   // ==============================
//   Future<void> pickImage() async {
//     final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (picked != null) {
//       setState(() => _image = File(picked.path));
//     }
//   }

//   // ==============================
//   // SAVE USER
//   // ==============================
//   Future<void> saveUser() async {
//     if (!_formKey.currentState!.validate() ||
//         dob == null ||
//         department == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please fill all required fields')),
//       );
//       return;
//     }

//     final user = User(
//       id: widget.user?.id,
//       name: nameCtrl.text.trim(),
//       email: emailCtrl.text.trim(),
//       phone: phoneCtrl.text.trim(),
//       address: addressCtrl.text.trim(),
//       age: int.parse(ageCtrl.text),
//       salary: double.parse(salaryCtrl.text),
//       gender: gender,
//       department: department!, // NEW DROPDOWN FIELD
//       dob: dob!,
//       createdAt: widget.user?.createdAt ?? DateTime.now(),
//       isActive: isActive,
//       skills: skills,
//       imagePath: _image?.path,
//     );

//     final db = DatabaseHelper();
//     widget.user == null ? await db.insertUser(user) : await db.updateUser(user);

//     Navigator.pop(context);
//   }

//   // ==============================
//   // UI
//   // ==============================
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.user == null ? 'Add User' : 'Edit User'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               // ==============================
//               // IMAGE
//               // ==============================
//               GestureDetector(
//                 onTap: pickImage,
//                 child: Center(
//                   child: CircleAvatar(
//                     radius: 50,
//                     backgroundImage: _image != null ? FileImage(_image!) : null,
//                     child: _image == null
//                         ? const Icon(Icons.camera_alt, size: 40)
//                         : null,
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 20),

//               // ==============================
//               // TEXT INPUTS
//               // ==============================
//               TextFormField(
//                 controller: nameCtrl,
//                 decoration: const InputDecoration(labelText: 'Name'),
//                 validator: (v) => v == null || v.isEmpty ? 'Required' : null,
//               ),

//               TextFormField(
//                 controller: emailCtrl,
//                 decoration: const InputDecoration(labelText: 'Email'),
//                 keyboardType: TextInputType.emailAddress,
//                 validator: (v) =>
//                     v == null || !v.contains('@') ? 'Invalid email' : null,
//               ),

//               TextFormField(
//                 controller: phoneCtrl,
//                 decoration: const InputDecoration(labelText: 'Phone'),
//                 keyboardType: TextInputType.phone,
//               ),

//               TextFormField(
//                 controller: addressCtrl,
//                 decoration: const InputDecoration(labelText: 'Address'),
//                 maxLines: 2,
//               ),

//               TextFormField(
//                 controller: ageCtrl,
//                 decoration: const InputDecoration(labelText: 'Age'),
//                 keyboardType: TextInputType.number,
//                 validator: (v) =>
//                     int.tryParse(v ?? '') == null ? 'Invalid age' : null,
//               ),

//               TextFormField(
//                 controller: salaryCtrl,
//                 decoration: const InputDecoration(labelText: 'Salary'),
//                 keyboardType: const TextInputType.numberWithOptions(
//                   decimal: true,
//                 ),
//                 validator: (v) =>
//                     double.tryParse(v ?? '') == null ? 'Invalid salary' : null,
//               ),

//               const SizedBox(height: 10),

//               // ==============================
//               // DATE PICKER
//               // ==============================
//               ListTile(
//                 title: Text(
//                   dob == null
//                       ? 'Select Date of Birth'
//                       : 'DOB: ${dob!.toIso8601String().split('T')[0]}',
//                 ),
//                 trailing: const Icon(Icons.calendar_today),
//                 onTap: pickDOB,
//               ),

//               const SizedBox(height: 10),

//               // ==============================
//               // RADIO BUTTONS (Gender)
//               // ==============================
//               const Text(
//                 'Gender',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               Column(
//                 children: Gender.values.map((g) {
//                   return RadioListTile<Gender>(
//                     title: Text(g.name.toUpperCase()),
//                     value: g,
//                     groupValue: gender,
//                     onChanged: (v) => setState(() => gender = v!),
//                   );
//                 }).toList(),
//               ),

//               const SizedBox(height: 10),

//               // ==============================
//               // DROPDOWN (Department / Category)
//               // ==============================
//               DropdownButtonFormField<String>(
//                 value: department,
//                 decoration: const InputDecoration(labelText: 'Department'),
//                 items: departments
//                     .map((d) => DropdownMenuItem(value: d, child: Text(d)))
//                     .toList(),
//                 onChanged: (v) => setState(() => department = v),
//                 validator: (v) =>
//                     v == null || v.isEmpty ? 'Please select department' : null,
//               ),

//               const SizedBox(height: 10),

//               // ==============================
//               // SWITCH (Active)
//               // ==============================
//               SwitchListTile(
//                 title: const Text('Active'),
//                 value: isActive,
//                 onChanged: (v) => setState(() => isActive = v),
//               ),

//               const Divider(),

//               // ==============================
//               // CHECKBOX (Skills)
//               // ==============================
//               const Text(
//                 'Skills',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               ...allSkills.map((skill) {
//                 return CheckboxListTile(
//                   title: Text(skill),
//                   value: skills.contains(skill),
//                   onChanged: (v) {
//                     setState(() {
//                       v! ? skills.add(skill) : skills.remove(skill);
//                     });
//                   },
//                 );
//               }),

//               const SizedBox(height: 20),

//               // ==============================
//               // SAVE BUTTON
//               // ==============================
//               ElevatedButton(onPressed: saveUser, child: const Text('SAVE')),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
