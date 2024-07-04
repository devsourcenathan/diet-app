import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:diet_app/constants.dart';
import 'package:image_picker/image_picker.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String _apportNutritif = '';
    String _description = '';
    File? _image;
    String _maladeId = '';
    String _nom = '';
    String _price = '';
    String _recette = '';
    String _typeRepas = '';

    final picker = ImagePicker();

    Future<void> _pickImage() async {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        }
      });
    }

    Future<void> _submitForm() async {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        // Upload image to Firebase Storage
        String imageUrl = '';
        if (_image != null) {
          final storageRef = FirebaseStorage.instance
              .ref()
              .child('menus/${_image!.path.split('/').last}');
          await storageRef.putFile(_image!);
          imageUrl = await storageRef.getDownloadURL();
        }

        // Save data to Firestore
        await FirebaseFirestore.instance.collection('menus').add({
          'apport_nutritif': _apportNutritif,
          'description': _description,
          'imageUrl': imageUrl,
          'maladeId': _maladeId,
          'nom': _nom,
          'price': _price,
          'recette': _recette,
          'type_repas': _typeRepas,
        });

        // Reset form
        _formKey.currentState!.reset();
        setState(() {
          _image = null;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Menu ajouté avec succès!')),
        );
      }
    }

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 50,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Constants.primaryColor.withOpacity(.15),
                      ),
                      child: Icon(
                        Icons.close,
                        color: Constants.primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Ajouter un menu",
                    style: TextStyle(
                      color: Constants.primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 22,
                    ),
                  )
                ],
              )),
          Positioned(
            top: 100,
            right: 20,
            left: 20,
            child: Container(
              width: size.width * .8,
              height: size.height * .8,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration:
                              InputDecoration(labelText: 'Apport Nutritif'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez entrer l\'apport nutritif';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _apportNutritif = value!;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Description'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez entrer une description';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _description = value!;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'ID Malade'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez entrer l\'ID du malade';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _maladeId = value!;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Nom'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez entrer le nom du menu';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _nom = value!;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Prix'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez entrer le prix';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _price = value!;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Recette'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez entrer la recette';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _recette = value!;
                          },
                        ),
                        TextFormField(
                          decoration:
                              InputDecoration(labelText: 'Type de Repas'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez entrer le type de repas';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _typeRepas = value!;
                          },
                        ),
                        SizedBox(height: 10),
                        _image == null
                            ? Text('Aucune image sélectionnée.')
                            : Image.file(_image!),
                        ElevatedButton(
                          onPressed: _pickImage,
                          child: Text('Choisir une image'),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _submitForm,
                          child: Text('Soumettre'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
