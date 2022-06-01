class FakeArtist {
  String name;
  String description;
  String genre;
  String image;

  FakeArtist({
    required this.genre,
    required this.image,
    required this.name,
    required this.description,
  });
}

final List<FakeArtist> artistList = [
  FakeArtist(
    name: "Mahmut Orhan",
    genre: "Deep House",
    image: 'https://www.momondo.com.tr/discover/wp-content/uploads/sites/294/2018/07/Mahmut-Orhan-in-Dubai.jpg-momondo.jpg',
    description: "Mahmut Orhan, Türk DJ ve prodüktör, Deep House, İndie dance ve Nu Disco",

  ),
  FakeArtist(
    name: "Mazhar Alanson",
    genre: "",
    image: 'https://iaysr.tmgrup.com.tr/196006/800/513/0/0/780/500?u=https://iysr.tmgrup.com.tr/2018/07/29/mazhar-alansona-sosyal-linc-1532894203950.jpg',
    description: "Mazhar Alanson, Türk şarkıcı, gitarist, söz yazarı ve oyuncu",


  ),
  FakeArtist(
    name: "Aleyna Yalçın",
    genre: "",
    image: 'https://i.ytimg.com/vi/9YwLlHOy3GY/hqdefault.jpg',
    description: "Aleyna Yalçın, Modern dans, bale ve jimnastik sanatçısı",


  ),
];

final List<FakeArtist> yakindakiEtkinlikler = [
  FakeArtist(
    name: "İlhan Erşahin",
    genre: "",
    image: 'https://i.ytimg.com/vi/0_athQkgRH4/maxresdefault.jpg',
    description: "İlhan Erşahin, Jazz Sanatçısı",

  ),
  FakeArtist(
    name: "Hakan Aysev",
    genre: "",
    image: 'https://source.unsplash.com/600x800/?live',
    description: "Hakan Aysev, Ses sanatçısı, tenör",


  )
];
