import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  String name = "BSN.AHMED MOKHTAR";
  String startTime = "8:00 AM";
  String endTime = "8:00 PM";
  String startDay = "Sat";
  String endDay = "Thu";
  String experience = "10";
  String phone = "0123456789";
  String email = "Mokhtaar@gmail.com";
  String about = "ممرضة ذات خبرة واسعة في تقديم الرعاية الصحية...";
  double rating = 4.9;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Profile",
            style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
        bottom: TabBar(
          controller: tabController,
          labelColor: Colors.black,
          indicatorColor: Colors.blue,
          indicatorWeight: 3,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          tabs: const [
            Tab(text: "Overview"),
            Tab(text: "Edit"),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          _buildOverviewTab(),
          _buildEditTab(),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _profileCard(),
          const SizedBox(height: 20),
          const Text("About Nurse:",
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text(about, textAlign: TextAlign.justify),
          const SizedBox(height: 20),
          Container(
            margin: EdgeInsets.only(top: 40, bottom: 10),
            child: Row(
              children: [
                const Icon(Icons.phone, color: Colors.blue),
                const SizedBox(width: 10),
                Text(phone),
              ],
            ),
          ),
          Row(
            children: [
              const Icon(Icons.email, color: Colors.blue),
              const SizedBox(width: 10),
              Text(email),
            ],
          ),
        ],
      ),
    );
  }

  Widget _profileCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: const Color.fromARGB(42, 17, 40, 56).withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(29, 129, 173, 207).withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 15,
          )
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Column(
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/1.jpg'),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber),
                  Text("$rating"),
                ],
              ),
            ],
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text("BMS/ $name",
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Row(
                children: [
                  _infoCard("Time", "From: $startTime\n  To:     $endTime"),
                  const SizedBox(width: 10),
                  _infoCard("Days", "$startDay - $endDay"),
                ],
              ),
              const SizedBox(height: 10),
              _infoCard("Experience", "$experience Years"),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildEditTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildTextField("Name", name, (value) => name = value),
            const SizedBox(height: 10),
            _buildTimePicker(
                "Start Time", startTime, (value) => startTime = value),
            const SizedBox(height: 10),
            _buildTimePicker("End Time", endTime, (value) => endTime = value),
            const SizedBox(height: 10),
            _buildDropdown("Start Day", startDay, (value) => startDay = value!),
            const SizedBox(height: 10),
            _buildDropdown("End Day", endDay, (value) => endDay = value!),
            const SizedBox(height: 10),
            _buildNumberField("Experience (Years)", experience,
                (value) => experience = value),
            const SizedBox(height: 10),
            _buildPhoneField(),
            const SizedBox(height: 10),
            _buildTextField("Email", email, (value) => email = value),
            const SizedBox(height: 10),
            _buildTextField("About Nurse", about, (value) => about = value),
            const SizedBox(height: 10),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {});
                  tabController.animateTo(0); // Navigate to Overview tab
                }
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePicker(
      String label, String initialValue, Function(String) onChanged) {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
          fillColor: const Color.fromARGB(41, 17, 112, 141),
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(),
            borderRadius: BorderRadius.circular(10),
          ),
          labelText: label),
      controller: TextEditingController(text: initialValue),
      onTap: () async {
        TimeOfDay? pickedTime = await showTimePicker(
            context: context, initialTime: TimeOfDay.now());
        if (pickedTime != null) {
          setState(() {
            String formattedTime = pickedTime.format(context);
            onChanged(formattedTime);
          });
        }
      },
    );
  }

  Widget _buildDropdown(
      String label, String value, Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      items: ["Sat", "Sun", "Mon", "Tue", "Wed", "Thu", "Fri"].map((day) {
        return DropdownMenuItem(value: day, child: Text(day));
      }).toList(),
      decoration: InputDecoration(
          fillColor: const Color.fromARGB(41, 17, 112, 141),
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(),
            borderRadius: BorderRadius.circular(10),
          ),
          labelText: label),
      onChanged: onChanged,
    );
  }

  Widget _buildNumberField(
      String label, String initialValue, Function(String) onChanged) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          fillColor: const Color.fromARGB(41, 17, 112, 141),
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(),
            borderRadius: BorderRadius.circular(10),
          ),
          labelText: label),
      initialValue: initialValue,
      onChanged: onChanged,
    );
  }

  Widget _buildPhoneField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(
          fillColor: Color.fromARGB(41, 17, 112, 141),
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(),
          ),
          labelText: "Phone"),
      initialValue: phone,
      validator: (value) => (value == null || value.length < 10)
          ? "Enter valid phone number"
          : null,
      onChanged: (value) => phone = value,
    );
  }

  Widget _infoCard(String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.blue[100], borderRadius: BorderRadius.circular(10)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(subtitle)
      ]),
    );
  }

  Widget _buildTextField(
      String label, String initialValue, Function(String) onChanged) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
          fillColor: const Color.fromARGB(41, 17, 112, 141),
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(),
            borderRadius: BorderRadius.circular(10),
          ),
          labelText: label),
      onChanged: onChanged,
    );
  }
}
