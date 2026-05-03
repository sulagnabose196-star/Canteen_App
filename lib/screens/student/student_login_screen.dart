import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/cms_widgets.dart';
import '../../routes.dart';

class StudentLoginScreen extends StatefulWidget {
  const StudentLoginScreen({super.key});

  @override
  State<StudentLoginScreen> createState() => _StudentLoginScreenState();
}

class _StudentLoginScreenState extends State<StudentLoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

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
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    // Simulate network call — replace with real auth logic
    await Future.delayed(const Duration(milliseconds: 1200));

    if (!mounted) return;
    setState(() => _isLoading = false);

    // On success, navigate to student dashboard
    Navigator.pushReplacementNamed(context, AppRoutes.studentShell);
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    // Logo
                    const CMSLogo(),
                    const SizedBox(height: 20),
                    const Text(
                      'Login to continue to your account',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Login card
                    CMSCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CMSTextField(
                            label: 'Email or Student ID',
                            hint: 'Enter your Email or ID',
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,

                            // email icon
                            prefixIcon: const Icon(
                              Icons.email_outlined,
                              color: AppColors.textPrimary,
                              size: 22,
                            ),

                            // give email validation using regrex
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return 'Please enter your Email or ID';
                              }
                              if (RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                              ).hasMatch(v)) {
                                return null;
                              }
                              if (!RegExp(r'^[0-9]{12}$').hasMatch(v)) {
                                return 'Please enter a valid ID';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 16),

                          CMSPasswordField(
                            label: 'Password',
                            hint: 'Enter your password',
                            controller: _passwordController,

                            // password validator
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (v.length < 8) {
                                return 'Password must be at least 8 characters';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 12),

                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: CMSButton(
                                  label: 'Sign In',
                                  onPressed: _handleLogin,
                                  isLoading: _isLoading,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: CMSButton(
                                  label: 'Sign Up',
                                  onPressed: () => Navigator.pushNamed(
                                    context,
                                    AppRoutes.studentRegistration,
                                  ),
                                  isLoading: _isLoading,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Other roles label
                    const Text(
                      'Other Roles',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textHint,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Login as Operator
                    OutlinedButton.icon(
                      onPressed: () =>
                          Navigator.pushNamed(context, AppRoutes.operatorLogin),
                      icon: const Icon(Icons.store_outlined, size: 18),
                      label: const Text('Login as Operator'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 52),
                        foregroundColor: AppColors.primary,
                        side: const BorderSide(
                          color: AppColors.inputBorder,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Login as Admin
                    OutlinedButton.icon(
                      onPressed: () =>
                          Navigator.pushNamed(context, AppRoutes.adminLogin),
                      icon: const Icon(
                        Icons.admin_panel_settings_outlined,
                        size: 18,
                      ),
                      label: const Text('Login as Admin'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 52),
                        foregroundColor: AppColors.primary,
                        side: const BorderSide(
                          color: AppColors.inputBorder,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
