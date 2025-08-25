import 'package:flutter/material.dart';
import 'travelexplore_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.help_outline),
              title: const Text('Help'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'asset/back3.jpg', // Replace with your background image
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              // App Bar with Back and Hamburger Button
              Padding(
                padding: const EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Builder(
                      builder: (context) {
                        return IconButton(
                          icon: const Icon(Icons.menu, color: Colors.black),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),

              // Header Section
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                child: Column(
                  children: [
                    const Text(
                      "Welcome to Travel Diary",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Start your journey of memories and exploration!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),

              // Card Section
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  children: [
                    // Travel Explore Card
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const TravelExplorePage()),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        elevation: 5,
                        margin: const EdgeInsets.only(bottom: 16.0),
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Image Filling Top
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Image.asset(
                                  'asset/travelexplore.jpg',
                                  fit: BoxFit.cover,
                                  height: 180, // Adjusted height
                                ),
                              ),
                              const SizedBox(height: 10),
                              // Title
                              const Text(
                                "Travel Diary",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 5),
                              // Quote
                              Text(
                                "Every journey has a story. What's yours?",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 15),
                              // Call-to-Action Text
                              const Text(
                                "Kickstart your travel diary!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              const SizedBox(height: 10),
                              // Decorative Divider
                              const Divider(
                                color: Colors.blueGrey,
                                thickness: 1.5,
                                indent: 40,
                                endIndent: 40,
                              ),
                              // Decorative Icons
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.camera_alt_outlined, color: Colors.blueAccent, size: 30),
                                  SizedBox(width: 15),
                                  Icon(Icons.place_outlined, color: Colors.blueAccent, size: 30),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Family Trip Card
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/addFamilyTrip');
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        elevation: 5,
                        margin: const EdgeInsets.only(bottom: 16.0),
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Image Filling Top
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Image.asset(
                                  'asset/familytrip.jpg',
                                  fit: BoxFit.cover,
                                  height: 180, // Adjusted height
                                ),
                              ),
                              const SizedBox(height: 10),
                              // Title
                              const Text(
                                "Travel Back in Time",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 5),
                              // Quote
                              Text(
                                "Re-experience the joy of every trip and the tales behind your pictures.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 15),
                              // Call-to-Action Text
                              const Text(
                                "Tap to Dive Into Your World of Wanderlust",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              const SizedBox(height: 10),
                              // Decorative Divider
                              const Divider(
                                color: Colors.blueGrey,
                                thickness: 1.5,
                                indent: 40,
                                endIndent: 40,
                              ),
                              // Decorative Icons
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.family_restroom_outlined, color: Colors.blueAccent, size: 30),
                                  SizedBox(width: 15),
                                  Icon(Icons.place_outlined, color: Colors.blueAccent, size: 30),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}