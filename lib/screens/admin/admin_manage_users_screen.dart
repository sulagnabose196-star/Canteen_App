import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes.dart';
// import 'package:provider/provider.dart';
// import '../../providers/canteen_provider.dart';

class AdminManageUsersScreen extends StatefulWidget {
  const AdminManageUsersScreen({super.key});

  @override
  State<AdminManageUsersScreen> createState() => _AdminManageUsersScreenState();
}

class _AdminManageUsersScreenState extends State<AdminManageUsersScreen> {
  final _searchController = TextEditingController();
  String _selectedFilter = 'All';
  final filters = ['All', 'Students', 'Operators', 'Pending', 'Others'];

  final List<_UserItem> _allUsers = [
    _UserItem(
      name: 'Sohan',
      role: 'STUDENT',
      status: 'ACTIVE',
      email: 'sohan@tnu.edu',
      initials: 'S',
      color: Color(0xFF3B82F6),
    ),
    _UserItem(
      name: 'Sulagna',
      role: 'OPERATOR',
      status: 'ACTIVE',
      email: 'sulagna@tnu.edu',
      initials: 'SU',
      color: Color(0xFFF59E0B),
    ),
    _UserItem(
      name: 'Sreyasi',
      role: 'STUDENT',
      status: 'PENDING',
      email: 'sreyasi@tnu.edu',
      initials: 'SR',
      color: Color(0xFF8B5CF6),
    ),
    _UserItem(
      name: 'Bhagyashree',
      role: 'STUDENT',
      status: 'QUARANTINE',
      email: 'bhagya@tnu.edu',
      initials: 'B',
      color: Color(0xFF10B981),
    ),
    _UserItem(
      name: 'Brijil',
      role: 'OPERATOR',
      status: 'ACTIVE',
      email: 'brijil@tnu.edu',
      initials: 'BR',
      color: Color(0xFFEF4444),
    ),
    _UserItem(
      name: 'Priya Singh',
      role: 'STUDENT',
      status: 'ACTIVE',
      email: 'priya@tnu.edu',
      initials: 'PS',
      color: Color(0xFF06B6D4),
    ),
  ];

  List<_UserItem> get _filteredUsers {
    var list = _allUsers;
    if (_selectedFilter == 'Students') {
      list = list.where((u) => u.role == 'STUDENT').toList();
    } else if (_selectedFilter == 'Operators') {
      list = list.where((u) => u.role == 'OPERATOR').toList();
    } else if (_selectedFilter == 'Pending') {
      list = list.where((u) => u.status == 'PENDING').toList();
    }
    final q = _searchController.text.toLowerCase();
    if (q.isNotEmpty) {
      list = list
          .where(
            (u) =>
                u.name.toLowerCase().contains(q) ||
                u.email.toLowerCase().contains(q),
          )
          .toList();
    }
    return list;
  }

  // build scafold // build scafold// build scafold// build scafold// build scafold
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearch(),
            _buildFilterChips(),
            Expanded(child: _buildUserList()),
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
          // GestureDetector(
          //   onTap: () => context.read<CanteenProvider>().setIndex(0),
          //   child: Container(
          //     padding: const EdgeInsets.all(8),
          //     decoration: BoxDecoration(
          //       color: Colors.white,
          //       borderRadius: BorderRadius.circular(10),
          //       border: Border.all(color: const Color(0xFFE2E8F0)),
          //     ),
          //     child: const Icon(
          //       Icons.arrow_back_ios_new,
          //       size: 16,
          //       color: Color(0xFF0F172A),
          //     ),
          //   ),
          // ),
          const SizedBox(width: 12),
          const Icon(
            Icons.people_alt_rounded,
            color: Color(0xFF0F172A),
            size: 24,
          ),
          const SizedBox(width: 10),
          const Text(
            'User Management',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  // search bar// search bar// search bar// search bar// search bar// search bar
  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          controller: _searchController,
          onChanged: (_) => setState(() {}),
          decoration: const InputDecoration(
            hintText: 'Search by Name, ID, or email...',
            hintStyle: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
            prefixIcon: Icon(Icons.search, color: Color(0xFF94A3B8), size: 20),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }

  // filter chips// filter chips// filter chips// filter chips// filter chips// filter chips
  Widget _buildFilterChips() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 8),
      child: SizedBox(
        height: 36,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: filters.length,
          separatorBuilder: (_, _) => const SizedBox(width: 8),
          itemBuilder: (_, i) {
            final sel = _selectedFilter == filters[i];
            return GestureDetector(
              onTap: () => setState(() => _selectedFilter = filters[i]),
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
                  filters[i],
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

  // user card// user card// user card// user card// user card// user card// user card// user card
  Widget _buildUserList() {
    final users = _filteredUsers;
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final u = users[index];
        return _buildUserCard(u);
      },
    );
  }

  Widget _buildUserCard(_UserItem u) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        AppRoutes.adminUserDetail,
        arguments: u.name,
      ),
      onLongPress: () => _showDeleteDialog(u),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
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
        child: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: u.color.withOpacity(0.15),
              child: Text(
                u.initials,
                style: TextStyle(
                  color: u.color,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    u.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    u.email,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _roleBadge(u.role),
                const SizedBox(height: 6),
                _statusBadge(u.status),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _roleBadge(String role) {
    final color = role == 'STUDENT'
        ? const Color(0xFF3B82F6)
        : const Color(0xFFF59E0B);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        role,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _statusBadge(String status) {
    Color color;
    switch (status) {
      case 'ACTIVE':
        color = const Color(0xFF22C55E);
        break;
      case 'PENDING':
        color = const Color(0xFFF59E0B);
        break;
      case 'QUARANTINE':
        color = const Color(0xFFEF4444);
        break;
      default:
        color = const Color(0xFF94A3B8);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 9,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  void _showDeleteDialog(_UserItem u) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.delete_outline_rounded,
                  color: Color(0xFFEF4444),
                  size: 28,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Confirm Deletion',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Are you sure you want to delete ${u.name}? This action cannot be undone and will permanently remove all associated data.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF64748B),
                  height: 1.5,
                ),
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
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Color(0xFF64748B),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(
                          () => _allUsers.removeWhere((x) => x.name == u.name),
                        );
                        Navigator.pop(ctx);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEF4444),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Delete',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserItem {
  final String name, role, status, email, initials;
  final Color color;
  const _UserItem({
    required this.name,
    required this.role,
    required this.status,
    required this.email,
    required this.initials,
    required this.color,
  });
}
