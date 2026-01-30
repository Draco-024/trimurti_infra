import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart'; 

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text("About Founder", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // 1. PROFILE HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  // IMAGE STACK WITH VERIFIED TICK
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 15)]
                        ),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white,
                          // FIXED: Loads .jpg format
                          backgroundImage: const AssetImage('assets/images/vishal_profile.jpg'),
                          onBackgroundImageError: (_, __) {
                            debugPrint("Error loading profile image. Check filename!");
                          },
                        ),
                      ),
                      // THE VERIFIED TICK
                      const CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.verified, color: Colors.blue, size: 24),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // NAME & TITLE
                  Text("Vishal More", style: GoogleFonts.montserrat(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                  Text("Structural Engineer", style: GoogleFonts.lato(color: Colors.white70, fontSize: 16)),
                  
                  const SizedBox(height: 10),
                  
                  // EDUCATION CHIP
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
                    child: Text("B.Tech (Hons) Infra | GATE 2024", style: GoogleFonts.lato(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 30),

            // 2. VISION SECTION
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Text("MY VISION", style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.bold, color: colorScheme.primary)),
                  const SizedBox(height: 10),
                  Text(
                    "To design and build structures that not only stand the test of time but also contribute meaningfully to the communities they serve. I strive to blend safety, innovation, and sustainability.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(fontSize: 14, height: 1.6, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 3. SOFTWARE SKILLS SECTION
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: colorScheme.outline.withOpacity(0.1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.laptop_mac, color: Colors.orange),
                      const SizedBox(width: 10),
                      Text("Technical Expertise", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                  const Divider(height: 30),
                  _skillRow("Structural Analysis", "ETABS, SAFE, STAAD.Pro"),
                  _skillRow("Drafting & BIM", "AutoCAD (Expert), Revit"),
                  _skillRow("Management", "MS Excel, PowerPoint"),
                  _skillRow("Specialization", "High-Rise & Foundation Design"),
                ],
              ),
            ),

            const SizedBox(height: 40),
            
            // 4. CONTACT BUTTON
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton.icon(
                  onPressed: () async {
                    final Uri url = Uri.parse("tel:+918788017458");
                    if (!await launchUrl(url)) {}
                  },
                  icon: const Icon(Icons.call),
                  label: const Text("Contact for Collaboration"),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _skillRow(String title, String tools) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, size: 18, color: Colors.blue.shade700),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 14)),
                Text(tools, style: GoogleFonts.lato(color: Colors.grey[600], fontSize: 13)),
              ],
            ),
          )
        ],
      ),
    );
  }
}