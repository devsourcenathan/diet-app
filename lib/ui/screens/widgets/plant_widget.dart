import 'package:flutter/material.dart';
import 'package:diet_app/constants.dart';
import 'package:diet_app/models/plants.dart';
import 'package:diet_app/ui/screens/detail_page.dart';
import 'package:page_transition/page_transition.dart';

class PlantWidget extends StatelessWidget {
  const PlantWidget({
    Key? key,
    required this.menu,
  }) : super(key: key);

  // final int index;
  final Map<String, dynamic> menu;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
              child: DetailPage(
                menu: menu,
              ),
              type: PageTransitionType.bottomToTop),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Constants.primaryColor.withOpacity(.1),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 80.0,
        padding: const EdgeInsets.only(left: 10, top: 10),
        margin: const EdgeInsets.only(bottom: 10, top: 10),
        width: size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: Constants.primaryColor.withOpacity(.8),
                      shape: BoxShape.circle,
                    ),
                    child: menu.containsKey('imageUrl')
                        ? Image.network(
                            menu['imageUrl'],
                            fit: BoxFit.fill,
                          )
                        : const Icon(Icons.image_not_supported)),
                // Positioned(
                //   bottom: 5,
                //   left: 0,
                //   right: 0,
                //   child: SizedBox(
                //     height: 80.0,
                //     child: menu.containsKey('imageUrl')
                //         ? Image.network(
                //             menu['imageUrl'],
                //             fit: BoxFit.contain,
                //           )
                //         : const Icon(Icons.image_not_supported),
                //   ),
                // ),
                Positioned(
                  bottom: 5,
                  left: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        menu['type_repas'] ?? "Type inconnu",
                      ),
                      Text(
                        menu['nom'] ?? "",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Constants.blackColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                '${menu['price'] ?? 0} FCFA',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Constants.primaryColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
