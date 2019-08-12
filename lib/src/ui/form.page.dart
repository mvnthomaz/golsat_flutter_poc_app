import 'dart:io';

import 'package:flutter/material.dart';
import 'package:golsat_flutter_poc_app/src/blocs/contact.bloc.dart';
import 'package:golsat_flutter_poc_app/src/models/contact.model.dart';
import 'package:image_picker/image_picker.dart';

class FormContact extends StatefulWidget {
  @override
  _FormContactState createState() => _FormContactState();
}

class _FormContactState extends State<FormContact> {
  File _image;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
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
              var result = await bloc.postImage(_image);
              if( result != null ) {
                var contact = Contact();
                contact.name = nameController.text;
                contact.phone = phoneController.text;
                contact.email = emailController.text;
                contact.image = result.data.link;

                var c = bloc.postContact(contact);
                if (c != null) {
                  Navigator.pop(context, true);
                }
              }
            }),
          ),
        ],
      ),
      body: Container(
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
                      )
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
