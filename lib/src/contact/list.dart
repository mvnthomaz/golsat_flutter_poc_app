import 'package:flutter/material.dart';
import 'package:golsat_flutter_poc_app/src/contact/form.dart';
import 'package:golsat_flutter_poc_app/src/contact/list_bloc.dart';
import 'package:golsat_flutter_poc_app/src/shared/models/contact.dart';
import 'package:golsat_flutter_poc_app/src/shared/repositories/general_api.dart';

class FirstRoute extends StatefulWidget {
  @override
  _FirstRouteState createState() => _FirstRouteState();
}

class _FirstRouteState extends State<FirstRoute> {
  HomeBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = HomeBloc(GeneralAPI());
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
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
      body: StreamBuilder<List<Contact>>(
          stream: bloc.contactsStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());
            if (snapshot.hasError) return Text(snapshot.error);
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

// Future<List<Contact>> fetchContact() async {
//   final response = await http
//       .get(URL_API + "/movie/now_playing?language=pt-BR&api_key=" + KEY_API);

//   if (response.statusCode == 200) {
//     print(json.decode(response.body));
//     // If the call to the server was successful, parse the JSON.
//     return (json.decode(response.body)['results'] as List)
//         .map((movie) => Filme.fromJson(movie))
//         .toList();
//   } else {
//     // If that call was not successful, throw an error.
//     throw Exception('Falha ao carregar os filmes');
//   }
// }
