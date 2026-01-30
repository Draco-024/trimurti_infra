import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:trimurti_infra/screens/splash_screen.dart';
import 'package:trimurti_infra/screens/home_screen.dart';
import 'package:trimurti_infra/screens/services_screen.dart';
import 'package:trimurti_infra/screens/portfolio_screen.dart';
import 'package:trimurti_infra/screens/enquiry_screen.dart';

// --- GLOBAL STATE ---
final ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier(ThemeMode.light);
final ValueNotifier<Color> seedColorNotifier = ValueNotifier(const Color(0xFF1A237E)); 
final ValueNotifier<String> languageNotifier = ValueNotifier('en');

// --- USER DATA ---
final ValueNotifier<String> userNameNotifier = ValueNotifier("Guest User");
final ValueNotifier<String> userPhoneNotifier = ValueNotifier("+91 00000 00000");
final ValueNotifier<String> userAddressNotifier = ValueNotifier("Solapur, Maharashtra");
// (Image Logic Removed as requested)
final ValueNotifier<String?> userProfilePicNotifier = ValueNotifier(null); 

final Map<String, Map<String, String>> translations = {
  'en': {
    'home': 'Home', 'services': 'Services', 'portfolio': 'Portfolio', 'enquiry': 'Enquiry', 'rates': 'Rate Card',
    'edit_profile': 'Edit Your Profile', 'about_founder': 'About Founder', 'founder_sub': 'Vishal More (B.Tech Infra)',
    'contact_header': 'CONTACT US', 'call_us': 'Call for Consultation', 'mail_us': 'Mail Us',
    'language': 'Language', 'theme': 'Theme Color', 'dark_mode': 'Dark Mode',
    'cat_all': 'All', 'cat_res': 'Residential', 'cat_com': 'Commercial', 'cat_tech': 'Technical',
    'why_us': 'Why Choose Trimurti?', 'feat_proj': 'Featured Projects',
  },
  'mr': {
    'home': 'होम', 'services': 'सेवा', 'portfolio': 'कामे', 'enquiry': 'चौकशी', 'rates': 'दरपत्रक',
    'edit_profile': 'प्रोफाइल संपादित करा', 'about_founder': 'संस्थापकाबद्दल', 'founder_sub': 'विशाल मोरे (B.Tech Infra)',
    'contact_header': 'संपर्क साधा', 'call_us': 'सल्ल्यासाठी कॉल करा', 'mail_us': 'आम्हाला मेल करा',
    'language': 'भाषा', 'theme': 'थीम रंग', 'dark_mode': 'डार्क मोड',
    'cat_all': 'सर्व', 'cat_res': 'निवासी', 'cat_com': 'व्यावसायिक', 'cat_tech': 'तांत्रिक',
    'why_us': 'त्रिमूर्ती का निवडावी?', 'feat_proj': 'निवडक प्रकल्प',
  }
};

String t(String key) {
  return translations[languageNotifier.value]?[key] ?? key;
}

void main() {
  runApp(const TrimurtiApp());
}

class TrimurtiApp extends StatelessWidget {
  const TrimurtiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (context, currentMode, _) {
        return ValueListenableBuilder<Color>(
          valueListenable: seedColorNotifier,
          builder: (context, seedColor, _) {
            return ValueListenableBuilder<String>(
              valueListenable: languageNotifier, 
              builder: (context, lang, _) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Trimurti Infrastructure',
                  theme: ThemeData(
                    useMaterial3: true,
                    brightness: Brightness.light,
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: seedColor, 
                      brightness: Brightness.light,
                      surface: const Color(0xFFF5F7FA),
                    ),
                    scaffoldBackgroundColor: const Color(0xFFF5F7FA),
                    appBarTheme: const AppBarTheme(
                      backgroundColor: Colors.transparent,
                      surfaceTintColor: Colors.transparent,
                      elevation: 0,
                    ),
                    textTheme: GoogleFonts.montserratTextTheme(),
                  ),
                  darkTheme: ThemeData(
                    useMaterial3: true,
                    brightness: Brightness.dark,
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: seedColor, 
                      brightness: Brightness.dark,
                      surface: const Color(0xFF121212),
                    ),
                    scaffoldBackgroundColor: const Color(0xFF121212),
                    textTheme: GoogleFonts.montserratTextTheme(ThemeData.dark().textTheme),
                  ),
                  themeMode: currentMode,
                  home: const SplashScreen(), 
                );
              },
            );
          },
        );
      },
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final List<Widget> screens = [
      const HomeScreen(), 
      const ServicesScreen(),
      const PortfolioScreen(),
      const EnquiryScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20)],
        ),
        child: ValueListenableBuilder<String>(
          valueListenable: languageNotifier,
          builder: (context, lang, _) {
            return NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (index) => setState(() => _selectedIndex = index),
              backgroundColor: Theme.of(context).colorScheme.surface,
              elevation: 0,
              indicatorColor: colorScheme.primary.withOpacity(0.1),
              destinations: [
                NavigationDestination(
                  icon: const Icon(Icons.home_outlined), 
                  selectedIcon: Icon(Icons.home, color: colorScheme.primary), 
                  label: t('home')
                ),
                NavigationDestination(
                  icon: const Icon(Icons.design_services_outlined), 
                  selectedIcon: Icon(Icons.design_services, color: colorScheme.primary), 
                  label: t('services')
                ),
                NavigationDestination(
                  icon: const Icon(Icons.photo_library_outlined), 
                  selectedIcon: Icon(Icons.photo_library, color: colorScheme.primary), 
                  label: t('portfolio')
                ),
                NavigationDestination(
                  icon: const Icon(Icons.support_agent_outlined), 
                  selectedIcon: Icon(Icons.support_agent, color: colorScheme.primary), 
                  label: t('enquiry')
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}