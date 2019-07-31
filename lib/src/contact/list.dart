import 'package:flutter/material.dart';
import 'package:golsat_flutter_poc_app/src/contact/form.dart';
import 'package:golsat_flutter_poc_app/src/shared/models/contact.dart';

class FirstRoute extends StatefulWidget {
  @override
  _FirstRouteState createState() => _FirstRouteState();
}

class _FirstRouteState extends State<FirstRoute> {
  Future<List<Contact>> filmes;

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
      body: FutureBuilder<List<Contact>>(
        future: filmes,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Contact> contacts = snapshot.data;
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return card(contacts[index]);
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // Animação loading
          return Center(child: CircularProgressIndicator());
        },
      ),
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

class ListContactsPage extends StatefulWidget {
  @override
  _ListContactsPageState createState() => _ListContactsPageState();
}

class _ListContactsPageState extends State<ListContactsPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class LineContact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile();
  }
}
