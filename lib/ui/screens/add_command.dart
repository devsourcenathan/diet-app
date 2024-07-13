import 'dart:convert';

import 'package:diet_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class AddCommand extends StatefulWidget {
  final menu;
  const AddCommand({super.key, required this.menu});

  @override
  State<AddCommand> createState() => _AddCommandState();
}

class _AddCommandState extends State<AddCommand> {
  final _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dateController.text = DateTime.now().toString().split(" ")[0];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16.0),
            Text(
              "Passer une commande",
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _dateController,
              decoration: InputDecoration(
                labelText: 'Date de commande',
              ),
              readOnly: true,
              onTap: () {
                // Implémentez ici la logique pour choisir une date si nécessaire
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Montant',
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
              ],
              controller: TextEditingController(
                  text: this.widget.menu['price'].toString()),
            ),
            SizedBox(height: 16.0),
            GestureDetector(
              onTap: () {
                _submitPayment();
              },
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    color: Constants.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 1),
                        blurRadius: 5,
                        color: Constants.primaryColor.withOpacity(.3),
                      )
                    ]),
                child: const Center(
                  child: Text(
                    'Valider le paiement',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitPayment() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        showCloseIcon: true,
        closeIconColor: Colors.black,
        duration: const Duration(seconds: 5),
        content: Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Center(
            child: Text(
              "Votre commande a été pris en compte. Vous serrez contacté bientot",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
    Navigator.of(context).pop();
  }
}
