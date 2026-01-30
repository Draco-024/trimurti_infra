import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SkillsScreen extends StatelessWidget {
  const SkillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text("Skills & Tools", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold))),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _sectionHeader("Analysis & Design", colorScheme),
                _skillBar(context, "ETABS (High Rise)", 0.95),
                _skillBar(context, "SAFE (Foundation)", 0.90),
                _skillBar(context, "STAAD.Pro", 0.85),
                
                const SizedBox(height: 40),
                _sectionHeader("Drafting & BIM", colorScheme),
                _skillBar(context, "AutoCAD (2D/3D)", 0.95),
                _skillBar(context, "Revit Structure", 0.80),
                
                const SizedBox(height: 40),
                _sectionHeader("Office & Management", colorScheme),
                _skillTagWrap(["MS Excel", "PowerPoint", "Report Generation", "Site Coordination"], colorScheme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionHeader(String title, ColorScheme colors) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(title, style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.bold, color: colors.onSurface)),
    );
  }

  Widget _skillBar(BuildContext context, String tool, double level) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(tool, style: GoogleFonts.lato(fontWeight: FontWeight.bold, color: colorScheme.onSurface)),
              Text("${(level * 100).toInt()}%", style: GoogleFonts.lato(color: colorScheme.onSurfaceVariant)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: level,
              backgroundColor: colorScheme.surfaceContainerHighest,
              color: colorScheme.primary,
              minHeight: 10,
            ),
          )
        ],
      ),
    );
  }

  Widget _skillTagWrap(List<String> tags, ColorScheme colors) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: tags.map((tag) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: colors.surfaceContainer,
          border: Border.all(color: colors.outline.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(tag, style: GoogleFonts.lato(fontWeight: FontWeight.w600, color: colors.onSurface)),
      )).toList(),
    );
  }
}