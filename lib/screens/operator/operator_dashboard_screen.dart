import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/stat_cards.dart';
import '../../widgets/activity_tiles.dart';

class OperatorDashboardScreen extends StatelessWidget {
  const OperatorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Operator Dashboard')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Good Morning, Ravi',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.1,
              children: const [
                StatCard(
                  icon: Icons.restaurant,
                  title: 'Total Bookings',
                  value: '248',
                  trend: '+8%',
                  trendColor: Colors.green,
                ),
                StatCard(
                  icon: Icons.check_circle_outline,
                  title: 'Meals Collected',
                  value: '134',
                  trend: '+12%',
                  trendColor: Colors.green,
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Recent Activity',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            BaseCard(
              child: Column(
                children: [
                  ActivityTile(
                    dotColor: Colors.orange,
                    name: 'Sohan Moyra',
                    action: 'Breakfast scanned',
                    time: '8:02 AM',
                  ),
                  Divider(height: 24),
                  ActivityTile(
                    dotColor: AppTheme.primaryBlue,
                    name: 'Priya Sharma',
                    action: 'Breakfast scanned',
                    time: '7:55 AM',
                    isLast: true,
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
