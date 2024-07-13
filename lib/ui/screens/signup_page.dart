import 'package:diet_app/screens/auth/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:diet_app/constants.dart';
import 'package:diet_app/ui/root_page.dart';
import 'package:diet_app/ui/screens/widgets/custom_textfield.dart';
import 'package:diet_app/ui/screens/signin_page.dart';
import 'package:page_transition/page_transition.dart';

import 'package:diet_app/screens/auth/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:diet_app/constants.dart';
import 'package:diet_app/ui/root_page.dart';
import 'package:diet_app/ui/screens/forgot_password.dart';
import 'package:diet_app/ui/screens/signup_page.dart';
import 'package:diet_app/ui/screens/widgets/custom_textfield.dart';
import 'package:page_transition/page_transition.dart';

import 'package:diet_app/screens/auth/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:diet_app/constants.dart';
import 'package:diet_app/ui/root_page.dart';
import 'package:diet_app/ui/screens/forgot_password.dart';
import 'package:diet_app/ui/screens/signup_page.dart';
import 'package:diet_app/ui/screens/widgets/custom_textfield.dart';
import 'package:page_transition/page_transition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:diet_app/screens/auth/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:diet_app/constants.dart';
import 'package:diet_app/ui/root_page.dart';
import 'package:diet_app/ui/screens/forgot_password.dart';
import 'package:diet_app/ui/screens/signup_page.dart';
import 'package:diet_app/ui/screens/widgets/custom_textfield.dart';
import 'package:page_transition/page_transition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String selectedRole =
      'dieteticien'; // Par défaut, dieteticien est sélectionné

  List<String> roles = ['dieteticien', 'restaurateur', 'livreur', 'client'];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/signin.png'),
              const Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 30),
              CustomTextfield(
                controller: emailController,
                obscureText: false,
                hintText: 'Enter Email',
                icon: Icons.alternate_email,
              ),
              CustomTextfield(
                controller: passwordController,
                obscureText: true,
                hintText: 'Enter Password',
                icon: Icons.lock,
              ),
              const SizedBox(height: 20),
              DropdownButton<String>(
                isExpanded: true,
                value: selectedRole,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedRole = newValue!;
                  });
                },
                items: roles.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
              ..._buildAdditionalFields(selectedRole),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  signUp();
                },
                child: Container(
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Constants.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: const Center(
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ),
              // ... (le reste de votre code)
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildAdditionalFields(String role) {
    List<Widget> fields = [];
    if (role == 'dieteticien') {
      fields.add(CustomTextfield(
        controller: TextEditingController(), // Remplacez par votre contrôleur
        obscureText: false,
        hintText: 'Specialisation',
        icon: Icons.work,
      ));
    } else if (role == 'restaurateur') {
      fields.add(CustomTextfield(
        controller: TextEditingController(), // Remplacez par votre contrôleur
        obscureText: false,
        hintText: 'Restaurant ID',
        icon: Icons.restaurant,
      ));
      fields.add(CustomTextfield(
        controller: TextEditingController(), // Remplacez par votre contrôleur
        obscureText: false,
        hintText: 'Specialite',
        icon: Icons.local_dining,
      ));
    } else if (role == 'livreur') {
      fields.add(CustomTextfield(
        controller: TextEditingController(), // Remplacez par votre contrôleur
        obscureText: false,
        hintText: 'Ville',
        icon: Icons.location_city,
      ));
    }
    // Ajoutez d'autres rôles et champs supplémentaires si nécessaire
    return fields;
  }

  Future<void> signUp() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Sauvegardez les informations supplémentaires dans Firestore
      String userId = credential.user!.uid;
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('utilisateurs');

      Map<String, dynamic> userData = {
        'email': emailController.text,
        'role': selectedRole,
        // Ajoutez les autres champs supplémentaires ici
      };

      if (selectedRole == 'dieteticien') {
        // Exemple de structure pour dieteticien
        userData['specialisation'] =
            ''; // Récupérez la spécialisation du champ correspondant
      } else if (selectedRole == 'restaurateur') {
        // Exemple de structure pour restaurateur
        userData['restaurantId'] =
            ''; // Récupérez l'ID du restaurant du champ correspondant
        userData['specialite'] =
            ''; // Récupérez la spécialité du champ correspondant
        // Création d'un document pour le restaurant
        await FirebaseFirestore.instance
            .collection('restaurants')
            .doc(userData['restaurantId'])
            .set({
          'adresse': 'Rue de la joie, Bonapriso',
          'id': '1',
          'imageUrl':
              'https://firebasestorage.googleapis.com/v0/b/diet-app-c6ca8.appspot.com/o/restaurants%2Fundraw_Home_screen_re_640d.png?alt=media&token=98556a06-5aa7-439d-b81e-2994a0e11ed2',
          'lieu': 'Douala',
          'nom': 'La principauté',
        });
      } else if (selectedRole == 'livreur') {
        // Exemple de structure pour livreur
        userData['ville'] = ''; // Récupérez la ville du champ correspondant
      }

      await usersCollection.doc(userId).set(userData);

      Navigator.pushReplacement(
        context,
        PageTransition(
          child: const SplashScreen(),
          type: PageTransitionType.bottomToTop,
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
