import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text("Notable Projects", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          child: ListView(
            padding: const EdgeInsets.all(20),
            physics: const BouncingScrollPhysics(),
            children: [
              _projectItem(context, "Mumbai High-Rise", "G+26 Commercial Tower", "High-rise commercial building in Mumbai. Structural analysis designed for high wind loads and seismic stability.", Icons.domain),
              _projectItem(context, "10 Chari Project", "G+5 Apartment with Shear Wall", "Residential apartment design incorporating Shear Walls for lateral stability.", Icons.apartment),
              _projectItem(context, "South Kadapa Project", "G+3 Building (ETABS)", "Complete 3D ETABS modeling with Torsion and Displacement checks.", Icons.foundation),
              _projectItem(context, "Hotel Building", "G+8 with Shear Wall", "Analyzed in STAAD.Pro. Includes Bending Moment calculations and detailed Column Design.", Icons.hotel),
              _projectItem(context, "Urban Housing", "G+4 Storey Apartment", "Structural Analysis & Design optimized for cost-efficiency.", Icons.home_work),
              
              const SizedBox(height: 20),
              
              // DESIGN PHILOSOPHY CARD
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark ? colorScheme.surfaceContainerHigh : Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: isDark ? Colors.transparent : Colors.blue.shade100),
                ),
                child: Column(
                  children: [
                    Text("Design Philosophy", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 16, color: colorScheme.onSurface)),
                    const SizedBox(height: 10),
                    Text(
                      "• IS 456 & IS 1893 Compliant\n• Economy without compromising Safety\n• Serviceability checks for Deflection",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(height: 1.6, fontSize: 14, color: colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _projectItem(BuildContext context, String title, String subtitle, String desc, IconData icon) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      color: colorScheme.surfaceContainer, // Dark mode friendly background
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: colorScheme.outline.withOpacity(0.1)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: colorScheme.primary, size: 28),
            ),
            const SizedBox(height: 12),
            Text(title, textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 18, color: colorScheme.onSurface)),
            Text(subtitle, textAlign: TextAlign.center, style: GoogleFonts.lato(color: colorScheme.primary, fontWeight: FontWeight.bold, fontSize: 14)),
            const Divider(height: 25),
            Text(desc, textAlign: TextAlign.center, style: GoogleFonts.lato(color: colorScheme.onSurfaceVariant, height: 1.5)),
          ],
        ),
      ),
    );
  }
}