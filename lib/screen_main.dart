import 'package:database_crud/add_user.dart';
import 'package:database_crud/database.dart';
import 'package:flutter/material.dart';

class ScreenMain extends StatefulWidget {
  @override
  State<ScreenMain> createState() => _ScreenMainState();
}

class _ScreenMainState extends State<ScreenMain> {
  MyDatabase db = MyDatabase();

  void initState() {
    super.initState();
    db.initDatabase().then((value) {
      db.getDataFromUserTable();
      print('database successfully initialized');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('User List')),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (contex) => AddUser(false)));
            },
            icon: Icon(Icons.add, size: 32),
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, Object?>>>(
        builder: (context, snapshot) {
          if (snapshot != null && snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return Column(
                  children: [getCustomRowTile(context, index, snapshot.data)],
                  // child: Text(
                  //   snapshot.data![index]['UserName'].toString(),
                  // ),
                );
              },
              itemCount: snapshot.data!.length,
            );
          } else {
            return CircularProgressIndicator();
          }
        },
        future: MyDatabase().getDataFromUserTable(),
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }

  Widget getCustomRowTile(contex, index, data) {
    return Row(
      children: [
        Expanded(
          flex: 9,
          child: ListTile(

            title: Text(
              '${data[index]['UserName']}',
              key: Key('text_$index'),
            ),
            trailing: IconButton(
              key: Key('icon_$index'),

              onPressed: () {
                showAlertDialog(context, index, data);
                // setState(() {
                //   db.deleteUser(data[index]['UserId']);
                // });
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ),
        ),
        Expanded(
          child: IconButton(
            key: Key('icon_$index'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (contex) => AddUser(
                    true,
                    id: data[index]['UserId'],
                    name: data[index]['UserName'],
                    pass: data[index]['UserPassword'],
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.edit,
              color: Colors.lightBlue,
            ),
          ),
        ),
      ],
    );
  }

  showAlertDialog(BuildContext context, index, data) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed: () {
        Navigator.pop(context, false);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        setState(() {
          db.deleteUser(data[index]['UserId']);
        });
        Navigator.pop(context, false);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert!!"),
      content: Text("Are you sure want to delete this record?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
