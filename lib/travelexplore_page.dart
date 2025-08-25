import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class TravelExplorePage extends StatefulWidget {
  const TravelExplorePage({super.key});

  @override
  _TravelExplorePageState createState() => _TravelExplorePageState();
}

class _TravelExplorePageState extends State<TravelExplorePage> {
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _diaryController = TextEditingController();

  List<String> _allCountries = [];
  List<String> _filteredCountries = [];
  String? _selectedCountry;

  List<File> selectedImages = [];

  @override
  void initState() {
    super.initState();
    fetchCountries();
  }

  Future<void> fetchCountries() async {
    const String url = "https://restcountries.com/v3.1/all";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _allCountries = data.map((country) => country['name']['common'] as String).toList();
          _allCountries.sort();
        });
      }
    } catch (e) {
      print("Error fetching countries: $e");
    }
  }

  void filterCountries(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredCountries = [];
      } else {
        _filteredCountries = _allCountries
            .where((country) => country.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
      }
    });
  }

  Future<void> pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? images = await picker.pickMultiImage();

    if (images != null) {
      setState(() {
        selectedImages.addAll(images.map((image) => File(image.path)));
      });
    }
  }

  void submitData() {
    // Logic to save data to Firestore or any backend
    print("Submitted Data:");
    print("Country: $_selectedCountry");
    print("Images: ${selectedImages.length}");
    print("Diary Entry: ${_diaryController.text}");

    // Display popup
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Response Submitted"),
        content: const Text("Your journey is now part of the map – explore more!"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Clear all entered data
              setState(() {
                _selectedCountry = null;
                _countryController.clear();
                selectedImages.clear();
                _diaryController.clear();
              });
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("asset/backt.jpg"),
            fit: BoxFit.cover, // Ensures the background image covers the entire screen
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Select Country Section
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Select Country",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _countryController,
                            onChanged: filterCountries,
                            decoration: const InputDecoration(
                              labelText: "Type to search country",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          if (_filteredCountries.isNotEmpty)
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              constraints: const BoxConstraints(maxHeight: 120),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: _filteredCountries.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(_filteredCountries[index]),
                                    onTap: () {
                                      setState(() {
                                        _selectedCountry = _filteredCountries[index];
                                        _countryController.text = _filteredCountries[index];
                                        _filteredCountries = [];
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                          if (_selectedCountry != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                "Selected Country: $_selectedCountry",
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Upload Images Section
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Upload Images",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          GestureDetector(
                            onTap: pickImages,
                            child: Center(
                              child: Icon(
                                Icons.add_photo_alternate_outlined,
                                size: 80,
                                color: Colors.teal.shade700, // Attractive color
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (selectedImages.isNotEmpty)
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: selectedImages.map((image) {
                                return Stack(
                                  children: [
                                    Image.file(
                                      image,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedImages.remove(image);
                                          });
                                        },
                                        child: const Icon(Icons.cancel, color: Colors.red),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            )
                          else
                            const Center(
                              child: Text(
                                "No images selected.",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Diary Entry Section
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Diary Entry",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _diaryController,
                            maxLines: 8,
                            decoration: const InputDecoration(
                              labelText: "Write your trip diary here...",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Submit Button
                  ElevatedButton(
                    onPressed: submitData,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("Submit", style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
