import 'package:flutter/material.dart';

void main() {
  runApp(MedicineReminderApp());
}

class MedicineReminderApp extends StatelessWidget {
  const MedicineReminderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MedicineReminderScreen(),
    );
  }
}

class MedicineReminderScreen extends StatefulWidget {
  const MedicineReminderScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MedicineReminderScreenState createState() => _MedicineReminderScreenState();
}

class _MedicineReminderScreenState extends State<MedicineReminderScreen>
    with SingleTickerProviderStateMixin {
  int selectedDateIndex = 0;
  late TabController _tabController;

  final List<String> dates = [
    "10 Jun",
    "11 Jun",
    "12 Jun",
    "13 Jun",
    "14 Jun",
    "15 Jun",
    "16 Jun"
  ];
  final List<String> days = ["Sat", "Sun", "Mon", "Tue", "Wed", "Thu", "Fri"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(67, 0, 0, 0),
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text("aaaaaa",
            style: TextStyle(
                color: Color.fromARGB(255, 148, 31, 23), fontSize: 20)),
      ),
      body: Column(
        children: [
          // Date Selector
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: dates.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDateIndex = index;
                    });
                  },
                  child: Container(
                    width: 90,
                    height: 100,
                    margin: const EdgeInsets.all(15),
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    decoration: BoxDecoration(
                      color: selectedDateIndex == index
                          ? const Color.fromARGB(200, 99, 142, 203)
                          : const Color.fromARGB(255, 177, 200, 214),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: const Color.fromARGB(255, 145, 22, 22)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(days[index],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        Text(
                          dates[index],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // TabBar for switching between "Day" and "Hour" views
          TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            tabs: const [
              Tab(text: "Day"),
              Tab(text: "Hour"),
            ],
          ),

          // TabBar View Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                MedicineListView(),
                MedicineListView(),
              ],
            ),
          ),

          // Add Medicine Button
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddMedicineScreen()),
                );
              },
              backgroundColor: Colors.blue,
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

// Medicine ListView Widget
class MedicineListView extends StatelessWidget {
  final List<Map<String, String>> medicines = [
    {
      "name": "أوجمنتين",
      "time": "1:00 PM",
      "dose": "300 مل جرام",
      "image": "💊"
    },
    {
      "name": "فولتارين",
      "time": "12:00 AM",
      "dose": "75 مل جرام",
      "image": "💉"
    },
    {"name": "يوريڤين", "time": "6:00 PM", "dose": "12 باكيت", "image": "💊"},
  ];

   MedicineListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: medicines.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: ListTile(
            leading: Text(medicines[index]["image"]!,
                style: const TextStyle(fontSize: 30)),
            title: Text(medicines[index]["name"]!,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(medicines[index]["dose"]!),
            trailing: Text(medicines[index]["time"]!),
          ),
        );
      },
    );
  }
}

// Add Medicine Screen
class AddMedicineScreen extends StatefulWidget {
  const AddMedicineScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddMedicineScreenState createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  String selectedType = "Capsule";
  bool afterMeal = false;
  bool beforeMeal = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Medicine", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextField(
              decoration: InputDecoration(labelText: "Medicine Name"),
            ),
            const SizedBox(height: 10),

            // Medicine Type Selection
            const Text("Type of Medicine"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MedicineTypeButton(
                    type: "Capsule",
                    icon: Icons.circle,
                    selectedType: selectedType,
                    onTap: () {
                      setState(() {
                        selectedType = "Capsule";
                      });
                    }),
                MedicineTypeButton(
                    type: "Injection",
                    icon: Icons.medical_services,
                    selectedType: selectedType,
                    onTap: () {
                      setState(() {
                        selectedType = "Injection";
                      });
                    }),
                MedicineTypeButton(
                    type: "Bubbly",
                    icon: Icons.bubble_chart,
                    selectedType: selectedType,
                    onTap: () {
                      setState(() {
                        selectedType = "Bubbly";
                      });
                    }),
              ],
            ),
            const SizedBox(height: 10),

            // Meal Selection
            Row(
              children: [
                Checkbox(
                  value: afterMeal,
                  onChanged: (val) {
                    setState(() {
                      afterMeal = val!;
                    });
                  },
                ),
                const Text("After Meal"),
                Checkbox(
                  value: beforeMeal,
                  onChanged: (val) {
                    setState(() {
                      beforeMeal = val!;
                    });
                  },
                ),
                const Text("Before Meal"),
              ],
            ),

            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}

// Medicine Type Button Widget
class MedicineTypeButton extends StatelessWidget {
  final String type;
  final IconData icon;
  final String selectedType;
  final VoidCallback onTap;

  const MedicineTypeButton(
      {super.key, required this.type,
      required this.icon,
      required this.selectedType,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: selectedType == type ? Colors.blue : Colors.grey),
          Text(type),
        ],
      ),
    );
  }
}
