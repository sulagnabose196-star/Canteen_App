# CMS — Canteen Management System (Flutter)

A production-ready Flutter app with role-based authentication for Students, Operators, and Admins.

---

## Project Structure

```
lib/
├── main.dart                          # App entry, routing
├── routes.dart                        # Named route constants
├── models/                            # Data models (Meal, Booking, etc.)
├── providers/                         # State management (CanteenProvider)
├── theme/
│   └── app_theme.dart                 # Branding, colors & spacing
├── widgets/                           # UI components & shared widgets
└── screens/
    ├── admin/                         # System administration portal
    ├── operator/                      # Canteen management (TNU CMS/CanteenGo)
    ├── student/                       # Student ordering & token system
    └── auth/                          # Shared authentication logic
```

---

## Navigation Flow

```
StudentLoginScreen  ──────────────────┐
       │                              │
       ├─[Login as Operator]──► OperatorLoginScreen
       │                              │
       ├─[Login as Admin]────► AdminLoginScreen
       │                              │
       └─[Sign Up]──────────► StudentSignupScreen ──► AccountSuccessScreen
                                                            │
OperatorLoginScreen ──────────────────────────────────┐    │
       └─[Sign Up]──────────► OperatorRegistrationScreen───┘
                                                       │
                                              ┌────────▼───────┐
                                              │ AccountSuccess  │
                                              │ Screen         │
                                              └────────┬───────┘
                                                       │
                                              [Go to Login]
                                                       │
                                        ┌──────────────┼──────────────┐
                                        ▼              ▼              ▼
                               StudentLogin   OperatorLogin    AdminLogin
                                        │              │              │
                                [Login]─▼       [Login]▼      [Login]▼
                             StudentDashboard OperatorDashboard AdminDashboard
```

---

## Screens

| Screen | Route | Description |
|--------|-------|-------------|
| Student Login | `/` | Default entry — email/ID + password |
| Admin Login | `/admin-login` | Admin portal with restricted access |
| Operator Login | `/operator-login` | Staff login for canteen operators |
| Student Signup | `/student-signup` | Multi-field registration with strength meter |
| Operator Registration | `/operator-registration` | Two-section professional onboarding |
| Account Success | `/account-success` | Post-signup animated confirmation |
| Student Dashboard | `/student/dashboard` | Placeholder — extend as needed |
| Admin Dashboard | `/admin/dashboard` | Placeholder — extend as needed |
| Operator Dashboard | `/operator/dashboard` | Placeholder — extend as needed |

---

## Key Components (`cms_widgets.dart`)

| Widget | Purpose |
|--------|---------|
| `CMSLogo` | App icon + name display |
| `CMSTextField` | Labeled text input with prefix/suffix |
| `CMSPasswordField` | Password field with show/hide toggle |
| `CMSButton` | Primary / outlined CTA button |
| `CMSCard` | Elevated white card container |
| `RoleBadge` | Pill badge for role labels |
| `FormSectionHeader` | Numbered section divider for long forms |
| `showCMSSnackbar()` | Helper for success/error snackbars |

---

## Getting Started

```bash
# 1. Get dependencies
flutter pub get

# 2. Run on device/emulator
flutter run

# 3. Build release APK
flutter build apk --release
```

---

## Connecting Real Auth

Replace the `await Future.delayed(...)` stubs in each screen with your actual API calls:

```dart
// Example: student login
Future<void> _handleLogin() async {
  if (!_formKey.currentState!.validate()) return;
  setState(() => _isLoading = true);
  
  try {
    final response = await AuthService.loginStudent(
      emailOrId: _emailController.text,
      password: _passwordController.text,
    );
    if (response.success) {
      Navigator.pushReplacementNamed(context, AppRoutes.studentDashboard);
    } else {
      showCMSSnackbar(context, response.message, isError: true);
    }
  } catch (e) {
    showCMSSnackbar(context, 'Login failed. Please try again.', isError: true);
  } finally {
    setState(() => _isLoading = false);
  }
}
```

---

## Design Tokens

```dart
AppColors.primary       // #0D1B5E — Navy blue (buttons, icons)
AppColors.accent        // #2563EB — Blue (links, highlights)
AppColors.background    // #F5F6FA — Off-white background
AppColors.surface       // #FFFFFF — Card background
AppColors.inputFill     // #F0F2F8 — Input field fill
AppColors.success       // #10B981 — Green (success states)
```
