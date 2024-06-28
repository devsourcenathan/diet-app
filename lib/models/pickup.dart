class Pickup {
  final int PickupId;
  final int price;
  final String size;
  final double rating;
  final int humidity;
  final String temperature;
  final String category;
  final String PickupName;
  final String imageURL;
  bool isFavorated;
  final String decription;
  bool isSelected;

  Pickup(
      {required this.PickupId,
      required this.price,
      required this.category,
      required this.PickupName,
      required this.size,
      required this.rating,
      required this.humidity,
      required this.temperature,
      required this.imageURL,
      required this.isFavorated,
      required this.decription,
      required this.isSelected});

  //List of Pickups data
  static List<Pickup> PickupList = [
    Pickup(
        PickupId: 0,
        price: 22,
        category: 'Indoor',
        PickupName: 'Sanseviera',
        size: 'Small',
        rating: 4.5,
        humidity: 34,
        temperature: '23 - 34',
        imageURL: 'assets/images/Pickup-one.png',
        isFavorated: true,
        decription:
            'This Pickup is one of the best Pickup. It grows in most of the regions in the world and can survive'
            'even the harshest weather condition.',
        isSelected: false),
    Pickup(
        PickupId: 1,
        price: 11,
        category: 'Outdoor',
        PickupName: 'Philodendron',
        size: 'Medium',
        rating: 4.8,
        humidity: 56,
        temperature: '19 - 22',
        imageURL: 'assets/images/Pickup-two.png',
        isFavorated: false,
        decription:
            'This Pickup is one of the best Pickup. It grows in most of the regions in the world and can survive'
            'even the harshest weather condition.',
        isSelected: false),
    Pickup(
        PickupId: 2,
        price: 18,
        category: 'Indoor',
        PickupName: 'Beach Daisy',
        size: 'Large',
        rating: 4.7,
        humidity: 34,
        temperature: '22 - 25',
        imageURL: 'assets/images/Pickup-three.png',
        isFavorated: false,
        decription:
            'This Pickup is one of the best Pickup. It grows in most of the regions in the world and can survive'
            'even the harshest weather condition.',
        isSelected: false),
    Pickup(
        PickupId: 3,
        price: 30,
        category: 'Outdoor',
        PickupName: 'Big Bluestem',
        size: 'Small',
        rating: 4.5,
        humidity: 35,
        temperature: '23 - 28',
        imageURL: 'assets/images/Pickup-one.png',
        isFavorated: false,
        decription:
            'This Pickup is one of the best Pickup. It grows in most of the regions in the world and can survive'
            'even the harshest weather condition.',
        isSelected: false),
    Pickup(
        PickupId: 4,
        price: 24,
        category: 'Recommended',
        PickupName: 'Big Bluestem',
        size: 'Large',
        rating: 4.1,
        humidity: 66,
        temperature: '12 - 16',
        imageURL: 'assets/images/Pickup-four.png',
        isFavorated: true,
        decription:
            'This Pickup is one of the best Pickup. It grows in most of the regions in the world and can survive'
            'even the harshest weather condition.',
        isSelected: false),
    Pickup(
        PickupId: 5,
        price: 24,
        category: 'Outdoor',
        PickupName: 'Meadow Sage',
        size: 'Medium',
        rating: 4.4,
        humidity: 36,
        temperature: '15 - 18',
        imageURL: 'assets/images/Pickup-five.png',
        isFavorated: false,
        decription:
            'This Pickup is one of the best Pickup. It grows in most of the regions in the world and can survive'
            'even the harshest weather condition.',
        isSelected: false),
    Pickup(
        PickupId: 6,
        price: 19,
        category: 'Garden',
        PickupName: 'Plumbago',
        size: 'Small',
        rating: 4.2,
        humidity: 46,
        temperature: '23 - 26',
        imageURL: 'assets/images/Pickup-six.png',
        isFavorated: false,
        decription:
            'This Pickup is one of the best Pickup. It grows in most of the regions in the world and can survive'
            'even the harshest weather condition.',
        isSelected: false),
    Pickup(
        PickupId: 7,
        price: 23,
        category: 'Garden',
        PickupName: 'Tritonia',
        size: 'Medium',
        rating: 4.5,
        humidity: 34,
        temperature: '21 - 24',
        imageURL: 'assets/images/Pickup-seven.png',
        isFavorated: false,
        decription:
            'This Pickup is one of the best Pickup. It grows in most of the regions in the world and can survive'
            'even the harshest weather condition.',
        isSelected: false),
    Pickup(
        PickupId: 8,
        price: 46,
        category: 'Recommended',
        PickupName: 'Tritonia',
        size: 'Medium',
        rating: 4.7,
        humidity: 46,
        temperature: '21 - 25',
        imageURL: 'assets/images/Pickup-eight.png',
        isFavorated: false,
        decription:
            'This Pickup is one of the best Pickup. It grows in most of the regions in the world and can survive'
            'even the harshest weather condition.',
        isSelected: false),
  ];

  //Get the favorated items
  static List<Pickup> getFavoritedPickups() {
    List<Pickup> _travelList = Pickup.PickupList;
    return _travelList.where((element) => element.isFavorated == true).toList();
  }

  //Get the cart items
  static List<Pickup> addedToCartPickups() {
    List<Pickup> _selectedPickups = Pickup.PickupList;
    return _selectedPickups
        .where((element) => element.isSelected == true)
        .toList();
  }
}
