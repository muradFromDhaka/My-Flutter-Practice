import 'dart:io';

import 'package:flutter/material.dart';

import '../db/database_helper2.dart';
import '../model/user2.dart';
import 'u_form.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<User> users = [];
  bool isLoading = true;

  // ==============================
  // FETCH USERS
  // ==============================
  Future<void> fetchUsers() async {
    setState(() => isLoading = true);
    users = await DatabaseHelper().getUsers();
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  // ==============================
  // DELETE CONFIRMATION
  // ==============================
  Future<void> confirmDelete(User user) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete User'),
        content: Text('Are you sure you want to delete ${user.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('DELETE', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (ok == true) {
      await DatabaseHelper().deleteUser(user.id!);
      fetchUsers();
    }
  }

  // ==============================
  // UI
  // ==============================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users'), centerTitle: true),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const UserForm()),
          );
          fetchUsers();
        },
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : users.isEmpty
          ? const Center(child: Text('No users found'))
          : RefreshIndicator(
              onRefresh: fetchUsers,
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 80),
                itemCount: users.length,
                itemBuilder: (_, index) {
                  final u = users[index];

                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 6,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),

                      // ======================
                      // AVATAR
                      // ======================
                      leading: CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: u.imagePath != null
                            ? FileImage(File(u.imagePath!))
                            : null,
                        child: u.imagePath == null
                            ? const Icon(Icons.person, size: 30)
                            : null,
                      ),

                      // ======================
                      // NAME + STATUS
                      // ======================
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              u.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Icon(
                            u.isActive ? Icons.check_circle : Icons.cancel,
                            color: u.isActive ? Colors.green : Colors.red,
                            size: 18,
                          ),
                        ],
                      ),

                      // ======================
                      // DETAILS
                      // ======================
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),

                          // Email
                          Text(
                            u.email,
                            style: TextStyle(color: Colors.grey.shade700),
                          ),

                          const SizedBox(height: 4),

                          // Gender • Age • Department
                          Text(
                            '${u.gender.name.toUpperCase()} • Age ${u.age} • ${u.department}',
                            style: const TextStyle(fontSize: 13),
                          ),

                          const SizedBox(height: 4),

                          // Salary
                          Text(
                            '💰 Salary: \$${u.salary.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 13),
                          ),

                          // Skills
                          if (u.skills.isNotEmpty) ...[
                            const SizedBox(height: 6),
                            Wrap(
                              spacing: 6,
                              runSpacing: -8,
                              children: u.skills
                                  .take(3)
                                  .map(
                                    (skill) => Chip(
                                      label: Text(skill),
                                      visualDensity: VisualDensity.compact,
                                      backgroundColor: Colors.blue.shade50,
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ],
                      ),

                      // ======================
                      // ACTIONS
                      // ======================
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => UserForm(user: u),
                                  ),
                                );
                                fetchUsers();
                              },
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => confirmDelete(u),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}

// import 'dart:io';

// import 'package:flutter/material.dart';

// import '../db/database_helper2.dart';
// import '../model/user2.dart';
// import 'u_form.dart';

// class UserList extends StatefulWidget {
//   const UserList({super.key});

//   @override
//   State<UserList> createState() => _UserListState();
// }

// class _UserListState extends State<UserList> {
//   List<User> users = [];
//   bool isLoading = true;

//   // ==============================
//   // FETCH USERS
//   // ==============================
//   Future<void> fetchUsers() async {
//     setState(() => isLoading = true);
//     users = await DatabaseHelper().getUsers();
//     setState(() => isLoading = false);
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchUsers();
//   }

//   // ==============================
//   // DELETE CONFIRM
//   // ==============================
//   Future<void> confirmDelete(User user) async {
//     final ok = await showDialog<bool>(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('Delete User'),
//         content: Text('Delete ${user.name}?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context, false),
//             child: const Text('CANCEL'),
//           ),
//           TextButton(
//             onPressed: () => Navigator.pop(context, true),
//             child: const Text('DELETE'),
//           ),
//         ],
//       ),
//     );

//     if (ok == true) {
//       await DatabaseHelper().deleteUser(user.id!);
//       fetchUsers();
//     }
//   }

//   // ==============================
//   // UI
//   // ==============================
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Users')),
//       floatingActionButton: FloatingActionButton(
//         child: const Icon(Icons.add),
//         onPressed: () async {
//           await Navigator.push(
//             context,
//             MaterialPageRoute(builder: (_) => const UserForm()),
//           );
//           fetchUsers();
//         },
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : users.isEmpty
//           ? const Center(child: Text('No users found'))
//           : RefreshIndicator(
//               onRefresh: fetchUsers,
//               child: ListView.builder(
//                 itemCount: users.length,
//                 itemBuilder: (_, index) {
//                   final u = users[index];
//                   return Card(
//                     margin: const EdgeInsets.symmetric(
//                       horizontal: 12,
//                       vertical: 6,
//                     ),
//                     child: ListTile(
//                       leading: CircleAvatar(
//                         radius: 25,
//                         backgroundImage: u.imagePath != null
//                             ? FileImage(File(u.imagePath!))
//                             : null,
//                         child: u.imagePath == null
//                             ? const Icon(Icons.person)
//                             : null,
//                       ),
//                       title: Text(u.name),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(u.email),
//                           Text('${u.gender.name.toUpperCase()} • Age ${u.age}'),
//                           if (u.skills.isNotEmpty)
//                             Wrap(
//                               spacing: 4,
//                               children: u.skills
//                                   .take(3)
//                                   .map(
//                                     (s) => Chip(
//                                       label: Text(s),
//                                       visualDensity: VisualDensity.compact,
//                                     ),
//                                   )
//                                   .toList(),
//                             ),
//                         ],
//                       ),
//                       isThreeLine: true,
//                       trailing: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             u.isActive ? Icons.check_circle : Icons.cancel,
//                             color: u.isActive ? Colors.green : Colors.red,
//                             size: 18,
//                           ),
//                           const SizedBox(height: 6),
//                           Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               IconButton(
//                                 icon: const Icon(Icons.edit),
//                                 onPressed: () async {
//                                   await Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (_) => UserForm(user: u),
//                                     ),
//                                   );
//                                   fetchUsers();
//                                 },
//                               ),
//                               IconButton(
//                                 icon: const Icon(
//                                   Icons.delete,
//                                   color: Colors.red,
//                                 ),
//                                 onPressed: () => confirmDelete(u),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//     );
//   }
// }
