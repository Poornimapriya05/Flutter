import 'package:flutter/material.dart';
import 'package:diary/Details.dart';

class HomePage extends StatefulWidget {
  final String username; // Add username as a field

  const HomePage({Key? key, required this.username}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController dateController =
      TextEditingController(); // Date field controller
  List<Details> contacts = List.empty(growable: true);

  int selectedIndex = -1;
  DateTime selectedDate = DateTime.now(); // Store the selected date

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Personal Diary App :)'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Hey, ${widget.username}', // Display username in the top right
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background image from the internet
          Positioned.fill(
            child: Image.network(
              'https://st.depositphotos.com/1592314/2871/i/950/depositphotos_28710927-stock-photo-open-empty-diary-book-old.jpg', // Replace with your image URL
              fit: BoxFit.cover,
            ),
          ),
          // Semi-transparent container for your content
          Container(
            color: Colors.white.withOpacity(0.8),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                SizedBox(
                  width: 500, // Constrain the width of the text field
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      prefixIcon:
                          Icon(Icons.title), // Default icon for the text field
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 500, // Constrain the width of the text field
                  child: TextField(
                    controller: contactController,
                    decoration: const InputDecoration(
                      labelText: 'Text Here',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      prefixIcon: Icon(
                          Icons.text_fields), // Default icon for the text field
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Date Picker
                SizedBox(
                  width: 500, // Constrain the width of the text field
                  child: TextField(
                    controller: dateController,
                    readOnly: true, // Prevent manual input of date
                    decoration: const InputDecoration(
                      labelText: 'Select Date',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );

                      if (pickedDate != null && pickedDate != selectedDate) {
                        setState(() {
                          selectedDate = pickedDate;
                          dateController.text =
                              "${pickedDate.year}/${pickedDate.month}/${pickedDate.day}";
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(height: 10),

                // Centering the buttons inside a column and with some padding
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          String name = nameController.text.trim();
                          String contact = contactController.text.trim();
                          String date = dateController.text.trim();
                          if (name.isNotEmpty &&
                              contact.isNotEmpty &&
                              date.isNotEmpty) {
                            setState(() {
                              nameController.text = '';
                              contactController.text = '';
                              dateController.text = '';
                              contacts.add(Details(
                                  name: name,
                                  contact: contact,
                                  date:
                                      date)); // Assuming Details has a date field
                            });
                          }
                        },
                        child: const Text('Save'),
                      ),
                      const SizedBox(width: 20), // Space between buttons
                      ElevatedButton(
                        onPressed: () {
                          String name = nameController.text.trim();
                          String contact = contactController.text.trim();
                          String date = dateController.text.trim();
                          if (name.isNotEmpty &&
                              contact.isNotEmpty &&
                              date.isNotEmpty) {
                            setState(() {
                              nameController.text = '';
                              contactController.text = '';
                              dateController.text = '';
                              contacts[selectedIndex].name = name;
                              contacts[selectedIndex].contact = contact;
                              contacts[selectedIndex].date =
                                  date; // Update date
                              selectedIndex = -1;
                            });
                          }
                        },
                        child: const Text('Update'),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),
                contacts.isEmpty
                    ? const Text(
                        'No Details yet..',
                        style: TextStyle(fontSize: 22),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: contacts.length,
                          itemBuilder: (context, index) => getRow(index),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getRow(int index) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              index % 2 == 0 ? Colors.deepPurpleAccent : Colors.green,
          foregroundColor: Colors.white,
          child: Text(
            contacts[index].name[0],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              contacts[index].name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(contacts[index].contact),
            Text("Date: ${contacts[index].date}"), // Display the date
          ],
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            children: [
              InkWell(
                  onTap: () {
                    nameController.text = contacts[index].name;
                    contactController.text = contacts[index].contact;
                    dateController.text =
                        contacts[index].date; // Populate the date
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: const Icon(Icons.edit)),
              InkWell(
                  onTap: (() {
                    setState(() {
                      contacts.removeAt(index);
                    });
                  }),
                  child: const Icon(Icons.delete)),
            ],
          ),
        ),
      ),
    );
  }
}
