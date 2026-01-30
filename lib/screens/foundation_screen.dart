import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FoundationScreen extends StatelessWidget {
  const FoundationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: Text("Foundation Design", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold))),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Info Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: isDark ? colorScheme.surfaceContainerHigh : Colors.teal.shade50,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: isDark ? Colors.transparent : Colors.teal.shade100),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.psychology, color: isDark ? colorScheme.primary : Colors.teal, size: 40),
                      const SizedBox(height: 15),
                      Text("Expertise in SAFE Software", 
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 18, color: isDark ? colorScheme.onSurface : Colors.teal)),
                      const SizedBox(height: 10),
                      Text(
                        "Specialized design for Deep Foundations (Pile) and Shallow Foundations to transfer heavy loads safely.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(height: 1.5, fontSize: 14, color: colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 35),

                _foundationType(
                  context,
                  "Deep Foundations (Pile)",
                  "Designed for weak soil. Bored and driven pile calculations.",
                  Icons.align_vertical_bottom,
                ),
                _foundationType(
                  context,
                  "Raft / Mat Foundation",
                  "Ideal for high-rise buildings to reduce differential settlement.",
                  Icons.grid_4x4,
                ),
                _foundationType(
                  context,
                  "Combined & Isolated",
                  "Optimized sizing for standard residential structures.",
                  Icons.check_box_outline_blank,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _foundationType(BuildContext context, String title, String desc, IconData icon) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainer,
              shape: BoxShape.circle,
              border: Border.all(color: colorScheme.outline.withOpacity(0.1)),
            ),
            child: Icon(icon, size: 30, color: colorScheme.primary),
          ),
          const SizedBox(height: 12),
          Text(title, style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 16, color: colorScheme.onSurface)),
          const SizedBox(height: 5),
          Text(desc, textAlign: TextAlign.center, style: GoogleFonts.lato(color: colorScheme.onSurfaceVariant, height: 1.4)),
        ],
      ),
    );
  }
}