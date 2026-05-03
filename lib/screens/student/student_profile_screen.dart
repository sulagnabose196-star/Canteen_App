import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/canteen_provider.dart';
import '../../theme/app_theme.dart';
import '../../routes.dart';

class StudentProfileScreen extends StatefulWidget {
  const StudentProfileScreen({super.key});
  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  final String _selectedHostel = 'Block B - Room 214';
  final _phoneController = TextEditingController(text: '+91 98765 43210');
  final String _roomController = '214';
  bool _isEditingPhone = false;

  final List<String> _hostelOptions = [
    'Block A - Sunrise',
    'Block B - Room 214',
    'Block C - Blue Ridge',
    'Block D - Hilltop',
  ];

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CanteenProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Account Settings',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          children: [
            const SizedBox(height: 12),

            // // ── Profile Avatar & Name ──────────────────────────
            // _buildProfileHeader(provider),
            const SizedBox(height: 24),

            // ── Personal Information ───────────────────────────
            _buildSectionCard(
              icon: Icons.person_outline,
              title: 'Personal\nInformation',
              children: [
                _buildReadOnlyField(
                  label: 'Email Address',
                  value:
                      '${provider.userName.toLowerCase().replaceAll(' ', '.')}@university.edu',
                ),
                const SizedBox(height: 14),
                _buildReadOnlyField(
                  label: 'Student UID',
                  value: provider.rollNumber,
                ),
                const SizedBox(height: 14),
                _buildReadOnlyField(
                  label: 'Department',
                  value: 'School of Computer Science & Eng',
                ),
              ],
            ),
            const SizedBox(height: 16),

            // ── Contact Details ────────────────────────────────
            _buildSectionCard(
              icon: Icons.phone_outlined,
              title: 'Contact Details',
              children: [
                _buildEditablePhoneField(),
              ],
            ),
            const SizedBox(height: 16),

            // ── Residential Info ───────────────────────────────
            _buildSectionCard(
              icon: Icons.apartment,
              title: 'Residential Info',
              children: [
                _buildDropdownField(
                  label: 'Hostel Number',
                  value: _selectedHostel,
                  items: _hostelOptions,
                ),
                const SizedBox(height: 14),
                _buildReadOnlyField(
                    label: 'Hostel Room Number', value: _roomController),
              ],
            ),
            const SizedBox(height: 28),

            // ── Logout Button ──────────────────────────────────
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () => _showLogoutDialog(context),
                icon: const Icon(Icons.logout, size: 20),
                label: const Text(
                  'Logout Account',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEF4444),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Future<void> _pickImage(CanteenProvider provider) async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     // TODO: Implement profile image update in CanteenProvider
  //   }
  // }

  // ── Profile Header ────────────────────────────────────────────
  // Widget _buildProfileHeader(CanteenProvider provider) {
  //   return Column(
  //     // children: [
  //     //   // Avatar
  //     //   Stack(
  //     //     alignment: Alignment.bottomRight,
  //         // children: [
  //           // Container(
  //           //   width: 100,
  //           //   height: 100,
  //           //   decoration: BoxDecoration(
  //           //     shape: BoxShape.circle,
  //           //     gradient: LinearGradient(
  //           //       colors: [
  //           //         AppColors.primary.withValues(alpha: 0.15),
  //           //         AppColors.primary.withValues(alpha: 0.1),
  //           //       ],
  //           //       begin: Alignment.topLeft,
  //           //       end: Alignment.bottomRight,
  //           //     ),
  //           //     border: Border.all(
  //           //       color: AppColors.primary.withValues(alpha: 0.2),
  //           //       width: 3,
  //           //     ),
  //           //     boxShadow: [
  //           //       BoxShadow(
  //           //         color: AppColors.primary.withValues(alpha: 0.12),
  //           //         blurRadius: 16,
  //           //         offset: const Offset(0, 6),
  //           //       ),
  //           //     ],
  //           //   ),
  //           //   child: CircleAvatar(
  //           //     radius: 46,
  //           //     backgroundColor: Colors.transparent,
  //           //     backgroundImage: provider.profileImagePath != null
  //           //         ? FileImage(File(provider.profileImagePath!))
  //           //         : null,
  //           //     child: provider.profileImagePath == null
  //           //         ? const Icon(Icons.person,
  //           //             size: 48, color: AppColors.primary)
  //           //         : null,
  //           //   ),
  //           // ),
  //           // GestureDetector(
  //           //   onTap: () => _pickImage(provider),
  //           //   child: Container(
  //           //     padding: const EdgeInsets.all(6),
  //           //     decoration: BoxDecoration(
  //           //       color: AppColors.primary,
  //           //       shape: BoxShape.circle,
  //           //       border: Border.all(color: Colors.white, width: 2),
  //           //     ),
  //           //     child: const Icon(
  //           //       Icons.camera_alt,
  //           //       size: 16,
  //           //       color: Colors.white,
  //           //     ),
  //           //   ),
  //           // ),
  //         // ],
  //       // ),
  //       const SizedBox(height: 14),

  //       // Name
  //       Text(
  //         provider.userName,
  //         style: const TextStyle(
  //           fontSize: 20,
  //           fontWeight: FontWeight.bold,
  //           color: AppColors.textPrimary,
  //         ),
  //       ),
  //       const SizedBox(height: 8),

  //       // Badge
  //       Container(
  //         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
  //         decoration: BoxDecoration(
  //           color: AppColors.success.withValues(alpha: 0.12),
  //           borderRadius: BorderRadius.circular(20),
  //         ),
  //         child: const Text(
  //           'Final Year Student',
  //           style: TextStyle(
  //             fontSize: 12,
  //             fontWeight: FontWeight.w600,
  //             color: AppColors.success,
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // ── Section Card ──────────────────────────────────────────────
  Widget _buildSectionCard({
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withValues(alpha: 0.03),
        //     blurRadius: 10,
        //     offset: const Offset(0, 3),
        //   ),
        // ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section heading
          Row(
            children: [
              Icon(icon, size: 22, color: AppColors.primary),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  height: 1.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          ...children,
        ],
      ),
    );
  }

  // ── Read-Only Field ───────────────────────────────────────────
  Widget _buildReadOnlyField({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }

  // ── Editable Phone Field ──────────────────────────────────────
  Widget _buildEditablePhoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Phone Number',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _isEditingPhone ? AppColors.primary : Colors.grey.shade200,
            ),
            color: Colors.grey.shade50,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _phoneController,
                  enabled: _isEditingPhone,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(fontSize: 14),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                    isDense: true,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  _isEditingPhone ? Icons.check : Icons.edit,
                  size: 18,
                  color: AppColors.primary,
                ),
                onPressed: () {
                  setState(() => _isEditingPhone = !_isEditingPhone);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Dropdown Field ────────────────────────────────────────────
  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    //required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: DropdownButtonHideUnderline(
            child: TextField(
              // controller: _classController,
              enabled: false,
              decoration: InputDecoration(
                hintText: value,
                hintStyle: const TextStyle(
                    color: Color.fromARGB(197, 158, 158, 158), fontSize: 14),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                isDense: true,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ── Logout Dialog ─────────────────────────────────────────────
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title:
            const Text('Logout', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutes.studentLogin, (_) => false);
            },
            child: const Text('Logout',
                style: TextStyle(
                    color: Color(0xFFEF4444), fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
    
  }
}
