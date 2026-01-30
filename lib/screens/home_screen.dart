import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trimurti_infra/widgets/main_drawer.dart';
import 'package:trimurti_infra/main.dart';
import 'package:trimurti_infra/screens/rate_card_screen.dart';
import 'package:trimurti_infra/screens/projects_screen.dart';
import 'package:trimurti_infra/screens/skills_screen.dart';
import 'package:trimurti_infra/screens/foundation_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => GestureDetector(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ValueListenableBuilder<String>(
                valueListenable: userNameNotifier,
                builder: (context, name, _) {
                  return CircleAvatar(
                    backgroundColor: colorScheme.primary,
                    child: Text(
                      name.isNotEmpty ? name[0].toUpperCase() : "U",
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        title: Text("TRIMURTI", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, letterSpacing: 2)),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RateCardScreen())),
              child: CircleAvatar(
                backgroundColor: colorScheme.surfaceContainerHigh,
                child: Icon(Icons.currency_rupee, color: colorScheme.primary, size: 20),
              ),
            ),
          )
        ],
      ),
      drawer: const MainDrawer(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HERO
            Container(
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [BoxShadow(color: colorScheme.primary.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))],
              ),
              child: Column(
                children: [
                   const Icon(Icons.apartment, size: 50, color: Colors.white),
                   const SizedBox(height: 15),
                   Text("Design. Build. Consult.", style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                   const SizedBox(height: 5),
                   Text("Turning your vision into concrete reality.", style: GoogleFonts.lato(fontSize: 14, color: Colors.white70)),
                ],
              ),
            ),

            // TECHNICAL PORTFOLIO
            Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Text("Technical Portfolio", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 18))),
            const SizedBox(height: 15),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  _techCard(context, "Projects", Icons.business, const ProjectsScreen()),
                  const SizedBox(width: 15),
                  _techCard(context, "Skills", Icons.laptop_mac, const SkillsScreen()),
                  const SizedBox(width: 15),
                  _techCard(context, "Foundation", Icons.grid_on, const FoundationScreen()),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // WHY CHOOSE US
            Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Text(t('why_us'), style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 18))),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  _featureCard(Icons.verified_user, "Trusted", colorScheme),
                  const SizedBox(width: 15),
                  _featureCard(Icons.timer, "On Time", colorScheme),
                  const SizedBox(width: 15),
                  _featureCard(Icons.wallet, "Affordable", colorScheme),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
            
            // FEATURED PROJECTS
             Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Text(t('feat_proj'), style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 18))),
             const SizedBox(height: 15),
             SizedBox(
              height: 200,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                children: [
                  _projectCard(context, "Mumbai High-Rise", "assets/images/mumbai_3d.png", isAsset: true),
                  _projectCard(context, "Luxury Villa", "https://images.unsplash.com/photo-1613977257363-707ba9348227?w=600", isAsset: false),
                  _projectCard(context, "Hotel Structure", "assets/images/hotel_phil.png", isAsset: true),
                  _projectCard(context, "Modern Apt", "assets/images/g4_plan.png", isAsset: true),
                ],
              ),
            ),
            const SizedBox(height: 50),
             
             // FOOTER
             Container(
              width: double.infinity,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(color: Colors.grey[900], borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
              child: Column(
                children: [
                  const Icon(Icons.business, color: Colors.white, size: 40),
                  const SizedBox(height: 20),
                  Text("TRIMURTI INFRASTRUCTURE", style: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18), textAlign: TextAlign.center),
                  const SizedBox(height: 10),
                  Text("Civil Engineering Design & Structural Consultancy", style: GoogleFonts.lato(color: Colors.white70), textAlign: TextAlign.center),
                  const Divider(color: Colors.white24, height: 40),
                  _footerRow(Icons.location_on, "A/P. Chik-Mahud, Tal. Sangola Dist. Solapur"),
                  const SizedBox(height: 15),
                  _footerRow(Icons.email, "vishalmore9192@gmail.com"),
                  const SizedBox(height: 15),
                  _footerRow(Icons.phone, "+91 87880 17458"),
                  const SizedBox(height: 30),
                  Text("© 2024 Trimurti Infra. All Rights Reserved.", style: GoogleFonts.lato(color: Colors.white30, fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _techCard(BuildContext context, String title, IconData icon, Widget screen) {
    final colorScheme = Theme.of(context).colorScheme;
    return Expanded(
      child: GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => screen)),
        child: Container(
          height: 110,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: colorScheme.outline.withOpacity(0.1)),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: colorScheme.primary.withOpacity(0.1), shape: BoxShape.circle),
                child: Icon(icon, color: colorScheme.primary, size: 24),
              ),
              const SizedBox(height: 8),
              Text(title, textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 11, fontWeight: FontWeight.bold, color: colorScheme.onSurface)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _featureCard(IconData icon, String label, ColorScheme colors) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: colors.surfaceContainer, 
          borderRadius: BorderRadius.circular(20), 
          border: Border.all(color: colors.outline.withOpacity(0.1))
        ),
        child: Column(children: [Icon(icon, color: colors.primary), const SizedBox(height: 10), Text(label, style: GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.bold, color: colors.onSurface))]),
      ),
    );
  }

  Widget _projectCard(BuildContext context, String title, String imgPath, {required bool isAsset}) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: 280, margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: colorScheme.surfaceContainer),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Stack(
          children: [
            Positioned.fill(
              child: isAsset 
              ? Image.asset(
                  imgPath, 
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => Container(color: colorScheme.surfaceContainerHighest, child: const Center(child: Icon(Icons.broken_image, color: Colors.grey))),
                )
              : Image.network(
                  imgPath,
                  fit: BoxFit.cover,
                  loadingBuilder: (ctx, child, progress) {
                    if (progress == null) return child;
                    return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor, strokeWidth: 2));
                  },
                  errorBuilder: (c, e, s) => Container(color: colorScheme.surfaceContainerHighest, child: const Center(child: Icon(Icons.broken_image, color: Colors.grey))),
              ),
            ),
            Positioned(
              bottom: 0, left: 0, right: 0,
              child: Container(
                decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: [Colors.black.withOpacity(0.8), Colors.transparent])),
                alignment: Alignment.bottomLeft, padding: const EdgeInsets.all(20),
                child: Text(title, style: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _footerRow(IconData icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.white70, size: 16),
        const SizedBox(width: 10),
        Text(text, style: GoogleFonts.lato(color: Colors.white, fontSize: 13)),
      ],
    );
  }
}