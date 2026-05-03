import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';

class CanteenGoMenu extends StatefulWidget {
  const CanteenGoMenu({super.key});

  @override
  State<CanteenGoMenu> createState() => _CanteenGoMenuState();
}

class _CanteenGoMenuState extends State<CanteenGoMenu>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;
  int _selectedDay = 2; // Default to tomorrow
  bool _showAddForm = false;

  late List<DateTime> _dateList;
  final _menuItems = <_MenuItem>[
    _MenuItem('Poha', 'Light & Healthy', 220, ['Veg'], Icons.rice_bowl_rounded),
    _MenuItem('Scrambled Eggs', 'Protein Rich', 310, [
      'Non-Veg',
      'Protein',
    ], Icons.egg_rounded),
    _MenuItem('Multi-Grain Toast', 'Fiber Rich', 180, [
      'Veg',
      'Whole Grain',
    ], Icons.bakery_dining_rounded),
    _MenuItem('Masala Dosa', 'South Indian', 350, [
      'Veg',
    ], Icons.breakfast_dining_rounded),
  ];

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 3, vsync: this);

    final now = DateTime.now();
    _dateList = List.generate(7, (index) {
      return now.add(Duration(days: index - 1));
    });
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildDateSelector(),
            _buildMealTabs(),
            Expanded(child: _showAddForm ? _buildAddForm() : _buildMenuList()),
          ],
        ),
      ),
      floatingActionButton: !_showAddForm
          ? FloatingActionButton.extended(
              onPressed: () => setState(() => _showAddForm = true),
              backgroundColor: AppColors.primary,
              icon: const Icon(Icons.add_rounded, color: Colors.white),
              label: const Text(
                'Add Item',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        children: [
          Text(
            'Manage Menu',
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: AppColors.textDark,
              letterSpacing: -0.5,
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Save All',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    return SizedBox(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        itemCount: _dateList.length,
        itemBuilder: (context, i) {
          final sel = i == _selectedDay;
          final date = _dateList[i];
          final isAccessible = i == 2; // Only tomorrow is accessible
          final isPrevious = i == 0; // Previous day

          final months = [
            'Jan',
            'Feb',
            'Mar',
            'Apr',
            'May',
            'Jun',
            'Jul',
            'Aug',
            'Sep',
            'Oct',
            'Nov',
            'Dec',
          ];
          final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
          String dateText =
              '${weekdays[date.weekday - 1]}, ${date.day} ${months[date.month - 1]}';

          if (i == 0) {
            dateText = 'Yesterday';
          } else if (i == 1)
            dateText = 'Today';
          else if (i == 2)
            dateText = 'Tomorrow';

          return GestureDetector(
            onTap: isAccessible ? () => setState(() => _selectedDay = i) : null,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                gradient: sel ? AppColors.primaryGradient : null,
                color: sel
                    ? null
                    : (isAccessible
                          ? AppColors.surfaceVariant
                          : Colors.grey.shade200),
                borderRadius: BorderRadius.circular(AppRadius.pill),
                border: isAccessible && !sel
                    ? Border.all(
                        color: AppColors.primary.withValues(alpha: 0.3),
                      )
                    : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    dateText,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: sel
                          ? Colors.white
                          : (isAccessible
                                ? AppColors.textDark
                                : AppColors.textTertiary),
                    ),
                  ),
                  if (isPrevious) ...[
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.success.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'Completed',
                        style: TextStyle(
                          fontSize: 9,
                          color: AppColors.success,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ] else if (!isAccessible) ...[
                    const SizedBox(width: 4),
                    Icon(
                      Icons.lock_outline,
                      size: 12,
                      color: AppColors.textTertiary,
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMealTabs() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 12, 20, 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        controller: _tabCtrl,
        indicator: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.white,
        unselectedLabelColor: AppColors.textSecondary,
        labelStyle: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        dividerHeight: 0,
        tabs: const [
          Tab(text: 'Breakfast'),
          Tab(text: 'Lunch'),
          Tab(text: 'Dinner'),
        ],
      ),
    );
  }

  Widget _buildMenuList() {
    return ReorderableListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 80),
      itemCount: _menuItems.length,
      onReorder: (o, n) {
        setState(() {
          if (n > o) n--;
          final item = _menuItems.removeAt(o);
          _menuItems.insert(n, item);
        });
      },
      itemBuilder: (context, i) {
        final item = _menuItems[i];
        return Padding(
          key: ValueKey(item.name),
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.cardWhite,
              borderRadius: BorderRadius.circular(AppRadius.lg),
              boxShadow: AppShadows.card,
              border: Border.all(color: AppColors.border.withOpacity(0.4)),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 6,
              ),
              leading: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primarySurface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(item.icon, color: AppColors.primary, size: 24),
              ),
              title: Text(
                item.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${item.calories} kcal · ${item.desc}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 4,
                    children: item.tags
                        .map(
                          (t) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: t == 'Non-Veg'
                                  ? AppColors.warningRedLight
                                  : AppColors.accentGreenLight,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              t,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: t == 'Non-Veg'
                                    ? AppColors.warningRed
                                    : AppColors.accentGreen,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.edit_rounded,
                      size: 18,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () {},
                  ),
                  const Icon(
                    Icons.drag_handle_rounded,
                    color: AppColors.textTertiary,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAddForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Create Custom Item',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => setState(() => _showAddForm = false),
                icon: const Icon(Icons.close_rounded),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _field('Item Name', 'e.g. Scrambled Eggs'),
          _field('Category', 'e.g. Breakfast'),
          Row(
            children: [
              Expanded(child: _field('Serving Size', 'e.g. 250 g')),
              const SizedBox(width: 12),
              Expanded(child: _field('Calories', 'e.g. 310')),
            ],
          ),
          _field('Dietary Type', 'Veg / Non-Veg / Vegan'),
          _field('Allergens (optional)', 'e.g. Gluten, Dairy'),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => setState(() => _showAddForm = false),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Save & Publish Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text('Add to Menu'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _field(String label, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 6),
          TextField(decoration: InputDecoration(hintText: hint)),
        ],
      ),
    );
  }
}

class _MenuItem {
  final String name, desc;
  final int calories;
  final List<String> tags;
  final IconData icon;
  _MenuItem(this.name, this.desc, this.calories, this.tags, this.icon);
}
