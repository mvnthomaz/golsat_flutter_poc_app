import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:golsat_flutter_poc_app/src/blocs/contact.bloc.dart';
import 'package:golsat_flutter_poc_app/src/models/contact.model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:progress_dialog/progress_dialog.dart';


class FormContact extends StatefulWidget {
  @override
  _FormContactState createState() => _FormContactState();
}

class _FormContactState extends State<FormContact> {

  Future<LocationData> locationData;

  File _image;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  ProgressDialog pr;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  Future<LocationData> _location() async {
    var location = new Location();
    LocationData currentLocation;
    try {
      currentLocation = (await location.getLocation());
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        print(e);
      }
    }
    return currentLocation;
  }

  @override
  void initState() {
    super.initState();
    locationData = _location();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(icon: Icon(Icons.save), onPressed: () async {
              pr = new ProgressDialog(context, ProgressDialogType.Normal);
              pr.setMessage('Por favor, aguarde...');
              pr.show();

              var result = await bloc.postImage(_image);
              if( result != null ) {
                var contact = Contact();
                contact.name = nameController.text;
                contact.phone = phoneController.text;
                contact.email = emailController.text;
                contact.image = result.data.link;

                var c = bloc.postContact(contact);
                if (c != null) {
                  pr.hide();
                  Navigator.pop(context, true);
                }
              }
            }),
          ),
        ],
      ),
      body:
      Container(
        height: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 90,
                  backgroundColor: Color.fromRGBO(235, 235, 235, 1),
                  child: GestureDetector(
                    onTap: () => getImage(),
                    child: _image == null
                        ? Text('Tirar foto')
                        : Image.file(_image),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 50.0, 0, 0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: 'Nome',
                          prefixIcon: Icon(Icons.person),
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          print(value);
                        },
                      ),
                      TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          hintText: 'Telefone',
                          prefixIcon: Icon(Icons.phone),
                        ),
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: 'E-mail',
                          prefixIcon: Icon(Icons.email),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20,),
                      FutureBuilder<LocationData>(
                        future: locationData,
                        builder: (BuildContext context, AsyncSnapshot<LocationData> snapshot) {
                          if (snapshot.hasData) {
                            var date = new DateTime.fromMillisecondsSinceEpoch(snapshot.data.time.toInt());
                            var format = new DateFormat('dd/MM/yyyy HH:mm');
                            return Text('Latitude: ${snapshot.data.latitude}\n'
                                'Longitude: ${snapshot.data.longitude} \n'
                                'Altitude: ${snapshot.data.altitude} \n'
                                'Data/Hora: ${format.format(date)}');
                          } else {
                            return Text('Localização não definida.');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}