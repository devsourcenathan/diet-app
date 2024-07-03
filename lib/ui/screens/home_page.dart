import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:diet_app/constants.dart';
import 'package:diet_app/models/plants.dart';
import 'package:diet_app/ui/screens/detail_page.dart';
import 'package:diet_app/ui/screens/widgets/plant_widget.dart';
import 'package:page_transition/page_transition.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _menusStream =
        FirebaseFirestore.instance.collection('menus').snapshots();

    final Stream<QuerySnapshot> _restaurantsStream =
        FirebaseFirestore.instance.collection('restaurants').snapshots();

    Size size = MediaQuery.of(context).size;

    List<Plant> plantList = Plant.plantList;

    //Toggle Favorite button
    bool toggleIsFavorated(bool isFavorited) {
      return !isFavorited;
    }

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  width: size.width * .9,
                  decoration: BoxDecoration(
                    color: Constants.primaryColor.withOpacity(.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.black54.withOpacity(.6),
                      ),
                      const Expanded(
                          child: TextField(
                        showCursor: false,
                        decoration: InputDecoration(
                          hintText: 'Rechercher un restaurant',
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      )),
                      Icon(
                        Icons.mic,
                        color: Colors.black54.withOpacity(.6),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          SizedBox(
            height: size.height * .3,
            child: StreamBuilder<QuerySnapshot>(
              stream: _restaurantsStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Text('No restaurants available');
                }

                return ListView(
                  scrollDirection: Axis.horizontal,
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;

                    return GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     PageTransition(
                        //         child: DetailPage(
                        //           plantId: plantList[index].plantId,
                        //         ),
                        //         type: PageTransitionType.bottomToTop));
                      },
                      child: Container(
                        width: 200,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Constants.primaryColor.withOpacity(.8),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              right: 0,
                              top: 50,
                              bottom: 50,
                              child: data.containsKey('imageUrl')
                                  ? Image.network(
                                      data['imageUrl'],
                                      fit: BoxFit.contain,
                                    )
                                  : Icon(Icons.image_not_supported),
                            ),
                            Positioned(
                              bottom: 15,
                              left: 20,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data['adresse'] ?? 'Adresse inconnue',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    data['nom'] ?? 'Nom inconnu',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 8,
                              right: 20,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  data['lieu'] ?? 'Lieu inconnu',
                                  style: TextStyle(
                                      color: Constants.primaryColor,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, bottom: 20, top: 20),
            child: const Text(
              'Menus disponibles',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            height: size.height * .5,
            child: StreamBuilder<QuerySnapshot>(
                stream: _menusStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  return ListView(
                    children: snapshot.data!.docs
                        .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  child: DetailPage(
                                    menu: data,
                                  ),
                                  type: PageTransitionType.bottomToTop,
                                ),
                              );
                            },
                            child: PlantWidget(menu: data),
                          );
                        })
                        .toList()
                        .cast(),
                  );
                }),
          ),
        ],
      ),
    ));
  }
}
