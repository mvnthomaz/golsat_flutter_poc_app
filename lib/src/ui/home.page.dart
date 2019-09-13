import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:golsat_flutter_poc_app/src/blocs/contact.bloc.dart';
import 'package:golsat_flutter_poc_app/src/ui/form.page.dart';
import 'package:golsat_flutter_poc_app/src/models/contact.model.dart';
import 'package:golsat_flutter_poc_app/src/ui/simple_bar_chart.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final FirebaseMessaging _fcm = FirebaseMessaging();
  StreamSubscription iosSubscription;

  @override
  void initState() {
    super.initState();
    bloc.fetchAllContacts();
    if (Platform.isIOS) {
      iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
        print(data.toString());
        // save the token  OR subscribe to a topic here
      });
      _fcm.requestNotificationPermissions(IosNotificationSettings());

      //FirebaseAppDelegateProxyEnabled
    }
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
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(icon: Icon(Icons.show_chart), onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SimpleBarChart()),
              );
            }),
          ),
        ],
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
          _openForm();
        },
        child: Icon(Icons.person_add),
      ),
    );
  }

  _openForm() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FormContact()),
    );
    if( result == true ) {
      // var bloc = ContactBloc();
      bloc.fetchAllContacts();
    }
  }
}