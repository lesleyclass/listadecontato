import 'package:flutter/material.dart';
import 'addcontactspage.dart';
import 'contact.dart';
import 'databasehelper.dart'; // Importe a tela de adicionar contato

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Contatos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListContactsPage(),
    );
  }
}

class ListContactsPage extends StatefulWidget {
  @override
  _ListContactsPageState createState() => _ListContactsPageState();
}

class _ListContactsPageState extends State<ListContactsPage> {
  List<Contact> _contacts = [];

  @override
  void initState() {
    super.initState();
    _getContacts();
  }

  Future<void> _getContacts() async {
    List<Contact> contacts = await DatabaseHelper.instance.getContacts();
    setState(() {
      _contacts = contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Meus Contatos')),
      body: ListView.builder(
        itemCount: _contacts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_contacts[index].name),
            subtitle: Text(_contacts[index].phone),
            onTap: () {},
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    _deleteContact(_contacts[index]);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddContactsPage(
              updateListContact: _getContacts,
            )),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _deleteContact(Contact contact) async {
    int index = _contacts.indexOf(contact);
    await DatabaseHelper.instance.deleteContact(contact.id!);
    setState(() {
      _contacts.removeAt(index);
    });
  }
}
