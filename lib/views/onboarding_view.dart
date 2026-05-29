import 'package:flutter/material.dart';
import 'package:handmade_crafts/views/login_view.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingPage {
  final String tag;
  final String title;
  final String description;
  final Color bgColor;
  final Color accentColor;
  final Color textColor;

  const _OnboardingPage({
    required this.tag,
    required this.title,
    required this.description,
    required this.bgColor,
    required this.accentColor,
    required this.textColor,
  });
}

class _OnboardingViewState extends State<OnboardingView>
    with TickerProviderStateMixin {
  final PageController _controller = PageController();
  int _index = 0;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  static const List<_OnboardingPage> _pages = [
    _OnboardingPage(
      tag: 'Handpicked',
      title: 'Crafted with Love & Soul',
      description:
          'Discover one-of-a-kind handmade pieces from artisans who pour their heart into every creation.',
      bgColor: Color(0xFFFDF6EE),
      accentColor: Color(0xFFB5651D),
      textColor: Color(0xFF5C3A1E),
    ),
    _OnboardingPage(
      tag: 'Artisan Made',
      title: 'Support Local Creators',
      description:
          'Every purchase supports independent makers and keeps traditional crafts alive.',
      bgColor: Color(0xFFF4F0EB),
      accentColor: Color(0xFF7B6B52),
      textColor: Color(0xFF3E2F1C),
    ),
    _OnboardingPage(
      tag: 'Fast Delivery',
      title: 'Wrapped with Care',
      description:
          'Each order is thoughtfully packaged and delivered with love and attention.',
      bgColor: Color(0xFFFEF9F2),
      accentColor: Color(0xFFC17F50),
      textColor: Color(0xFF4A2E14),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnimation =
        CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);
    _fadeController.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void _onPageChanged(int i) {
    _fadeController.reset();
    setState(() => _index = i);
    _fadeController.forward();
  }

  void _goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginView()),
    );
  }

  void _next() {
    if (_index == _pages.length - 1) {
      _goToLogin();
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final page = _pages[_index];
    final isLast = _index == _pages.length - 1;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      color: page.bgColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              /// PAGE VIEW
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _pages.length,
                  onPageChanged: _onPageChanged,
                  itemBuilder: (_, i) {
                    final p = _pages[i];
                    return FadeTransition(
                      opacity: _fadeAnimation,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: p.accentColor.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  p.tag.toUpperCase(),
                                  style: TextStyle(
                                    color: p.accentColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20),

                              Text(
                                p.title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: p.textColor,
                                  height: 1.2,
                                ),
                              ),

                              const SizedBox(height: 20),

                              Container(
                                width: 40,
                                height: 3,
                                color: p.accentColor,
                              ),

                              const SizedBox(height: 20),

                              Text(
                                p.description,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                  height: 1.6,
                                  color: p.textColor.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              /// DOTS + BUTTON
              Padding(
                padding: const EdgeInsets.fromLTRB(28, 0, 28, 36),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _pages.length,
                        (i) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: i == _index ? 28 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: i == _index
                                ? page.accentColor
                                : page.accentColor.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: _next,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: page.accentColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(
                          isLast ? "Start Exploring" : "Continue",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
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