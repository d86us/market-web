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
                'Welcome to M Goat. We are committed to protecting your privacy and ensuring you have a positive experience using our mobile application and services. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our platform.',
          ),
          _PolicySection(
            title: '2. Information We Collect',
            content:
                'We collect information you provide directly to us, including your name, email address, phone number, and location when you create an account. We also collect information about your use of the app, including your browsing history, saved favorites, and chat messages with other users.',
          ),
          _PolicySection(
            title: '3. How We Use Your Information',
            content:
                'We use the information we collect to provide, maintain, and improve our services, to communicate with you about your account and our services, to process your transactions, and to comply with legal obligations. We may also use your information to personalize your experience and show you relevant listings.',
          ),
          _PolicySection(
            title: '4. Information Sharing',
            content:
                'We may share your information with other users when you choose to communicate with them through our platform. We may also share information with service providers who assist us in operating our app and conducting our business. We do not sell your personal information to third parties.',
          ),
          _PolicySection(
            title: '5. Data Security',
            content:
                'We implement appropriate technical and organizational measures to protect your personal information against unauthorized access, alteration, disclosure, or destruction. However, no method of transmission over the Internet is completely secure, and we cannot guarantee absolute security.',
          ),
          _PolicySection(
            title: '6. Your Rights',
            content:
                'You have the right to access, update, or delete your personal information at any time. You may also opt out of receiving promotional communications from us. To exercise these rights, please contact us at info@mgoat.co.ke.',
          ),
          _PolicySection(
            title: '7. Changes to This Policy',
            content:
                'We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page and updating the "last updated" date. Your continued use of the app after any changes indicates your acceptance of the new Privacy Policy.',
          ),
          _PolicySection(
            title: '8. Contact Us',
            content:
                'If you have any questions about this Privacy Policy, please contact us at info@mgoat.co.ke or +254 700 000 000.',
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
                'By downloading and using M Goat, you agree to be bound by these Terms of Use. If you do not agree to these terms, please do not use our application. We reserve the right to update these terms at any time, and your continued use of the app constitutes acceptance of any changes.',
          ),
          _TermsSection(
            title: '2. User Accounts',
            content:
                'To use certain features of M Goat, you must create an account. You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account. You agree to provide accurate and complete information when creating your account and to update your information as necessary.',
          ),
          _TermsSection(
            title: '3. User Conduct',
            content:
                'You agree not to use M Goat for any unlawful purpose or in any way that could damage, disable, or impair the app. You will not post false or misleading listings, harass other users, or engage in any activity that violates the rights of others. We reserve the right to remove content and terminate accounts that violate these rules.',
          ),
          _TermsSection(
            title: '4. Listings and Transactions',
            content:
                'Users are solely responsible for the accuracy of their listings. M Goat facilitates connections between buyers and sellers but does not guarantee the quality, health, or description of any goats listed on our platform. All transactions are between the buyer and seller, and M Goat is not a party to any such transaction.',
          ),
          _TermsSection(
            title: '5. Prohibited Listings',
            content:
                'The following types of listings are prohibited on M Goat: listing of goats that are not physically available, misrepresenting the health or age of animals, listing animals in violation of Kenyan law, and any content that is illegal, offensive, or harmful. We reserve the right to remove any listing that violates these guidelines.',
          ),
          _TermsSection(
            title: '6. Intellectual Property',
            content:
                'M Goat and its content, including logos, graphics, and software, are the property of M Goat and are protected by Kenyan and international copyright laws. You may not copy, modify, or distribute our content without our written permission.',
          ),
          _TermsSection(
            title: '7. Limitation of Liability',
            content:
                'M Goat provides the app "as is" without any warranties of any kind. We do not guarantee that the app will be error-free or uninterrupted. In no event shall M Goat be liable for any indirect, incidental, or consequential damages arising from your use of the app.',
          ),
          _TermsSection(
            title: '8. Indemnification',
            content:
                'You agree to indemnify and hold harmless M Goat and its officers, directors, and employees from any claims, damages, or expenses arising from your use of the app or your violation of these Terms of Use.',
          ),
          _TermsSection(
            title: '9. Termination',
            content:
                'We may terminate or suspend your account at any time for any reason, including violation of these Terms of Use. Upon termination, your right to use the app will immediately cease. You may also delete your account at any time through the app settings.',
          ),
          _TermsSection(
            title: '10. Governing Law',
            content:
                'These Terms of Use shall be governed by and construed in accordance with the laws of Kenya. Any disputes arising from these terms shall be subject to the exclusive jurisdiction of the courts of Kenya.',
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
                        value: 'info@mgoat.co.ke',
                      ),
                      const SizedBox(height: 16),
                      _ContactInfo(
                        icon: Icons.phone,
                        title: 'Phone',
                        value: '+254 700 000 000',
                      ),
                      const SizedBox(height: 16),
                      _ContactInfo(
                        icon: Icons.location_on,
                        title: 'Address',
                        value: 'Nairobi, Kenya',
                      ),
                      const SizedBox(height: 16),
                      _ContactInfo(
                        icon: Icons.access_time,
                        title: 'Business Hours',
                        value: 'Mon - Fri: 9AM - 6PM',
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