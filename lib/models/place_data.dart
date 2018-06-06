
final List<PlaceViewModel> demoPlaces =[
  new PlaceViewModel(
    id: 10597,
    name: "Sophie's Hostel",
    destination: "Prague",
    price: 12.27,
    url: "https://www.hostelworld.com/hosteldetails.php/Sophie-s-Hostel/Prague/10597",
    reservation: false,
    imagepath: "https://ucd.hwstatic.com/propertyimages/1/10597/11_80.jpg"
  ),
  new PlaceViewModel(
      id: 42948,
      name: "Podstel Bucharest",
      destination: "Bucharest",
      price: 14.62,
      url: "https://www.hostelworld.com/hosteldetails.php/Podstel-Bucharest/Bucharest/42948",
      reservation: false,
      imagepath: "https://ucd.hwstatic.com/propertyimages/4/42948/197_30.jpg"
  ),
  new PlaceViewModel(
      id: 10597,
      name: "Hostel Hikers Den",
      destination: "Zabljak",
      price: 16.38,
      url: "https://www.hostelworld.com/hosteldetails.php/Hostel-Hikers-Den/Zabljak/73957",
      reservation: false,
      imagepath: "https://ucd.hwstatic.com/propertyimages/7/73957/7_80.jpg"
  ),


];

class PlaceViewModel {
  final int id;
  final String name;
  final String destination;
  final double price;
  final String url;
  final bool reservation;
  final String imagepath;

  PlaceViewModel({
    this.id,
    this.name,
    this.destination,
    this.price,
    this.url,
    this.reservation,
    this.imagepath
  });

}

