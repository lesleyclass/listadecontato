import 'package:flutter/material.dart';
import 'editcontactpage.dart';
import 'contact.dart';

class DetailsContactPage extends StatefulWidget {
  final Contact contact;
  final Function deleteContact;
  final Function updateListContact;
  DetailsContactPage({required this.contact, required this.deleteContact, required this.updateListContact});

  @override
  _DetailsContactPageState createState() => _DetailsContactPageState();
}

class _DetailsContactPageState extends State<DetailsContactPage> {
  Future<void> _deleteContact() async {
    await widget.deleteContact(widget.contact);
    Navigator.pop(context);
  }

  Future<void> _updateListContact() async {
    widget.updateListContact();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contact.name),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditContactPage(
                  contact: widget.contact,
                  updateListContact: _updateListContact,
                )),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Confirmar exclusão'),
                    content: Text('Tem certeza que deseja excluir este contato?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: _deleteContact,
                        child: Text('Excluir'),
                      ),
                    ],
                  );
                },
              );
            },
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