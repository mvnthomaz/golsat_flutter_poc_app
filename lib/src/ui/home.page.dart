import 'package:flutter/material.dart';
import 'package:golsat_flutter_poc_app/src/blocs/contact.bloc.dart';
import 'package:golsat_flutter_poc_app/src/ui/form.page.dart';
import 'package:golsat_flutter_poc_app/src/models/contact.model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    bloc.fetchAllContacts();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  Widget card(Contact contact) {
    return Card(
      color: Colors.blueGrey,
      child: Row(
        children: <Widget>[
          Expanded(
            child: ListTile(
                title: Container(
                  child: Text(contact.name),
                ),
                subtitle: Text(contact.phone)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PoC Golsat Flutter App'),
      ),
      body: StreamBuilder(
          stream: bloc.allContacts,
          builder: (context, AsyncSnapshot<List<Contact>> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Text(snapshot.error);
            }

            List<Contact> contacts = snapshot.data;
            return ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (BuildContext context, int index) {
                return card(contacts[index]);
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormContact()),
          );
        },
        child: Icon(Icons.person_add),
      ),
    );
  }
}