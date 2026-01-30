import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/main_drawer.dart';
import '../main.dart';
import 'enquiry_screen.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final List<Map<String, dynamic>> services = [
      {
        'title': 'Structural Design', 
        'icon': Icons.architecture, 
        'short': 'Analyzed with ETABS & SAFE',
        'desc': 'Professional structural analysis for high-rise and commercial buildings using ETABS and SAFE. We ensure safety, stability, and economy in steel and RCC structures.'
      },
      {
        'title': 'Deep Foundations', 
        'icon': Icons.foundation, // Using foundation icon if available or nearest match
        'short': 'Pile & Raft Foundations',
        'desc': 'Specialized design for Deep Foundations (Pile) and Shallow Foundations to transfer heavy loads safely to deeper soil layers. Optimized for weak soils.'
      },
      {
        'title': '2D Floor Plan', 
        'icon': Icons.grid_on, 
        'short': 'AutoCAD Drafting',
        'desc': 'Precision 2D drafting using AutoCAD. We provide furniture layouts, door-window schedules, and municipal submission drawings.'
      },
      {
        'title': '3D Elevation', 
        'icon': Icons.view_in_ar, 
        'short': 'Realistic exterior views',
        'desc': 'High-quality 3D renders showing exactly how your building will look. Includes day/night views, color combinations, and material selection.'
      },
      {
        'title': 'Vastu Consultation', 
        'icon': Icons.compass_calibration, 
        'short': 'Scientific Vastu compliance',
        'desc': 'Ensure prosperity and peace. We align your kitchen, master bedroom, and entrance according to ancient Vastu Shastra principles.'
      },
      {
        'title': 'Submission Drawings', 
        'icon': Icons.description, 
        'short': 'Govt. Approval Drawings',
        'desc': 'Technical drawings required for municipal corporation or gram panchayat approvals, adhering to all local bylaws.'
      },
    ];

    return Scaffold(
      appBar: AppBar(title: Text(t('services'), style: GoogleFonts.montserrat(fontWeight: FontWeight.bold))),
      drawer: const MainDrawer(),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: colorScheme.outline.withOpacity(0.1)),
            ),
            color: colorScheme.surfaceContainerLow,
            margin: const EdgeInsets.only(bottom: 12),
            child: ExpansionTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: colorScheme.primaryContainer, borderRadius: BorderRadius.circular(12)),
                child: Icon(service['icon'], color: colorScheme.onPrimaryContainer),
              ),
              title: Text(service['title'], style: GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
              subtitle: Text(service['short'], style: GoogleFonts.lato(fontSize: 12)),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(),
                      Text(service['desc'], style: GoogleFonts.lato(height: 1.5, color: colorScheme.onSurfaceVariant)),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.tonal(
                          onPressed: () => Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => EnquiryScreen(initialService: service['title']))
                          ),
                          child: const Text("Book This Service"),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}