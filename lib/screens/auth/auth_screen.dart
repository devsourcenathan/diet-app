import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24.0, 96.0, 24.0, 24.0),
        children: [
          Column(
            children: [
              Image(
                height: MediaQuery.of(context).size.height / 6,
                image: const AssetImage('images/logo.png'),
              ),
              const SizedBox(height: 24.0),
              SupaEmailAuth(
                metadataFields: [
                  MetaDataField(
                    prefixIcon: const Icon(Icons.person),
                    label: 'Enter your fullname',
                    key: 'name',
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please enter something';
                      }
                      return null;
                    },
                  ),
                  MetaDataField(
                    prefixIcon: const Icon(Icons.phone),
                    label: 'Enter your phone number',
                    key: 'phone',
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please enter something';
                      }
                      return null;
                    },
                  ),
                ],
                onSignInComplete: (res) =>
                    Navigator.pushNamed(context, '/home'),
                onSignUpComplete: (res) =>
                    Navigator.pushNamed(context, '/home'),
                onError: (error) => SnackBar(content: Text(error.toString())),
              ),
              SupaSocialsAuth(
                socialProviders: const [
                  OAuthProvider.google,
                ],
                onSuccess: (session) => Navigator.pushNamed(
                  context,
                  '/home',
                ),
                onError: (error) => SnackBar(
                  content: Text(
                    error.toString(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
