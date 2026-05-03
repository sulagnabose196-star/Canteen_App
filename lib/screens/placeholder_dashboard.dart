import 'package:flutter/material.dart';

class PlaceholderDashboard extends StatelessWidget {
  final String role;

  const PlaceholderDashboard({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text('$role Dashboard'), centerTitle: true),
      body: Center(
        child: Text(
          'Welcome, $role!',
          style: theme.textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
