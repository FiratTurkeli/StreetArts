class Event {
  String name;
  String description;
  DateTime eventDate;
  String image;
  String location;
  //date
  //time
  //artist
  //id


  Event({
    required this.eventDate,
    required this.image,
    required this.location,
    required this.name,
    required this.description,
  });
}

final List<Event> yaklasanEtkinlikler = [
  Event(
    name: "Mahmut Orhan",
    eventDate: DateTime.now().add(const Duration(days: 24)),
    image: 'https://www.momondo.com.tr/discover/wp-content/uploads/sites/294/2018/07/Mahmut-Orhan-in-Dubai.jpg-momondo.jpg',
    description: "Mahmut Orhan, Türk DJ ve prodüktör, Deep House, İndie dance ve Nu Disco",
    location: "Çilek Sokak",

  ),
  Event(
    name: "Mazhar Alanson",
    eventDate: DateTime.now().add(const Duration(days: 33)),
    image: 'https://iaysr.tmgrup.com.tr/196006/800/513/0/0/780/500?u=https://iysr.tmgrup.com.tr/2018/07/29/mazhar-alansona-sosyal-linc-1532894203950.jpg',
    description: "Mazhar Alanson, Türk şarkıcı, gitarist, söz yazarı ve oyuncu",
    location: "Moda Caddesi",

  ),
  Event(
    name: "Aleyna Yalçın",
    eventDate: DateTime.now().add(const Duration(days: 12)),
    image: 'https://i.ytimg.com/vi/9YwLlHOy3GY/hqdefault.jpg',
    description: "Aleyna Yalçın, Modern dans, bale ve jimnastik sanatçısı",
    location: "Moda Yolu",

  ),
];

final List<Event> gecmisEtkinlikler = [
  Event(
    name: "İlhan Erşahin",
    eventDate: DateTime.now().add(const Duration(days: 1)),
    image: 'https://i.ytimg.com/vi/0_athQkgRH4/maxresdefault.jpg',
    description: "İlhan Erşahin, Jazz Sanatçısı",
    location: "Yan Yol",

  ),
  Event(
    name: "Hakan Aysev",
    eventDate: DateTime.now().add(const Duration(days: 4)),
    image: 'https://source.unsplash.com/600x800/?live',
    description: "Hakan Aysev, Ses sanatçısı, tenör",
    location: "Sanat Sokak",

  )
];
