import 'package:flutter/material.dart';

void main() {
  runApp(NurseDetailsApp());
}

class NurseDetailsApp extends StatelessWidget {
  const NurseDetailsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NurseDetailsPage(),
    );
  }
}

class NurseDetailsPage extends StatelessWidget {
  const NurseDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Row(
          children: [
            Icon(Icons.star_border_outlined, color: Colors.amber),
            SizedBox(width: 15),
            Text(
              "Nurse Details",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Icon(Icons.notifications, color: Colors.black),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: const Color.fromARGB(29, 119, 176, 223),
              borderRadius: BorderRadius.circular(20)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Section
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          // Profile Image
                          Container(
                            width: 90,
                            height: 120,
                            decoration: BoxDecoration(
                              border: Border.all(),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                )
                              ],
                              borderRadius: BorderRadius.circular(10),
                              image: const DecorationImage(
                                image: AssetImage(
                                    'assets/1.jpg'), // Replace with your image
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          // Nurse Info
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "BSN. AHMED MOKHTAR",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  _infoCard(
                                      "Time", "8:00AM | 8:00PM\nSat - Thur"),
                                  const SizedBox(width: 5),
                                  Column(
                                    children: [
                                      _infoCard("⭐ 4.9", ""),
                                      _infoCard("EXP:", "10 Years"),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Contact Icons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(107, 195, 203, 210),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.phone, color: Colors.blue)),
                          const SizedBox(width: 35),
                          Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(107, 195, 203, 210),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.email, color: Colors.blue)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),

                // About Section
                const Text(
                  "About Nurse:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text(
                  "ممرضة ذات خبرة واسعة في تقديم الرعاية الصحية الشاملة للمرضى بمختلف الحالات. بارعة في تنفيذ الإجراءات الطبية، متابعة العلامات الحيوية، وإدارة الأدوية وفقًا لأعلى معايير السلامة. تتميز بالتواصل الفعال، والتعامل الإنساني.",
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 15),

                // Date Selection Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      onPressed: () {},
                      child: const Text("Next"),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue[50],
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.calendar_today, size: 18),
                          SizedBox(width: 5),
                          Text("1/7/2024"),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300]),
                      onPressed: () {},
                      child: const Text("Previous",
                          style: TextStyle(color: Colors.black)),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                // Appointments Table
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue[50],
                  ),
                  child: Column(
                    children: [
                      _tableHeader(),
                      const Divider(),
                      _tableRow(1, "Abeer Shahin", "8:00 AM", "الغشام", true),
                      _tableRow(
                          2, "Nourhan Ismail", "10:00 AM", "الغشام", false),
                      _tableRow(3, "Esraa Adel", "12:00 PM", "الغشام", true),
                      _tableRow(4, "Nada Fawzy", "1:00 PM", "الغشام", false),
                      _tableRow(5, "Kareem Hesham", "2:30 PM", "الغشام", false),
                      _tableRow(6, "Ziad Saleh", "4:20 PM", "الغشام", false),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.access_time), label: "Reminder"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  // Widget for Info Card
  Widget _infoCard(String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue[100],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(subtitle, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  // Widget for Table Header
  Widget _tableHeader() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("No", style: TextStyle(fontWeight: FontWeight.bold)),
        Text("Name", style: TextStyle(fontWeight: FontWeight.bold)),
        Text("Time", style: TextStyle(fontWeight: FontWeight.bold)),
        Text("Place", style: TextStyle(fontWeight: FontWeight.bold)),
        Icon(Icons.check_box_outline_blank),
      ],
    );
  }

  // Widget for Table Row
  Widget _tableRow(
      int no, String name, String time, String place, bool checked) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("$no"),
        Text(name),
        Text(time),
        Text(place),
        Icon(checked ? Icons.check_box : Icons.check_box_outline_blank,
            color: checked ? Colors.green : Colors.grey),
      ],
    );
  }
}
