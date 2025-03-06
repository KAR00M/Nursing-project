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
      home: NurseDetailsPage(),
    );
  }
}

class NurseDetailsPage extends StatefulWidget {
  const NurseDetailsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NurseDetailsPageState createState() => _NurseDetailsPageState();
}

class _NurseDetailsPageState extends State<NurseDetailsPage> {
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
  final Map<String, String> places = {
    " 1": "الغشام",
    " 2": "الغشام",
    " 3": "الغشام",
    " 4": "الغشام",
  };

  String? selectedService;
  String selectedTime = "8:00 AM";
  String selectedDate = "1/7/2024";

  void _navigateToBookingPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookingPage(
          selectedService: selectedService ?? "",
          price: selectedService != null ? prices[selectedService]! : "0 EGP",
          selectedTime: selectedTime,
          selectedDate: selectedDate,
        ),
      ),
    );
  }

  Widget _buildTimePicker(
      String label, String initialValue, Function(String) onChanged) {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        // fillColor: const Color.fromARGB(41, 17, 112, 141),
        // filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: label,
      ),
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

  Widget _buildDatePicker(
      String label, String initialValue, Function(String) onChanged) {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        // fillColor: const Color.fromARGB(41, 17, 112, 141),
        // filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: label,
      ),
      controller: TextEditingController(text: initialValue),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2030),
        );
        if (pickedDate != null) {
          setState(() {
            String formattedDate =
                "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
            onChanged(formattedDate);
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Nurse Details",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(57, 88, 134, 1.0),
      ),
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(13, 16, 117, 194),
              offset: Offset(4, 10),
              spreadRadius: 2,
              blurRadius: 2,
            )
          ],
        ),
        padding: EdgeInsets.all(6),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        width: 6,
                        color: const Color.fromARGB(92, 82, 103, 134))),
                child: Column(
                  children: [
                    Image.asset("assets/2.jpg", fit: BoxFit.cover),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("BSN / Ahmed Mokhtar",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Row(children: [
                            Icon(Icons.star, color: Colors.amber),
                            Text("4.9")
                          ]),
                        ],
                      ),
                    ),
                    Text(
                        "Experienced nurse providing full medical care. Experienced nurse providing full medical care.Experienced nurse providing full medical care."),
                    SizedBox(height: 20),
                  ],
                ),
              ),
          
              // Services Dropdown
              Container(
                margin: EdgeInsets.only(top: 20),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Select Service"),
                  value: selectedService,
                  items: prices.keys.map((String key) {
                    return DropdownMenuItem<String>(
                      value: key,
                      child: Text("$key - ${prices[key]}"),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedService = newValue;
                    });
                  },
                ),
              ),
              SizedBox(height: 10),
          
              // Time Picker
              _buildTimePicker("Select Time", selectedTime, (value) {
                setState(() {
                  selectedTime = value;
                });
              }),
              SizedBox(height: 10),
          
              // Date Picker
              _buildDatePicker("Select Date", selectedDate, (value) {
                setState(() {
                  selectedDate = value;
                });
              }),
              SizedBox(height: 20),
          
              Container(
                margin: EdgeInsets.only(top: 45),
                child: ElevatedButton(
                  onPressed: _navigateToBookingPage,
                  child: Text(
                    "Book Now",
                    style: TextStyle(
                        fontSize: 18,
                        color: const Color.fromARGB(255, 22, 41, 164)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookingPage extends StatefulWidget {
  final String selectedService;
  final String price;
  final String selectedTime;
  final String selectedDate;

  const BookingPage({
    super.key,
    required this.selectedService,
    required this.price,
    required this.selectedTime,
    required this.selectedDate,
  });

  @override
  // ignore: library_private_types_in_public_api
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  String gender = "Male";
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  void _confirmBooking() {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Booking Confirmed!")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Booking Confirmation",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(57, 88, 134, 1.0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(209, 255, 255, 255),
            border: Border.all(),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(139, 57, 88, 134),
                offset: Offset(10, 10),
                spreadRadius: 32,
                blurRadius: 12,
              )
            ],
          ),
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                    labelText: "Full Name", border: OutlineInputBorder()),
              ),
              SizedBox(height: 10),

              // Gender Radio
              Row(
                children: [
                  Text("Gender: "),
                  Radio(
                    value: "Male",
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value as String;
                      });
                    },
                  ),
                  Text("Male"),
                  Radio(
                    value: "Female",
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value as String;
                      });
                    },
                  ),
                  Text("Female"),
                ],
              ),
              SizedBox(height: 10),

              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    labelText: "Phone Number", border: OutlineInputBorder()),
              ),
              SizedBox(height: 10),

              // Summary
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  border: Border.all(),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(43, 176, 185, 192),
                      offset: Offset(4, 10),
                      spreadRadius: 2,
                      blurRadius: 2,
                    )
                  ],
                ),
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(vertical: 60),
                child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          "SELECTED SERVICES: ${widget.selectedService}",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                    Container(
                        width: 250,
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Price:  ${widget.price}"),
                            Icon(Icons.attach_money_sharp)
                          ],
                        )),
                    Container(
                        width: 250,
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Time:   ${widget.selectedTime}"),
                            Icon(Icons.access_time_rounded)
                          ],
                        )),
                    Container(
                        width: 250,
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Date:    ${widget.selectedDate}"),
                            Icon(Icons.date_range)
                          ],
                        )),
                    SizedBox(height: 20),
                  ],
                ),
              ),

              ElevatedButton(
                onPressed: _confirmBooking,
                child: Text("Confirm Booking"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
