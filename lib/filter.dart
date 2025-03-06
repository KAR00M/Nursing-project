import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: FilterPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final Map<String, bool> specialties = {
    "تغيير علي جروح القدم السكري": false,
    "تركيب محاليل": false,
    "تركيب كانولا": false,
    "تمريض منزلي": false,
    "عمل الحجامة النبوية": false,
    "اعطاء حقن عضلي ووريد وتحت الجلد": false,
    "تركيب قسطرة بولية": false,
    "قياس الضغط والسكر": false,
    "اختبار حساسيه": false,
    "تغيير علي جروح العمليات الجراحية": false,
    "غيار علي الحروق": false,
    "حقن شرجية": false,
  };

  final Map<String, String> prices = {
    "تغيير علي جروح القدم السكري": "200 EGP",
    "تركيب محاليل": "150 EGP",
    "تركيب كانولا": "100 EGP",
    "تمريض منزلي": "300 EGP",
    "عمل الحجامة النبوية": "250 EGP",
    "اعطاء حقن عضلي ووريد وتحت الجلد": "120 EGP",
    "تركيب قسطرة بولية": "180 EGP",
    "قياس الضغط والسكر": "80 EGP",
    "اختبار حساسيه": "90 EGP",
    "تغيير علي جروح العمليات الجراحية": "220 EGP",
    "غيار علي الحروق": "210 EGP",
    "حقن شرجية": "130 EGP",
  };

  String? selectedExperience;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter"),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 22),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.delete))],
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(57, 88, 134, 1.0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  hintText: "Search about",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Color.fromRGBO(27, 90, 184, 0.42)),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text("التخصص",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  ...specialties.keys.map((key) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(prices[key]!,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(key, textAlign: TextAlign.right),
                          ),
                        ),
                        Checkbox(
                          value: specialties[key],
                          onChanged: (bool? value) {
                            setState(() {
                              specialties[key] = value!;
                            });
                          },
                        ),
                      ],
                    );
                  }),
                  SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text("سنين الخبرة",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  Column(
                    children: [
                      RadioListTile(
                        title: Align(
                          alignment: Alignment.centerRight,
                          child: Text("سنة إلى 3 سنين"),
                        ),
                        value: "1-3",
                        groupValue: selectedExperience,
                        onChanged: (val) {
                          setState(() {
                            selectedExperience = val.toString();
                          });
                        },
                      ),
                      RadioListTile(
                        title: Align(
                          alignment: Alignment.centerRight,
                          child: Text("4 سنين إلى 6 سنين"),
                        ),
                        value: "4-6",
                        groupValue: selectedExperience,
                        onChanged: (val) {
                          setState(() {
                            selectedExperience = val.toString();
                          });
                        },
                      ),
                      RadioListTile(
                        title: Align(
                          alignment: Alignment.centerRight,
                          child: Text("7 سنين إلى 10 سنين"),
                        ),
                        value: "7-10",
                        groupValue: selectedExperience,
                        onChanged: (val) {
                          setState(() {
                            selectedExperience = val.toString();
                          });
                        },
                      ),
                      RadioListTile(
                        title: Align(
                          alignment: Alignment.centerRight,
                          child: Text("أكثر من 10 سنين"),
                        ),
                        value: "10+",
                        groupValue: selectedExperience,
                        onChanged: (val) {
                          setState(() {
                            selectedExperience = val.toString();
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 26),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50)),
                    child: Text("Search", style: TextStyle(fontSize: 18)),
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
