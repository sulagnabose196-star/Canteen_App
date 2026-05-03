import 'package:flutter/material.dart';

class AdminNotificationsScreen extends StatefulWidget {
  const AdminNotificationsScreen({super.key});

  @override
  State<AdminNotificationsScreen> createState() =>
      _AdminNotificationsScreenState();
}

class _AdminNotificationsScreenState extends State<AdminNotificationsScreen> {
  String _selectedFilter = 'All';
  final _filters = ['All', 'Alerts', 'Users', 'System', 'Orders'];

  final List<_NotifItem> _notifications = [
    _NotifItem(
      title: 'New Student Registration',
      subtitle: 'Priya Singh has registered and is awaiting approval.',
      time: '2 min ago',
      icon: Icons.person_add_rounded,
      color: Color(0xFF3B82F6),
      category: 'Users',
      isRead: false,
    ),
    _NotifItem(
      title: 'System Alert: High Traffic',
      subtitle:
          'Booking requests spiked 40% in the last hour. Consider scaling.',
      time: '10 min ago',
      icon: Icons.warning_amber_rounded,
      color: Color(0xFFF59E0B),
      category: 'Alerts',
      isRead: false,
    ),
    _NotifItem(
      title: 'Lunch Menu Updated',
      subtitle: 'Operator #12 revised the lunch menu for today.',
      time: '25 min ago',
      icon: Icons.restaurant_menu_rounded,
      color: Color(0xFF10B981),
      category: 'Orders',
      isRead: false,
    ),
    _NotifItem(
      title: 'Account Suspended',
      subtitle: 'User TN789 was suspended due to policy violation.',
      time: '1 hr ago',
      icon: Icons.block_rounded,
      color: Color(0xFFEF4444),
      category: 'Users',
      isRead: true,
    ),
    _NotifItem(
      title: 'Backup Completed',
      subtitle: 'Daily database backup completed successfully at 3:00 AM.',
      time: '3 hrs ago',
      icon: Icons.cloud_done_rounded,
      color: Color(0xFF8B5CF6),
      category: 'System',
      isRead: true,
    ),
    _NotifItem(
      title: 'New Operator Request',
      subtitle: 'Brijil has applied for operator access. Review pending.',
      time: '5 hrs ago',
      icon: Icons.manage_accounts_rounded,
      color: Color(0xFF3B82F6),
      category: 'Users',
      isRead: true,
    ),
    _NotifItem(
      title: 'Meal Waste Alert',
      subtitle:
          '120 uncollected lunch meals today. Above 10% threshold.',
      time: '6 hrs ago',
      icon: Icons.delete_sweep_rounded,
      color: Color(0xFFF59E0B),
      category: 'Alerts',
      isRead: true,
    ),
    _NotifItem(
      title: 'Scheduled Maintenance',
      subtitle:
          'System maintenance planned for tonight 11 PM – 1 AM IST.',
      time: '8 hrs ago',
      icon: Icons.build_circle_rounded,
      color: Color(0xFF64748B),
      category: 'System',
      isRead: true,
    ),
    _NotifItem(
      title: 'Student ID Reissue',
      subtitle: 'Sohan requested an ID card reissue. Pending admin action.',
      time: '1 day ago',
      icon: Icons.credit_card_rounded,
      color: Color(0xFF06B6D4),
      category: 'Users',
      isRead: true,
    ),
    _NotifItem(
      title: 'Dinner Booking Surge',
      subtitle: '95% dinner slots booked for today. Near full capacity.',
      time: '1 day ago',
      icon: Icons.trending_up_rounded,
      color: Color(0xFF10B981),
      category: 'Orders',
      isRead: true,
    ),
  ];

  List<_NotifItem> get _filteredNotifications {
    if (_selectedFilter == 'All') return _notifications;
    return _notifications
        .where((n) => n.category == _selectedFilter)
        .toList();
  }

  int get _unreadCount => _notifications.where((n) => !n.isRead).length;

  void _markAllRead() {
    setState(() {
      for (var n in _notifications) {
        n.isRead = true;
      }
    });
  }

  void _dismissNotification(_NotifItem item) {
    setState(() {
      _notifications.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSummaryBar(),
            _buildFilterChips(),
            Expanded(child: _buildNotificationList()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: const Icon(Icons.arrow_back_ios_new,
                  size: 16, color: Color(0xFF0F172A)),
            ),
          ),
          const SizedBox(width: 12),
          const Icon(Icons.notifications_rounded,
              color: Color(0xFF0F172A), size: 24),
          const SizedBox(width: 8),
          const Text(
            'Notifications',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
          ),
          const Spacer(),
          if (_unreadCount > 0)
            GestureDetector(
              onTap: _markAllRead,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Mark all read',
                  style: TextStyle(
                    color: Color(0xFF3B82F6),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSummaryBar() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          _summaryChip(
            Icons.circle_notifications,
            'Total',
            '${_notifications.length}',
            const Color(0xFF3B82F6),
          ),
          _divider(),
          _summaryChip(
            Icons.mark_email_unread_rounded,
            'Unread',
            '$_unreadCount',
            const Color(0xFFF59E0B),
          ),
          _divider(),
          _summaryChip(
            Icons.warning_amber_rounded,
            'Alerts',
            '${_notifications.where((n) => n.category == 'Alerts').length}',
            const Color(0xFFEF4444),
          ),
        ],
      ),
    );
  }

  Widget _summaryChip(
      IconData icon, String label, String value, Color color) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF94A3B8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      width: 1,
      height: 40,
      color: const Color(0xFFE2E8F0),
    );
  }

  Widget _buildFilterChips() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 8),
      child: SizedBox(
        height: 36,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: _filters.length,
          separatorBuilder: (_, _) => const SizedBox(width: 8),
          itemBuilder: (_, i) {
            final sel = _selectedFilter == _filters[i];
            return GestureDetector(
              onTap: () => setState(() => _selectedFilter = _filters[i]),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: sel ? const Color(0xFF0F172A) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: sel
                        ? const Color(0xFF0F172A)
                        : const Color(0xFFE2E8F0),
                  ),
                ),
                child: Text(
                  _filters[i],
                  style: TextStyle(
                    color: sel ? Colors.white : const Color(0xFF64748B),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildNotificationList() {
    final notifs = _filteredNotifications;

    if (notifs.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFF94A3B8).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.notifications_off_outlined,
                  color: Color(0xFF94A3B8), size: 30),
            ),
            const SizedBox(height: 14),
            const Text(
              'No notifications',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'You\'re all caught up!',
              style: TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      physics: const BouncingScrollPhysics(),
      itemCount: notifs.length,
      itemBuilder: (context, index) {
        final n = notifs[index];
        return _buildNotificationCard(n);
      },
    );
  }

  Widget _buildNotificationCard(_NotifItem n) {
    return Dismissible(
      key: ValueKey(n.title + n.time),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => _dismissNotification(n),
      background: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFEF4444).withOpacity(0.1),
          borderRadius: BorderRadius.circular(14),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete_outline_rounded,
            color: Color(0xFFEF4444), size: 22),
      ),
      child: GestureDetector(
        onTap: () {
          setState(() => n.isRead = true);
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: n.isRead ? Colors.white : const Color(0xFFF0F7FF),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color:
                  n.isRead ? const Color(0xFFE2E8F0) : const Color(0xFFBFDBFE),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: n.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(n.icon, color: n.color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            n.title,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight:
                                  n.isRead ? FontWeight.w600 : FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                        ),
                        if (!n.isRead)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFF3B82F6),
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      n.subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF64748B),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: n.color.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            n.category.toUpperCase(),
                            style: TextStyle(
                              color: n.color,
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(Icons.access_time,
                            size: 12, color: const Color(0xFF94A3B8)),
                        const SizedBox(width: 4),
                        Text(
                          n.time,
                          style: const TextStyle(
                            color: Color(0xFF94A3B8),
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NotifItem {
  final String title;
  final String subtitle;
  final String time;
  final IconData icon;
  final Color color;
  final String category;
  bool isRead;

  _NotifItem({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.icon,
    required this.color,
    required this.category,
    required this.isRead,
  });
}
