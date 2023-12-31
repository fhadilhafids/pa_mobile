import 'package:flutter/material.dart';
import 'explore_page.dart';
import 'profile_page.dart';
import 'explore_categories.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pa_mobile/screens/detail_page.dart';
import 'data_local.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

List<String> _laman = [
  'Home',
  'Explore',
  'Settings & Profile',
];

class _MyHomePageState extends State<MyHomePage> {
  int _index = 0;
  bool isDarkMode = false;
  static final List<Widget> _pages = [
    const HomePage(),
    const ExplorePage(),
    const ProfilePage(),
  ];
  void _onItemTap(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 13, 31, 88),
        centerTitle: true,
        title: Text(
          _laman.elementAt(_index),
          style: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: _pages.elementAt(_index),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 15, top: 15),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 13, 31, 88),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            unselectedItemColor: Colors.white,
            selectedItemColor: const Color.fromARGB(251, 207, 230, 0),
            currentIndex: _index,
            onTap: _onItemTap,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.info),
                label: "Explore",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_2),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final List<String> imgList = [
  'assets/images/banner1.jpg',
  'assets/images/banner2.jpg',
  'assets/images/banner3.jpg',
  'assets/images/banner4.jpg'
];

class _HomePageState extends State<HomePage> {
  int _current = 0;
  final List _list = barang.listBarang;
  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = imgList
        .map((item) => Container(
              height: 200,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(5.0),
                ),
                child: Stack(
                  children: [
                    Image.asset(
                      item,
                      fit: BoxFit.cover,
                      width: 1000,
                    ),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0),
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ))
        .toList();
    return Scaffold(
      body: Center(
        child: ListView(children: [
          const Padding(
            padding: EdgeInsets.only(left: 20, top: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Offers & Deals",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Column(
            children: [
              CarouselSlider(
                items: imageSliders,
                options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 3.1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imgList.map((url) {
                  int index = imgList.indexOf(url);
                  return Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 3,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index
                          ? Theme.of(context).brightness == Brightness.light
                              ? const Color.fromRGBO(0, 0, 0, 0.9)
                              : const Color.fromRGBO(197, 197, 197, 0.898)
                          : Theme.of(context).brightness == Brightness.light
                              ? const Color.fromRGBO(0, 0, 0, 0.4)
                              : const Color.fromRGBO(163, 163, 163, 0.894),
                    ),
                  );
                }).toList(),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, top: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Categories",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const exploreCategory(
                                      kategori: 'kitchen',
                                    )));
                      },
                      child: Container(
                        width: 80,
                        height: 70,
                        margin: const EdgeInsets.only(top: 10, left: 20),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.dining,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const exploreCategory(
                                      kategori: 'electronic',
                                    )));
                      },
                      child: Container(
                        width: 80,
                        height: 70,
                        margin: const EdgeInsets.only(top: 10, left: 20),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.tv,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const exploreCategory(
                                      kategori: 'tables & chairs',
                                    )));
                      },
                      child: Container(
                        width: 80,
                        height: 70,
                        margin: const EdgeInsets.only(top: 10, left: 20),
                        decoration: BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.desk,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const exploreCategory(
                                      kategori: 'bathroom',
                                    )));
                      },
                      child: Container(
                        width: 80,
                        height: 70,
                        margin: const EdgeInsets.only(top: 10, left: 20),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.bathroom,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ])),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, top: 15, bottom: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Produk Populer",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.light
                              ? Colors.white
                              : const Color.fromARGB(255, 34, 32, 32),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetails(
                                  id: index,
                                )));
                  },
                  child: Container(
                    width: 160,
                    margin: const EdgeInsets.only(left: 20),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 160,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            image: DecorationImage(
                              image: AssetImage(_list[index].foto),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          _list[index].nama.toString(),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.black
                                  : Colors.white),
                        ),
                        Text(
                          'RP. ${_list[index].harga.toString()}',
                          style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.black
                                  : Colors.white),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
