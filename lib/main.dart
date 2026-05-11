import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MarketApp());
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const HomePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),
    GoRoute(
      path: '/privacy',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const PrivacyPolicyPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),
    GoRoute(
      path: '/terms',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const TermsOfUsePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),
    GoRoute(
      path: '/contact',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const ContactPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),
  ],
);

class MarketApp extends StatelessWidget {
  const MarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'M Goat - Kenyan Goat Marketplace',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D32),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      routerConfig: router,
    );
  }
}

class AppLayout extends StatelessWidget {
  final Widget child;
  const AppLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const AppHeader(),
          child,
          const AppFooter(),
        ],
      ),
    );
  }
}

class AppHeader extends StatefulWidget {
  const AppHeader({super.key});

  @override
  State<AppHeader> createState() => _AppHeaderState();
}

class _AppHeaderState extends State<AppHeader> {
  bool _isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => context.go('/'),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E7D32),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.landscape,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'M Goat',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B5E20),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            if (MediaQuery.of(context).size.width > 768)
              Row(
                children: [
                  _HeaderLink(label: 'Home', path: '/'),
                  _HeaderLink(label: 'Privacy Policy', path: '/privacy'),
                  _HeaderLink(label: 'Terms of Use', path: '/terms'),
                  _HeaderLink(label: 'Contact', path: '/contact'),
                ],
              )
            else
              IconButton(
                icon: Icon(
                  _isMenuOpen ? Icons.close : Icons.menu,
                  color: const Color(0xFF2E7D32),
                ),
                onPressed: () {
                  setState(() {
                    _isMenuOpen = !_isMenuOpen;
                  });
                },
              ),
          ],
        ),
      ),
    );
  }
}

class _HeaderLink extends StatelessWidget {
  final String label;
  final String path;

  const _HeaderLink({required this.label, required this.path});

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouterState.of(context).uri.path;
    final isActive = currentPath == path;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => context.go(path),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: isActive ? const Color(0xFF2E7D32) : Colors.grey[700],
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Container(
      color: const Color(0xFF1B5E20),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        padding: EdgeInsets.all(isSmallScreen ? 16 : 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isSmallScreen)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(
                          Icons.landscape,
                          color: Color(0xFF2E7D32),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'M Goat',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Kenyan Marketplace for Goats',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Quick Links',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _FooterLink(label: 'Privacy Policy', path: '/privacy'),
                  _FooterLink(label: 'Terms of Use', path: '/terms'),
                  _FooterLink(label: 'Contact', path: '/contact'),
                  const SizedBox(height: 24),
                  const Text(
                    'Contact',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Email: info@d86.us',
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                  const Text(
                    'Website: d86.us',
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              )
            else
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(
                              Icons.landscape,
                              color: Color(0xFF2E7D32),
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'M Goat',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Kenyan Marketplace for Goats',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Quick Links',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _FooterLink(label: 'Privacy Policy', path: '/privacy'),
                      _FooterLink(label: 'Terms of Use', path: '/terms'),
                      _FooterLink(label: 'Contact', path: '/contact'),
                    ],
                  ),
                  const SizedBox(width: 48),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Contact',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Email: info@mgoat.co.ke',
                        style: TextStyle(fontSize: 14, color: Colors.white70),
                      ),
                      const Text(
                        'Phone: +254 700 000 000',
                        style: TextStyle(fontSize: 14, color: Colors.white70),
                      ),
                      const Text(
                        'Nairobi, Kenya',
                        style: TextStyle(fontSize: 14, color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
            const SizedBox(height: 24),
            const Divider(color: Colors.white24),
            const SizedBox(height: 16),
            const Center(
              child: Text(
                '© 2026 M Goat. All rights reserved.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  final String label;
  final String path;

  const _FooterLink({required this.label, required this.path});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => context.go(path),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppLayout(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _HeroSection(),
            _WhatIsSection(),
            _HowItWorksSection(),
            _DownloadSection(),
          ],
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF5F5F5),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/hero1.png',
                width: double.infinity,
                height: 350,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 350,
                    color: const Color(0xFF2E7D32).withValues(alpha: 0.1),
                    child: const Icon(
                      Icons.landscape,
                      size: 100,
                      color: Color(0xFF2E7D32),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Healthy goats from verified breeders.',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
Text(
              'Browse healthy goat listings from verified breeders across Kenya. Filter by location, breed, price, and more.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.android, color: Colors.white),
              label: const Text(
                'Download Now',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WhatIsSection extends StatelessWidget {
  const _WhatIsSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        padding: const EdgeInsets.all(48),
        child: Column(
          children: [
            const Text(
              'What is M Goat?',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'M Goat is Kenya\'s premier marketplace for buying and selling goats. '
              'Whether you are a farmer looking to sell your livestock or a buyer seeking '
              'quality goats, M Goat connects you with verified breeders across Kenya.\n\n'
              'Our platform makes buying and selling goats simple and trustworthy. '
              'If you are new to livestock trading, M Goat is the right app for you. '
              'We guide you through the entire process - from browsing trusted listings '
              'to closing a safe deal with confidence.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Wrap(
              spacing: 24,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: [
                _FeatureChip(
                  icon: Icons.check_circle,
                  label: 'Verified Breeders Only',
                ),
                _FeatureChip(
                  icon: Icons.favorite,
                  label: 'Save Favorites',
                ),
                _FeatureChip(
                  icon: Icons.notifications,
                  label: 'New Listings Alerts',
                ),
                _FeatureChip(
                  icon: Icons.chat,
                  label: 'Direct Chat',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FeatureChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF2E7D32).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color(0xFF2E7D32), size: 20),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF1B5E20),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _HowItWorksSection extends StatelessWidget {
  const _HowItWorksSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF5F5F5),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        padding: const EdgeInsets.all(48),
        child: Column(
          children: [
            const Text(
              'How Does It Work?',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20),
              ),
            ),
            const SizedBox(height: 48),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _StepCard(
                    stepNumber: 1,
                    imagePath: 'assets/images/screen1.png',
                    title: 'Browse Listings',
                    description:
                        'Explore healthy goat listings from verified breeders across Kenya. Filter by location, breed, price, and more.',
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: _StepCard(
                    stepNumber: 2,
                    imagePath: 'assets/images/screen2.png',
                    title: 'Connect & Chat',
                    description:
                        'Message sellers directly, ask questions, and negotiate prices securely through our in-app chat.',
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: _StepCard(
                    stepNumber: 3,
                    imagePath: 'assets/images/screen3.png',
                    title: 'Close the Deal',
                    description:
                        'Meet up safely, complete your transaction, and take your new goat home. Leave reviews to help others.',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  final int stepNumber;
  final String imagePath;
  final String title;
  final String description;

  const _StepCard({
    required this.stepNumber,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            color: Color(0xFF2E7D32),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$stepNumber',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            imagePath,
            width: 200,
            height: 280,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 200,
                height: 280,
                color: const Color(0xFF2E7D32).withValues(alpha: 0.1),
                child: const Icon(
                  Icons.phone_android,
                  size: 60,
                  color: Color(0xFF2E7D32),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1B5E20),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _DownloadSection extends StatelessWidget {
  const _DownloadSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        padding: const EdgeInsets.all(48),
        child: Column(
          children: [
            const Text(
              'Ready to Find Your Perfect Goat?',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20),
              ),
            ),
            const SizedBox(height: 16),
Text(
              'Browse healthy goat listings from verified breeders across Kenya. Filter by location, breed, price, and more.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.android, color: Colors.white),
              label: const Text(
                'Download Now',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        padding: const EdgeInsets.all(48),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20),
              ),
            ),
            SizedBox(height: 32),
            _PolicyContent(),
          ],
        ),
      ),
    );
  }
}

class _PolicyContent extends StatelessWidget {
  const _PolicyContent();

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PolicySection(
            title: '1. Introduction',
            content:
                'Welcome to Goat Marketplace ("we," "our," or "us"). We are Design 86 LLC, a company registered in the United States. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application (the "App"). By using the App, you agree to the collection and use of information in accordance with this policy.',
          ),
          _PolicySection(
            title: '2. Information We Collect',
            content:
                'Personal Information: Account Information — When you register, we collect your email address and authentication credentials through Firebase Authentication (Google Sign-In or email/password). Profile Data — You may add a display name to your profile. Listing Information — When you sell goats, we store the listing details including photos, description, price, location, and your user ID.\n\nAutomatically Collected Information: Location Data — With your permission, we collect GPS coordinates to enable location-based features such as sorting listings by distance. Device Information — Basic device information for app functionality.\n\nUser-Generated Content: Listings — Photos, descriptions, pricing, and details you submit. Favorites — Listings you save to your favorites list.',
          ),
          _PolicySection(
            title: '3. How We Use Your Information',
            content:
                'We use your information to: Provide and maintain the App services; Authenticate your account and enable login; Display goat listings and allow browsing; Enable you to create, edit, and manage your own listings; Provide location-based features (distance sorting); Allow you to save favorite listings; Communicate with you regarding your account.',
          ),
          _PolicySection(
            title: '4. Data Sharing and Disclosure',
            content:
                'Service Providers: We use Firebase (Google) as our backend service provider for Authentication (Firebase Authentication), Database (Cloud Firestore), and Image storage (Firebase Storage). These services are operated by Google LLC under their own privacy policies.\n\nImage Upload: Listing images are uploaded to our external server (d86.us) for processing and storage.\n\nLegal Requirements: We may disclose information if required by law or in response to valid requests by public authorities.\n\nNo Sale of Data: We do not sell, rent, or trade your personal information to third parties for marketing purposes.',
          ),
          _PolicySection(
            title: '5. Data Retention',
            content:
                'Your personal data is retained: While Active — As long as your account remains active. Upon Deletion — When you delete your account, your data is removed from our active systems.\n\nTo delete your account, go to Settings > Delete Account within the App. Once deleted, your account, listings, and favorites cannot be recovered.',
          ),
          _PolicySection(
            title: '6. Your Rights',
            content:
                'Access and Control: You can access and review your personal information through your account.\n\nDeletion: You have the right to delete your account and associated data at any time via Settings > Delete Account in the App.\n\nOpt-Out: You can opt out of location services at any time through your device settings.',
          ),
          _PolicySection(
            title: '7. Children\'s Privacy',
            content:
                'The App is not intended for users under 18 years of age. We do not knowingly collect personal information from children under 18. If you become aware that a child has provided us with personal information, please contact us at info@d86.us.',
          ),
          _PolicySection(
            title: '8. Security',
            content:
                'We implement appropriate technical and organizational security measures to protect your personal information, including: Secure authentication via Firebase; Encrypted data transmission (HTTPS); Secure cloud storage.\n\nHowever, no method of transmission over the Internet or electronic storage is 100% secure, and we cannot guarantee absolute security.',
          ),
          _PolicySection(
            title: '9. Third-Party Services',
            content:
                'The App uses the following third-party services, each governed by their own privacy policies: Firebase (Google) — https://firebase.google.com/support/privacy; Google Sign-In — https://policies.google.com/privacy',
          ),
          _PolicySection(
            title: '10. Changes to This Privacy Policy',
            content:
                'We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page and updating the "Last Updated" date.',
          ),
          _PolicySection(
            title: '11. Contact Us',
            content:
                'If you have any questions about this Privacy Policy, please contact us:\n\nDesign 86 LLC\nEmail: info@d86.us\nWebsite: https://d86.us',
          ),
        ],
      ),
    );
  }
}

class _PolicySection extends StatelessWidget {
  final String title;
  final String content;

  const _PolicySection({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B5E20),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[700],
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class TermsOfUsePage extends StatelessWidget {
  const TermsOfUsePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        padding: const EdgeInsets.all(48),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms of Use',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20),
              ),
            ),
            SizedBox(height: 32),
            _TermsContent(),
          ],
        ),
      ),
    );
  }
}

class _TermsContent extends StatelessWidget {
  const _TermsContent();

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TermsSection(
            title: '1. Acceptance of Terms',
            content:
                'By downloading, installing, or using the Goat Marketplace mobile application ("App"), you ("User" or "you") agree to be bound by these Terms of Use ("Terms"). If you do not agree to these Terms, do not use the App.',
          ),
          _TermsSection(
            title: '2. Eligibility',
            content:
                'You must be at least 18 years old to use this App. By using the App, you represent and warrant that you are at least 18 years of age and have the legal capacity to enter into binding agreements.',
          ),
          _TermsSection(
            title: '3. Account Registration',
            content:
                'Account Creation: To use certain features of the App, you must create an account through: Email and password registration; Google Sign-In via your Google account.\n\nAccount Responsibility: You are responsible for maintaining the confidentiality of your account credentials, all activities that occur under your account, and notifying us immediately of any unauthorized use.\n\nAccount Termination: We reserve the right to suspend or terminate your account at any time for any reason, including violation of these Terms.',
          ),
          _TermsSection(
            title: '4. User Conduct',
            content:
                'Prohibited Content and Behavior: You agree NOT to post, list, or sell: Sexual content — Any sexually explicit material, nudity, or adult content; Illegal items — Anything prohibited by applicable law; Animals in distress — Livestock that appears unhealthy, neglected, or illegally obtained; Fraudulent listings — Misleading descriptions, false pricing, or scams; Harassment content — Defamatory, abusive, or threatening material.\n\nProhibited Activities: You will not impersonate any person or entity; engage in any activity that interferes with or disrupts the App; attempt to gain unauthorized access to any part of the App; or use the App for any illegal purpose.',
          ),
          _TermsSection(
            title: '5. Marketplace Transactions',
            content:
                'User-to-User Transactions: Goat Marketplace is a peer-to-peer marketplace. We do not buy, sell, or take ownership of any listings; guarantee the quality, health, or condition of any animal; handle payments between buyers and sellers; or provide mediation or dispute resolution for transactions. Any transaction conducted through the App is solely between the buyer and seller.\n\nTransaction Responsibility: Users are solely responsible for negotiating terms of sale, verifying the health and condition of animals, arranging payment and delivery, and complying with applicable laws regarding animal sales.\n\nNo Warranty: The App is provided "as is" without any warranty regarding the accuracy, reliability, or quality of listings.',
          ),
          _TermsSection(
            title: '6. Listing Rules',
            content:
                'Listing Requirements: When creating a listing, you must provide accurate and complete information; include clear photos of the actual animal; state a clear and honest price; and disclose any known health issues.\n\nListing Ownership: You represent that you have the right to sell any items you list and that your listings do not infringe on any third party\'s rights.',
          ),
          _TermsSection(
            title: '7. Refunds and Disputes',
            content:
                'Refunds are handled at the discretion of individual sellers. We do not process refunds or intervene in payment disputes between buyers and sellers. Any refund requests should be directed to the seller with whom you transacted.',
          ),
          _TermsSection(
            title: '8. Intellectual Property',
            content:
                'All content, features, and functionality of the App are owned by Design 86 LLC and are protected by copyright, trademark, and other intellectual property laws.',
          ),
          _TermsSection(
            title: '9. Limitation of Liability',
            content:
                'To the maximum extent permitted by law: The App is provided "as is" and "as available"; We do not guarantee the App will be uninterrupted, secure, or error-free; We are not responsible for any loss or damage resulting from transactions between users, the accuracy of listing information, the health or condition of any animal, or any interaction outside the App.\n\nIn no event shall Design 86 LLC be liable for any indirect, incidental, special, consequential, or punitive damages, regardless of the cause of action or whether we have been advised of the possibility of such damages.',
          ),
          _TermsSection(
            title: '10. Indemnification',
            content:
                'You agree to indemnify, defend, and hold harmless Design 86 LLC and its officers, directors, employees, and agents from any claims, damages, losses, liabilities, costs, or expenses arising out of: your use of the App; your violation of these Terms; your violation of any rights of another party; or your listings or content.',
          ),
          _TermsSection(
            title: '11. Dispute Resolution',
            content:
                'Binding Arbitration: Any dispute, claim, or controversy arising out of or relating to these Terms or the App shall be resolved by binding arbitration administered by the American Arbitration Association under its Commercial Arbitration Rules.\n\nArbitration Location: The arbitration shall take place in the United States, and the arbitration shall be conducted in English.\n\nException: Despite the above, we may seek injunctive or other equitable relief in any court of competent jurisdiction for intellectual property violations.\n\nClass Action Waiver: You agree that any arbitration shall be conducted on an individual basis only — not as a class, consolidated, or representative action.',
          ),
          _TermsSection(
            title: '12. Governing Law',
            content:
                'These Terms shall be governed by and construed in accordance with the laws of the United States and the State of Delaware, without regard to conflict of law provisions.',
          ),
          _TermsSection(
            title: '13. Changes to Terms',
            content:
                'We may modify these Terms at any time. Continued use of the App after modifications constitutes acceptance of the updated Terms.',
          ),
          _TermsSection(
            title: '14. Severability',
            content:
                'If any provision of these Terms is found to be unenforceable, the remaining provisions shall remain in full force and effect.',
          ),
          _TermsSection(
            title: '15. Contact Us',
            content:
                'If you have questions about these Terms, please contact us:\n\nDesign 86 LLC\nEmail: info@d86.us\nWebsite: https://d86.us',
          ),
        ],
      ),
    );
  }
}

class _TermsSection extends StatelessWidget {
  final String title;
  final String content;

  const _TermsSection({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B5E20),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[700],
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        padding: const EdgeInsets.all(48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Get in Touch',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1B5E20),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Have questions about M Goat? We\'d love to hear from you!',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 24),
                      _ContactInfo(
                        icon: Icons.email,
                        title: 'Email',
                        value: 'info@d86.us',
                      ),
                      const SizedBox(height: 16),
                      _ContactInfo(
                        icon: Icons.language,
                        title: 'Website',
                        value: 'd86.us',
                      ),
                      const SizedBox(height: 16),
                      _ContactInfo(
                        icon: Icons.business,
                        title: 'Company',
                        value: 'Design 86 LLC',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Send us a Message',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1B5E20),
                          ),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Your Name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Message',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 4,
                        ),
                        SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2E7D32),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: Text(
                              'Send Message',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactInfo extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _ContactInfo({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF2E7D32).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFF2E7D32)),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1B5E20),
              ),
            ),
          ],
        ),
      ],
    );
  }
}