

final List<CardViewModel> demoCards = [
  new CardViewModel(
    backdropAssetPath: 'assets/spain_cover.jpg',
    flagAssetPath: 'assets/spain.png',
    country: "Spain",
    lat: 40.4637,
    lng: 3.749,
    arrivaldate: "June 17th",
    departuredate: "June 27th",
    destinations: ["Madrid", "Barcelona"],

  ),
  new CardViewModel(
    backdropAssetPath: 'assets/croatia_cover.jpg',
    flagAssetPath: 'assets/croatia.png',
    country: "Croatia",
    lat: 45.1,
    lng: 15.2,
    arrivaldate: "July 10th",
    departuredate: "July 16th",
    destinations: ["Split", "Zadar"],

  ),
  new CardViewModel(
      backdropAssetPath: 'assets/germany_cover.jpg',
      flagAssetPath: 'assets/germany.png',
      country: "Germany",
      lat: 51.165691,
      lng: 10.45,
    arrivaldate: "July 10th",
    departuredate: "July 16th",
    destinations: ["Munich"],
  ),
  new CardViewModel(
      backdropAssetPath: 'assets/hungary_cover.jpg',
      flagAssetPath: 'assets/hungary.png',
      country: "Hungary",
    lat: 47.162494,
    lng: 19.5,
    arrivaldate: "July 10th",
    departuredate: "July 16th",
    destinations: ["Budapest", "Zadar"],
  ),
  new CardViewModel(
      backdropAssetPath: 'assets/montenegro_cover.jpg',
      flagAssetPath: 'assets/montenegro.jpg',
      country: "Montenegro",
    lat: 42.708678,
    lng: 19.37439,
    arrivaldate: "July 10th",
    departuredate: "July 16th",
    destinations: ["Zabljak"],
  ),
  new CardViewModel(
      backdropAssetPath: 'assets/romania_cover.jpg',
      flagAssetPath: 'assets/romania.png',
      country: "Romania",
    lat: 45.943161,
    lng: 24.96676,
    arrivaldate: "July 10th",
    departuredate: "July 16th",
    destinations: ["Bucharest", "Cuj"],

  ),


];

class CardViewModel {
  final String backdropAssetPath;
  final String flagAssetPath;
  final String country;
  final double lat;
  final double lng;
  final String arrivaldate;
  final String departuredate;
  final List<String> destinations;



  CardViewModel({
    this.backdropAssetPath,
    this.flagAssetPath,
    this.country,
    this.lat,
    this.lng,
    this.arrivaldate,
    this.departuredate,
    this.destinations,

  });
}