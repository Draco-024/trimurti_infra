import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart'; 

class RateCardScreen extends StatelessWidget {
  const RateCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    final List<Map<String, String>> rates = [
      {'service': '2D Floor Plan', 'rate': '₹2 - ₹5 / sq.ft'},
      {'service': '3D Elevation', 'rate': '₹3,000 - ₹8,000 (Lump Sum)'},
      {'service': 'Structural Design', 'rate': '₹3 - ₹6 / sq.ft'},
      {'service': 'Vastu Consultation', 'rate': '₹1,000 / Session'},
      {'service': 'Estimation (BOQ)', 'rate': '₹1,500 onwards'},
      {'service': 'Site Supervision', 'rate': '₹500 / Visit'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(t('rates'), style: GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // INFO CARD
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: colorScheme.onPrimaryContainer),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      "Rates are approximate and depend on project complexity.",
                      style: GoogleFonts.lato(color: colorScheme.onPrimaryContainer, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // RATE TABLE
            Container(
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: isDark ? Colors.white10 : Colors.black12),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
                ],
              ),
              child: Column(
                children: rates.asMap().entries.map((entry) {
                  int idx = entry.key;
                  Map<String, String> item = entry.value;
                  bool isLast = idx == rates.length - 1;

                  return Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: isLast ? BorderSide.none : BorderSide(color: isDark ? Colors.white10 : Colors.grey.shade200)),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      title: Text(item['service']!, style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 15)),
                      trailing: Text(item['rate']!, style: GoogleFonts.lato(fontWeight: FontWeight.bold, color: colorScheme.primary)),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 30),
            
            // NOTE FOR VISHAL
            Text(
              "* Note: Please verify final rates with Vishal Sir directly.",
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(color: Colors.redAccent, fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}