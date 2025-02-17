import 'package:diet_app/ui/screens/add_command.dart';
import 'package:flutter/material.dart';
import 'package:diet_app/constants.dart';
import 'package:diet_app/models/plants.dart';

class DetailPage extends StatefulWidget {
  final Map<String, dynamic> menu;

  const DetailPage({Key? key, required this.menu}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  //Toggle Favorite button
  bool toggleIsFavorated(bool isFavorited) {
    return !isFavorited;
  }

  //Toggle add remove from cart
  bool toggleIsSelected(bool isSelected) {
    return !isSelected;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Plant> _plantList = Plant.plantList;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                // GestureDetector(
                //   onTap: () {
                //     debugPrint('favorite');
                //   },
                //   child: Container(
                //     height: 40,
                //     width: 40,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(25),
                //       color: Constants.primaryColor.withOpacity(.15),
                //     ),
                //     child: IconButton(
                //         onPressed: () {
                //           setState(() {
                //             bool isFavorited = toggleIsFavorated(
                //                 _plantList[widget.plantId].isFavorated);
                //             _plantList[widget.plantId].isFavorated =
                //                 isFavorited;
                //           });
                //         },
                //         icon: Icon(
                //           _plantList[widget.plantId].isFavorated == true
                //               ? Icons.favorite
                //               : Icons.favorite_border,
                //           color: Constants.primaryColor,
                //         )),
                //   ),
                // ),
              ],
            ),
          ),
          Positioned(
            top: 100,
            left: 20,
            right: 20,
            child: Container(
              width: size.width * .8,
              height: size.height * .8,
              padding: const EdgeInsets.all(20),
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: 0,
                    child: SizedBox(
                      height: 350,
                      child: Image.network(widget.menu['imageUrl'] ?? ""),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 0,
                    child: SizedBox(
                      height: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PlantFeature(
                            title: 'Calories',
                            plantFeature: widget.menu['apport_nutritif'] ?? "-",
                          ),
                          PlantFeature(
                            title: 'Type',
                            plantFeature: widget.menu['type_repas'] ?? "-",
                          ),
                          // PlantFeature(
                          //   title: 'Recette',
                          //   plantFeature: widget.menu['recette'],
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(top: 80, left: 30, right: 30),
              height: size.height * .5,
              width: size.width,
              decoration: BoxDecoration(
                color: Constants.primaryColor.withOpacity(.4),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.menu['nom'] ?? "",
                            style: TextStyle(
                              color: Constants.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${widget.menu['price'] ?? 0} FCFA",
                            style: TextStyle(
                              color: Constants.blackColor,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "3.5",
                            style: TextStyle(
                              fontSize: 30.0,
                              color: Constants.primaryColor,
                            ),
                          ),
                          Icon(
                            Icons.star,
                            size: 30.0,
                            color: Constants.primaryColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Expanded(
                    child: Text(
                      widget.menu['description'] ?? "",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        height: 1.5,
                        fontSize: 18,
                        color: Constants.blackColor.withOpacity(.7),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        width: size.width * .9,
        height: 50,
        child: Row(
          children: [
            // Container(
            //   height: 50,
            //   width: 50,
            //   child: IconButton(
            //       onPressed: () {
            //         setState(() {
            //           bool isSelected = toggleIsSelected(
            //               _plantList[widget.plantId].isSelected);

            //           _plantList[widget.plantId].isSelected = isSelected;
            //         });
            //       },
            //       icon: Icon(
            //         Icons.shopping_cart,
            //         color: _plantList[widget.plantId].isSelected == true
            //             ? Colors.white
            //             : Constants.primaryColor,
            //       )),
            //   decoration: BoxDecoration(
            //       color: _plantList[widget.plantId].isSelected == true
            //           ? Constants.primaryColor.withOpacity(.5)
            //           : Colors.white,
            //       borderRadius: BorderRadius.circular(50),
            //       boxShadow: [
            //         BoxShadow(
            //           offset: const Offset(0, 1),
            //           blurRadius: 5,
            //           color: Constants.primaryColor.withOpacity(.3),
            //         ),
            //       ]),
            // ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.9,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                            )),
                        child: AddCommand(
                          menu: widget.menu,
                        ),
                      );
                    },
                  );
                },
                child: Container(
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
                      'COMMANDER MAINTENANT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
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
}

class PlantFeature extends StatelessWidget {
  final String plantFeature;
  final String title;
  const PlantFeature({
    Key? key,
    required this.plantFeature,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.deepPurpleAccent,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Text(
          plantFeature,
          style: TextStyle(
            color: Constants.primaryColor,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
