import 'package:flutter/material.dart';

class AdminSystemNoticesScreen extends StatefulWidget {
  const AdminSystemNoticesScreen({super.key});

  @override
  State<AdminSystemNoticesScreen> createState() =>
      _AdminSystemNoticesScreenState();
}

class _AdminSystemNoticesScreenState extends State<AdminSystemNoticesScreen> {
  final List<_Notice> _notices = [
    _Notice(
      title: 'Scheduled Maintenance Window',
      body:
          'System will undergo maintenance on May 3, 2026 from 11:00 PM to 1:00 AM IST. Booking services will be temporarily unavailable.',
      date: 'May 1, 2026',
      priority: 'High',
      icon: Icons.build_circle_rounded,
      color: Color(0xFFEF4444),
      isPublished: true,
    ),
    _Notice(
      title: 'New Snack Menu Available',
      body:
          'Evening snack options have been updated. Students can now book from 12 new items starting tomorrow.',
      date: 'Apr 30, 2026',
      priority: 'Normal',
      icon: Icons.restaurant_rounded,
      color: Color(0xFF10B981),
      isPublished: true,
    ),
    _Notice(
      title: 'Booking Policy Update',
      body:
          'Effective May 5, booking window has been extended to 48 hours ahead. Cancellation deadline remains 2 hours before the slot.',
      date: 'Apr 28, 2026',
      priority: 'Important',
      icon: Icons.policy_rounded,
      color: Color(0xFF8B5CF6),
      isPublished: true,
    ),
    _Notice(
      title: 'Wallet Top-up Bonus',
      body:
          'Students recharging ₹1000 or more will receive a 5% bonus credit. Valid until May 15, 2026.',
      date: 'Apr 25, 2026',
      priority: 'Normal',
      icon: Icons.account_balance_wallet_rounded,
      color: Color(0xFF3B82F6),
      isPublished: false,
    ),
    _Notice(
      title: 'Holiday Schedule — May 2026',
      body:
          'Canteen will remain closed on May 1 (Labour Day) and May 12 (Buddha Purnima). Pre-order for adjacent days.',
      date: 'Apr 22, 2026',
      priority: 'Important',
      icon: Icons.event_rounded,
      color: Color(0xFFF59E0B),
      isPublished: true,
    ),
  ];

  void _showCreateDialog() {
    final titleCtrl = TextEditingController();
    final bodyCtrl = TextEditingController();
    String priority = 'Normal';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDlg) => Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Create Notice',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A))),
                const SizedBox(height: 16),
                TextField(
                  controller: titleCtrl,
                  decoration: InputDecoration(
                    hintText: 'Notice Title',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: bodyCtrl,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Notice body...',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 12),
                const Text('Priority',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF64748B))),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: ['Normal', 'Important', 'High'].map((p) {
                    final sel = priority == p;
                    return GestureDetector(
                      onTap: () => setDlg(() => priority = p),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: sel
                              ? const Color(0xFF0F172A)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: sel
                                  ? const Color(0xFF0F172A)
                                  : const Color(0xFFE2E8F0)),
                        ),
                        child: Text(p,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: sel
                                    ? Colors.white
                                    : const Color(0xFF64748B))),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(ctx),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: const BorderSide(color: Color(0xFFE2E8F0)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('Cancel',
                            style: TextStyle(
                                color: Color(0xFF64748B),
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (titleCtrl.text.isNotEmpty &&
                              bodyCtrl.text.isNotEmpty) {
                            setState(() {
                              _notices.insert(
                                0,
                                _Notice(
                                  title: titleCtrl.text,
                                  body: bodyCtrl.text,
                                  date: 'Just now',
                                  priority: priority,
                                  icon: Icons.campaign_rounded,
                                  color: priority == 'High'
                                      ? const Color(0xFFEF4444)
                                      : priority == 'Important'
                                          ? const Color(0xFFF59E0B)
                                          : const Color(0xFF3B82F6),
                                  isPublished: false,
                                ),
                              );
                            });
                            Navigator.pop(ctx);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3B82F6),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 0,
                        ),
                        child: const Text('Create',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateDialog,
        backgroundColor: const Color(0xFF0F172A),
        child: const Icon(Icons.add_rounded, color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSummary(),
            Expanded(child: _buildNoticeList()),
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
          const Icon(Icons.campaign_rounded,
              color: Color(0xFF0F172A), size: 24),
          const SizedBox(width: 8),
          const Text('System Notices',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A))),
        ],
      ),
    );
  }

  Widget _buildSummary() {
    final published = _notices.where((n) => n.isPublished).length;
    final drafts = _notices.where((n) => !n.isPublished).length;
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 16, 20, 8),
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
          _summaryChip(Icons.public_rounded, 'Published', '$published',
              const Color(0xFF22C55E)),
          Container(width: 1, height: 36, color: const Color(0xFFE2E8F0)),
          _summaryChip(Icons.drafts_rounded, 'Drafts', '$drafts',
              const Color(0xFFF59E0B)),
          Container(width: 1, height: 36, color: const Color(0xFFE2E8F0)),
          _summaryChip(Icons.list_alt_rounded, 'Total',
              '${_notices.length}', const Color(0xFF3B82F6)),
        ],
      ),
    );
  }

  Widget _summaryChip(
      IconData icon, String label, String value, Color color) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(height: 4),
          Text(value,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A))),
          Text(label,
              style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF94A3B8),
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildNoticeList() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 80),
      physics: const BouncingScrollPhysics(),
      itemCount: _notices.length,
      itemBuilder: (_, i) => _buildNoticeCard(_notices[i]),
    );
  }

  Widget _buildNoticeCard(_Notice n) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: n.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(n.icon, color: n.color, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(n.title,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A))),
              ),
              _priorityBadge(n.priority),
            ],
          ),
          const SizedBox(height: 12),
          Text(n.body,
              style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF64748B),
                  height: 1.5)),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.calendar_today,
                  size: 12, color: const Color(0xFF94A3B8)),
              const SizedBox(width: 4),
              Text(n.date,
                  style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF94A3B8),
                      fontWeight: FontWeight.w500)),
              const SizedBox(width: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: n.isPublished
                      ? const Color(0xFF22C55E).withOpacity(0.1)
                      : const Color(0xFFF59E0B).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  n.isPublished ? 'PUBLISHED' : 'DRAFT',
                  style: TextStyle(
                    color: n.isPublished
                        ? const Color(0xFF22C55E)
                        : const Color(0xFFF59E0B),
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  setState(() => n.isPublished = !n.isPublished);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(8),
                    border:
                        Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Text(
                    n.isPublished ? 'Unpublish' : 'Publish',
                    style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF64748B)),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => setState(() => _notices.remove(n)),
                child: const Icon(Icons.delete_outline,
                    size: 18, color: Color(0xFFEF4444)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _priorityBadge(String priority) {
    Color color;
    switch (priority) {
      case 'High':
        color = const Color(0xFFEF4444);
        break;
      case 'Important':
        color = const Color(0xFFF59E0B);
        break;
      default:
        color = const Color(0xFF3B82F6);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        priority.toUpperCase(),
        style: TextStyle(
            color: color, fontSize: 9, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _Notice {
  final String title;
  final String body;
  final String date;
  final String priority;
  final IconData icon;
  final Color color;
  bool isPublished;

  _Notice({
    required this.title,
    required this.body,
    required this.date,
    required this.priority,
    required this.icon,
    required this.color,
    required this.isPublished,
  });
}
