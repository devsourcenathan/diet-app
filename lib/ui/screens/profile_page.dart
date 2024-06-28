import 'package:flutter/material.dart';
import 'package:diet_app/constants.dart';
import 'package:diet_app/ui/screens/widgets/profile_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        height: size.height,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 150,
              child: const CircleAvatar(
                radius: 60,
                backgroundImage: ExactAssetImage('assets/images/profile.jpg'),
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Constants.primaryColor.withOpacity(.5),
                  width: 5.0,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: size.width * .3,
              child: Row(
                children: [
                  Text(
                    'John Doe',
                    style: TextStyle(
                      color: Constants.blackColor,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              // "${activeSession?.user.email}",
              "",
              style: TextStyle(
                color: Constants.blackColor.withOpacity(.3),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: size.height * .7,
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ProfileWidget(
                    icon: Icons.person,
                    title: 'My Profile',
                  ),
                  const ProfileWidget(
                    icon: Icons.settings,
                    title: 'Settings',
                  ),
                  const ProfileWidget(
                    icon: Icons.notifications,
                    title: 'Notifications',
                  ),
                  const ProfileWidget(
                    icon: Icons.chat,
                    title: 'FAQs',
                  ),
                  const ProfileWidget(
                    icon: Icons.share,
                    title: 'Share',
                  ),
                  GestureDetector(
                    onTap: () async {
                      Navigator.pushNamed(context, '/auth');
                    },
                    child: const ProfileWidget(
                      icon: Icons.logout,
                      title: 'Log Out',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
