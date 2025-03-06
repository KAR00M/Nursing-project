import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  List<Map<String, String>> medicines = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void addMedicine(Map<String, String> medicine) {
    setState(() {
      medicines.add(medicine);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text("Medicine Reminder",
            style: TextStyle(color: Colors.red, fontSize: 20)),
      ),
      body: Column(
        children: [
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
                          ? Colors.blue.shade300
                          : Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.red),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(days[index],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.white)),
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
          Expanded(
            child: ListView.builder(
              itemCount: medicines.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: ListTile(
                    leading: Text(medicines[index]["image"]!,
                        style: const TextStyle(fontSize: 30)),
                    title: Text(medicines[index]["name"]!,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                        "Dose: ${medicines[index]["dose"]!}\nTime: ${medicines[index]["time"]!}\nMeal: ${medicines[index]["meal"]!}\nDate: ${medicines[index]["date"]!}"),
                  ),
                );
              },
            ),
          ),
          FloatingActionButton(
            onPressed: () async {
              final newMedicine = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddMedicineScreen()),
              );
              if (newMedicine != null) {
                addMedicine(newMedicine);
              }
            },
            backgroundColor: Colors.blue,
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class AddMedicineScreen extends StatefulWidget {
  const AddMedicineScreen({super.key});

  @override
  _AddMedicineScreenState createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController doseController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  String selectedType = "💊";
  String selectedMeal = "Before Meal";
  String selectedDate = "";

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        selectedDate = DateFormat('dd MMM yyyy').format(picked);
      });
    }
  }

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
            TextField(controller: nameController, decoration: const InputDecoration(labelText: "Medicine Name")),
            TextField(controller: doseController, decoration: const InputDecoration(labelText: "Dose")),
            TextField(controller: timeController, decoration: const InputDecoration(labelText: "Time")),
            ElevatedButton(onPressed: () => _selectDate(context), child: Text(selectedDate.isEmpty ? "Select Date" : selectedDate)),
            DropdownButton<String>(
              value: selectedMeal,
              onChanged: (String? newValue) {
                setState(() {
                  selectedMeal = newValue!;
                });
              },
              items: ["Before Meal", "After Meal"].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  "name": nameController.text,
                  "dose": doseController.text,
                  "time": timeController.text,
                  "image": selectedType,
                  "meal": selectedMeal,
                  "date": selectedDate,
                });
              },
              child: const Text("Save"),
            ),
          ], 
        ),
      ),
    );
  }
}
