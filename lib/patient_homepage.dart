import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.alarm), label: 'Reminder'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_sharp), label: 'Faviourite'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: Text('Home', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 90,
              decoration: BoxDecoration(
                color: Color.fromRGBO(21, 70, 145, 0.745),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Our Best Nurse',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        Text('All our Steps',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  Image.asset('assets/1.jpg', width: 140),
                ],
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                suffixIcon: Icon(Icons.format_list_bulleted_rounded),
                hintText: 'Search a Nurses',
                filled: true,
                fillColor: Colors.blue[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  NurseCard(
                    name: 'د/ أحمد مختار',
                    experience: '15',
                    rating: '5',
                    location: 'الغشام',
                    price: '500',
                    time: '12:00AM - 12:00 PM',
                    image: 'assets/1.jpg',
                  ),
                  NurseCard(
                    name: 'د/ اشرفت خالد',
                    experience: '10',
                    rating: '4.5',
                    location: 'القومية',
                    price: '300',
                    time: '8:00AM - 8:00 PM',
                    image: 'assets/1.jpg',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NurseCard extends StatelessWidget {
  final String name, experience, rating, location, price, time, image;
  const NurseCard(
      {super.key,
      required this.name,
      required this.experience,
      required this.rating,
      required this.location,
      required this.price,
      required this.time,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child:
                  Image.asset(image, width: 70, height: 70, fit: BoxFit.cover),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text('$experience سنة خبرة',
                      style: TextStyle(color: Colors.grey)),
                  Text(location, style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(time, style: TextStyle(color: Colors.green)),
                  Text('$price pound / الساعة',
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {},
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Book Now'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
