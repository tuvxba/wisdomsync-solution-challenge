import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'stats_screen.dart';
import 'settings_screen.dart';
import 'recent_activity_screen.dart';
import 'progress_tracking_screen.dart';
import 'donation_screen.dart';
import '../token_provider.dart';
import 'welcome_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int userTokens = Provider.of<TokenProvider>(context).userTokens;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(Icons.monetization_on),
                const SizedBox(width: 3),
                Text(
                  '$userTokens',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/flower.jpg'),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Tuğba Yaramış',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10.0),
              _buildSectionTitle('Settings', Icons.settings, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              }),
              const SizedBox(height: 4.0),
              _buildSectionTitle('Stats', Icons.insert_chart, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StatsScreen(),
                  ),
                );
              }),
              const SizedBox(height: 4.0),
              _buildSectionTitle('Recent Activity', Icons.access_time, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RecentActivityScreen(),
                  ),
                );
              }),
              const SizedBox(height: 4.0),
              _buildSectionTitle('Progress Tracking', Icons.timeline, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProgressTrackingScreen(),
                  ),
                );
              }),
              const SizedBox(height: 4.0),
              _buildSectionTitle('Support Us!', Icons.favorite, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DonationScreen(),
                  ),
                );
              }),
              const SizedBox(height: 4.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WelcomeScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 231, 137, 145),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(
      String title, IconData icon, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        height: 60.0,
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: const Color(0xFFEFEFEF),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 30.0,
                  color: Colors.black,
                ),
                const SizedBox(width: 16.0),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 231, 137, 145),
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color.fromARGB(255, 231, 137, 145),
            ),
          ],
        ),
      ),
    );
  }
}
