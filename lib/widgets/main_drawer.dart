import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart'; 
import 'package:trimurti_infra/main.dart'; 
import 'package:trimurti_infra/screens/profile_screen.dart'; 
import 'package:trimurti_infra/screens/about_screen.dart'; 

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      backgroundColor: colorScheme.surface,
      child: ValueListenableBuilder<String>(
        valueListenable: languageNotifier,
        builder: (context, currentLang, _) {
          return ListView(
            padding: EdgeInsets.zero, 
            children: [
              // 1. DYNAMIC USER HEADER
              ValueListenableBuilder<String>(
                valueListenable: userNameNotifier,
                builder: (context, name, _) {
                  return ValueListenableBuilder<String>(
                    valueListenable: userPhoneNotifier,
                    builder: (context, phone, _) {
                      return UserAccountsDrawerHeader(
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          image: const DecorationImage(
                            image: NetworkImage("https://www.transparenttextures.com/patterns/cubes.png"),
                            opacity: 0.1,
                            fit: BoxFit.cover
                          ),
                        ),
                        margin: EdgeInsets.zero,
                        accountName: Text(
                          name, 
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)
                        ),
                        accountEmail: Text(phone, style: const TextStyle(color: Colors.white70)),
                        currentAccountPicture: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
                          },
                          child: CircleAvatar(
                            backgroundColor: isDark ? Colors.grey[800] : Colors.white,
                            child: Text(
                              name.isNotEmpty ? name[0].toUpperCase() : "U", 
                              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: colorScheme.primary)
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),

              // ... REST OF THE DRAWER ...
              ListTile(
                leading: Icon(Icons.person_outline, color: colorScheme.primary),
                title: Text(t('edit_profile'), style: GoogleFonts.montserrat()),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.verified_user_outlined, color: Colors.orange),
                title: Text(t('about_founder'), style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
                subtitle: Text(t('founder_sub'), style: const TextStyle(fontSize: 10, color: Colors.grey)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutScreen()));
                },
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.language, color: colorScheme.secondary),
                title: Text(t('language'), style: GoogleFonts.montserrat()),
                trailing: DropdownButton<String>(
                  value: currentLang,
                  dropdownColor: colorScheme.surfaceContainerHigh,
                  underline: const SizedBox(),
                  items: const [
                    DropdownMenuItem(value: 'en', child: Text("English")),
                    DropdownMenuItem(value: 'mr', child: Text("मराठी")),
                  ],
                  onChanged: (val) {
                    if (val != null) languageNotifier.value = val;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Text(t('theme'), style: TextStyle(color: colorScheme.outline, fontSize: 12)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Wrap(
                  spacing: 15,
                  children: [
                    _colorDot(const Color(0xFF1A237E), context),
                    _colorDot(const Color(0xFF2E7D32), context),
                    _colorDot(const Color(0xFFC62828), context),
                    _colorDot(Colors.orange.shade800, context),
                  ],
                ),
              ),
              const Divider(),
              SwitchListTile(
                title: Text(t('dark_mode'), style: GoogleFonts.montserrat()),
                secondary: Icon(isDark ? Icons.dark_mode : Icons.light_mode, color: colorScheme.onSurface),
                value: isDark,
                onChanged: (val) {
                  themeModeNotifier.value = val ? ThemeMode.dark : ThemeMode.light;
                },
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 10, bottom: 5),
                child: Text(t('contact_header'), style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              ListTile(
                leading: const Icon(Icons.call, color: Colors.green),
                title: Text(t('call_us'), style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
                subtitle: const Text("+91 87880 17458"),
                onTap: () async {
                  final Uri url = Uri.parse("tel:+918788017458");
                  if (!await launchUrl(url)) {}
                },
              ),
              ListTile(
                leading: const Icon(Icons.email, color: Colors.blueAccent),
                title: Text(t('mail_us'), style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
                subtitle: const Text("vishalmore9192@gmail.com"),
                onTap: () async {
                  final Uri url = Uri.parse("mailto:vishalmore9192@gmail.com");
                  if (!await launchUrl(url)) {}
                },
              ),
            ],
          );
        }
      ),
    );
  }

  Widget _colorDot(Color color, BuildContext context) {
    return GestureDetector(
      onTap: () => seedColorNotifier.value = color,
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.transparent, 
            width: 2
          ),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, 2))
          ]
        ),
      ),
    );
  }
}