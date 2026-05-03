import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/cms_widgets.dart';
import '../../routes.dart';

class StudentSignUpScreen extends StatefulWidget {
  const StudentSignUpScreen({super.key});

  @override
  State<StudentSignUpScreen> createState() => _StudentSignUpScreenState();
}

class _StudentSignUpScreenState extends State<StudentSignUpScreen>
    with SingleTickerProviderStateMixin {
  // Name validation: no numbers allowed
  String? _validateName(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    if (RegExp(r'[0-9]').hasMatch(value)) {
      return '$fieldName cannot contain numbers';
    }
    return null;
  }

  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _studentIdController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _hostelNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _selectedSemester;
  String? _selectedHostel;
  // final bool _agreeToTerms = false;
  bool _isLoading = false;

  // semester and hostel options (could be fetched from API in real app)
  final List<String> _semesters = [
    'Semester 1',
    'Semester 2',
    'Semester 3',
    'Semester 4',
    'Semester 5',
    'Semester 6',
    'Semester 7',
    'Semester 8',
  ];

  final List<String> _hostels = [
    'Hostel A',
    'Hostel B',
    'Hostel C',
    'Hostel D',
    // 'Day Scholar',
  ];

  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _studentIdController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _hostelNumberController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    if (!_formKey.currentState!.validate()) return;
    // if (!_agreeToTerms) {
    //   showCMSSnackbar(
    //     context,
    //     'Please agree to terms and privacy policy',
    //     isError: true,
    //   );
    //   return;
    // }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1400));
    if (!mounted) return;
    setState(() => _isLoading = false);

    // Navigate to success screen
    Navigator.pushReplacementNamed(
      context,
      AppRoutes.accountSuccess,
      arguments: {'role': 'student', 'name': _firstNameController.text},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnim,
          child: SlideTransition(
            position: _slideAnim,
            child: Column(
              children: [
                // Fixed header
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.inputBorder),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            size: 16,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        'TNU CMS',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),

                // Progress indicator: Step 1 of 2
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Create Account',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Scrollable form
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Form(
                      key: _formKey,
                      child: CMSCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // first name
                            CMSTextField(
                              label: 'First Name',
                              hint: 'Enter your first name',
                              controller: _firstNameController,
                              prefixIcon: const Icon(
                                Icons.person_outline,
                                color: AppColors.textHint,
                                size: 18,
                              ),
                              validator: (v) => _validateName(v, 'First name'),
                            ),
                            // last name
                            const SizedBox(height: 14),
                            CMSTextField(
                              label: 'Last Name',
                              hint: 'Enter your last name',
                              controller: _lastNameController,
                              prefixIcon: const Icon(
                                Icons.person_outline,
                                color: AppColors.textHint,
                                size: 18,
                              ),
                              validator: (v) => _validateName(v, 'Last name'),
                            ),

                            // Student ID field
                            const SizedBox(height: 14),
                            CMSTextField(
                              label: 'Student ID',
                              hint: 'Enter your Student ID',
                              controller: _studentIdController,
                              prefixIcon: const Icon(
                                Icons.badge_outlined,
                                color: AppColors.textHint,
                                size: 18,
                              ),
                              validator: (v) => v == null || v.isEmpty
                                  ? 'Student ID is required'
                                  : null,
                            ),

                            // Semester dropdown
                            const SizedBox(height: 14),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Current Semester',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                DropdownButtonFormField<String>(
                                  initialValue: _selectedSemester,
                                  hint: const Text('Select semester'),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: AppColors.inputFill,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: AppColors.inputBorder,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: AppColors.inputBorder,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 14,
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.school_outlined,
                                      color: AppColors.textHint,
                                      size: 18,
                                    ),
                                  ),
                                  items: _semesters
                                      .map(
                                        (s) => DropdownMenuItem(
                                          value: s,
                                          child: Text(s),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (v) =>
                                      setState(() => _selectedSemester = v),
                                  validator: (v) => v == null
                                      ? 'Please select your semester'
                                      : null,
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            CMSTextField(
                              label: 'Email Address',
                              hint: 'Enter your college email',
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: const Icon(
                                Icons.email_outlined,
                                color: AppColors.textHint,
                                size: 18,
                              ),
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return 'Email is required';
                                }
                                if (!v.contains('@')) {
                                  return 'Enter a valid email';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 14),
                            // Mobile with country code
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Mobile Number',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 15,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.inputFill,
                                        border: Border.all(
                                          color: AppColors.inputBorder,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          bottomLeft: Radius.circular(12),
                                        ),
                                      ),
                                      child: const Text(
                                        '+91',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        controller: _mobileController,
                                        keyboardType: TextInputType.phone,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: AppColors.textPrimary,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: 'Enter mobile number',
                                          filled: true,
                                          fillColor: AppColors.inputFill,
                                          border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(12),
                                              bottomRight: Radius.circular(12),
                                            ),
                                            borderSide: BorderSide(
                                              color: AppColors.inputBorder,
                                            ),
                                          ),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(12),
                                                  bottomRight: Radius.circular(
                                                    12,
                                                  ),
                                                ),
                                                borderSide: BorderSide(
                                                  color: AppColors.inputBorder,
                                                ),
                                              ),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(12),
                                                  bottomRight: Radius.circular(
                                                    12,
                                                  ),
                                                ),
                                                borderSide: BorderSide(
                                                  color: AppColors.primary,
                                                  width: 1.5,
                                                ),
                                              ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                horizontal: 16,
                                                vertical: 14,
                                              ),
                                        ),
                                        validator: (v) {
                                          if (v == null || v.isEmpty) {
                                            return 'Mobile is required';
                                          }
                                          if (v.length < 10) {
                                            return 'Enter valid mobile number';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(height: 14),
                            CMSTextField(
                              label: 'Hostel Number / Room',
                              hint: 'e.g. B-204',
                              controller: _hostelNumberController,
                              prefixIcon: const Icon(
                                Icons.door_back_door_outlined,
                                color: AppColors.textHint,
                                size: 18,
                              ),
                              validator: (v) => v == null || v.isEmpty
                                  ? 'Hostel/Room number is required'
                                  : null,
                            ),
                            const SizedBox(height: 14),

                            // Hostel dropdown
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Hostel Name',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                DropdownButtonFormField<String>(
                                  initialValue: _selectedHostel,
                                  hint: const Text('Select your hostel'),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: AppColors.inputFill,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: AppColors.inputBorder,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: AppColors.inputBorder,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 14,
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.home_outlined,
                                      color: AppColors.textHint,
                                      size: 18,
                                    ),
                                  ),
                                  items: _hostels
                                      .map(
                                        (h) => DropdownMenuItem(
                                          value: h,
                                          child: Text(h),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (v) =>
                                      setState(() => _selectedHostel = v),
                                  validator: (v) => v == null
                                      ? 'Please select your hostel'
                                      : null,
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            _PasswordStrengthField(
                              label: 'Create Password',
                              hint: 'Min 8 characters',
                              controller: _passwordController,
                            ),
                            const SizedBox(height: 14),
                            CMSPasswordField(
                              label: 'Confirm Password',
                              hint: 'Re-enter password',
                              controller: _confirmPasswordController,
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return 'Please confirm your password';
                                }
                                if (v != _passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),

                            // Terms agreement
                            const SizedBox(height: 20),
                            CMSButton(
                              label: 'Continue',
                              onPressed: _handleSignup,
                              isLoading: _isLoading,
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Password field with strength indicator
class _PasswordStrengthField extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;

  const _PasswordStrengthField({
    required this.label,
    required this.hint,
    required this.controller,
  });

  @override
  State<_PasswordStrengthField> createState() => _PasswordStrengthFieldState();
}

class _PasswordStrengthFieldState extends State<_PasswordStrengthField> {
  bool _obscure = true;
  double _strength = 0;
  String _strengthLabel = '';
  Color _strengthColor = Colors.transparent;

  void _evaluateStrength(String password) {
    double strength = 0;
    if (password.length >= 8) strength += 0.25;
    if (password.contains(RegExp(r'[A-Z]'))) strength += 0.25;
    if (password.contains(RegExp(r'[0-9]'))) strength += 0.25;
    if (password.contains(RegExp(r'[!@#\$%^&*]'))) strength += 0.25;

    String label = '';
    Color color = Colors.transparent;
    if (strength == 0) {
      label = '';
      color = Colors.transparent;
    } else if (strength <= 0.25) {
      label = 'Weak';
      color = Colors.red;
    } else if (strength <= 0.5) {
      label = 'Fair';
      color = Colors.orange;
    } else if (strength <= 0.75) {
      label = 'Good';
      color = Colors.amber;
    } else {
      label = 'Strong';
      color = AppColors.success;
    }

    setState(() {
      _strength = strength;
      _strengthLabel = label;
      _strengthColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CMSTextField(
          label: widget.label,
          hint: widget.hint,
          controller: widget.controller,
          obscureText: _obscure,
          prefixIcon: const Icon(
            Icons.lock_outline,
            color: AppColors.textHint,
            size: 18,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _obscure
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: AppColors.textHint,
              size: 18,
            ),
            onPressed: () => setState(() => _obscure = !_obscure),
          ),
          validator: (v) {
            if (v == null || v.isEmpty) return 'Password is required';
            if (v.length < 8) return 'Password must be at least 8 characters';
            return null;
          },
        ),
        if (_strengthLabel.isNotEmpty) ...[
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: _strength,
                    minHeight: 3,
                    backgroundColor: AppColors.inputFill,
                    valueColor: AlwaysStoppedAnimation<Color>(_strengthColor),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                _strengthLabel,
                style: TextStyle(
                  fontSize: 11,
                  color: _strengthColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      _evaluateStrength(widget.controller.text);
    });
  }
}
