import 'package:database_crud/database.dart';
import 'package:database_crud/model.dart';
import 'package:database_crud/screen_main.dart';
import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  bool which = false;
  int id = 0;
  String name = '';
  String pass = '';
  //edit 1 add 0
  AddUser(bool c, {int id = 0, String name = '', String pass = ''}) {
    this.which = c;
    this.id = id;
    this.name = name;
    this.pass = pass;
  }

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    passwordController = TextEditingController(text: widget.pass);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.which ? Text('Edit User') : Text('Add User'),
      ),
      body: Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Name'
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: passwordController,
                decoration: const InputDecoration(border: OutlineInputBorder(),hintText: 'Enter Password'),
              ),
            ),
            widget.which
                ? TextButton(
                    onPressed: () {
                      MyDatabase().updateUser(
                          User(
                              UserName: nameController.text.toString(),
                              UserPassword: passwordController.text.toString()),
                          widget.id);
                      print('user edit success ${nameController.text}');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ScreenMain(),
                        ),
                      );
                    },
                    child: Text('Edit User'),
                  )
                : TextButton(
                    onPressed: () {
                      MyDatabase().insertUser(User(
                          UserName: nameController.text.toString(),
                          UserPassword: passwordController.text.toString()));
                      print('user add success ${nameController.text}');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ScreenMain(),
                        ),
                      );
                    },
                    child: Text('Add User',style: TextStyle(fontSize: 20),),
                  ),
          ],
        ),
      ),
    );

  }
}
