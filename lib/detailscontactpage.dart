import 'package:flutter/material.dart';
import 'contact.dart';

class DetailsContactPage extends StatefulWidget {
  final Contact contact;
  final Function deleteContact;
  DetailsContactPage({required this.contact, required this.deleteContact});

  @override
  _DetailsContactPageState createState() => _DetailsContactPageState();
}

class _DetailsContactPageState extends State<DetailsContactPage> {
  Future<void> _deleteContact() async {
    await widget.deleteContact(widget.contact);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contact.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _deleteContact,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome: ${widget.contact.name}'),
            Text('Telefone: ${widget.contact.phone}'),
            Text('Email: ${widget.contact.email}'),
          ],
        ),
      ),
    );
  }
}