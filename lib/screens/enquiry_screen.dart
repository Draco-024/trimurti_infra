import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart'; 
import 'package:trimurti_infra/main.dart'; 
import 'package:trimurti_infra/screens/profile_screen.dart'; 

class EnquiryScreen extends StatefulWidget {
  final String? initialService;

  const EnquiryScreen({super.key, this.initialService});

  @override
  State<EnquiryScreen> createState() => _EnquiryScreenState();
}

class _EnquiryScreenState extends State<EnquiryScreen> {
  final List<String> _services = [
    '2D Floor Plan',
    '3D Elevation',
    'Structural Design',
    'Vastu Consultation',
    'Commercial Design',
    'General Enquiry'
  ];
  
  late String _selectedService;
  final TextEditingController _plotDetailsCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialService != null && _services.contains(widget.initialService)) {
      _selectedService = widget.initialService!;
    } else {
      _selectedService = _services[0];
    }
  }

  void _sendToWhatsApp() async {
    // 1. CHECK IF PROFILE IS INCOMPLETE
    if (userNameNotifier.value == "Guest User" || userNameNotifier.value.isEmpty) {
      if (!mounted) return;
      
      // Show Warning
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("⚠️ Profile Incomplete! Redirecting to update...", style: GoogleFonts.montserrat()), 
          backgroundColor: Colors.orange
        ),
      );

      // REDIRECT TO PROFILE SCREEN
      await Future.delayed(const Duration(seconds: 1)); // Small delay for effect
      if (!mounted) return;
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
      return; // STOP HERE
    }

    // 2. VALIDATE INPUT
    String name = userNameNotifier.value;
    String phone = userPhoneNotifier.value;
    String city = userAddressNotifier.value;
    String details = _plotDetailsCtrl.text;

    if (details.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please describe your requirement.", style: GoogleFonts.montserrat()), backgroundColor: Colors.redAccent),
      );
      return;
    }

    // 3. SEND MESSAGE
    String message = 
      "*New Project Enquiry* 🏛️\n"
      "---------------------\n"
      "*Client:* $name\n"
      "*Phone:* $phone\n"
      "*Location:* $city\n"
      "---------------------\n"
      "*Service:* $_selectedService\n"
      "*Requirement:* $details";

    final Uri url = Uri.parse("https://wa.me/918788017458?text=${Uri.encodeComponent(message)}");
    
    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch WhatsApp');
      }
    } catch (e) {
      if (mounted) {
         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Could not open WhatsApp.")));
      }
    }
  }

  void _addQuickText(String text) {
    String current = _plotDetailsCtrl.text;
    if (current.isNotEmpty) {
      _plotDetailsCtrl.text = "$current, $text";
    } else {
      _plotDetailsCtrl.text = text;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    final OutlineInputBorder roundedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30), 
      borderSide: BorderSide(color: Colors.grey.withOpacity(0.5))
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(t('enquiry'), style: GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // NEW: MARATHI NOTE AT TOP
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Text(
                  "मराठीसाठी मेनूमध्ये भाषा बदला",
                  style: GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey[600]),
                ),
              ),
            ),

            // HEADER
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [colorScheme.primary, colorScheme.primary.withOpacity(0.8)],
                  begin: Alignment.topLeft, end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.architecture, size: 32, color: Colors.white),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Start Your Project", style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                        Text("Connect via WhatsApp.", style: GoogleFonts.lato(color: Colors.white70)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 25),

            // INFO CARDS
            _readOnlyCard(context, Icons.person, userNameNotifier.value),
            const SizedBox(height: 10),
            _readOnlyCard(context, Icons.phone, userPhoneNotifier.value),
            
            // WARNING NOTE (Only visible if Guest)
            ValueListenableBuilder<String>(
              valueListenable: userNameNotifier,
              builder: (context, name, _) {
                if (name == "Guest User") {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 10),
                    child: GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen())),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: Colors.red.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            const Icon(Icons.warning_amber, color: Colors.red, size: 20),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "⚠️ Profile Incomplete!\nName & Address are MANDATORY. The button below will redirect you to update profile.",
                                style: GoogleFonts.lato(color: Colors.red[800], fontSize: 11, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),

            const SizedBox(height: 30),

            Text("PROJECT DETAILS", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, color: colorScheme.primary)),
            const SizedBox(height: 10),

            // FORM FIELDS
            DropdownButtonFormField<String>(
              value: _selectedService,
              icon: Icon(Icons.keyboard_arrow_down, color: colorScheme.primary),
              decoration: InputDecoration(
                filled: true,
                fillColor: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFF9FAFB),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                border: roundedBorder,
                enabledBorder: roundedBorder,
                focusedBorder: roundedBorder.copyWith(borderSide: BorderSide(color: colorScheme.primary)),
              ),
              items: _services.map((String value) => DropdownMenuItem(value: value, child: Text(value))).toList(),
              onChanged: (val) => setState(() => _selectedService = val!),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _plotDetailsCtrl,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Plot Size (e.g. 30x40), Facing...",
                filled: true,
                fillColor: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFF9FAFB),
                border: roundedBorder,
                enabledBorder: roundedBorder,
                focusedBorder: roundedBorder.copyWith(borderSide: BorderSide(color: colorScheme.primary)),
                contentPadding: const EdgeInsets.all(20),
              ),
            ),

            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children: [
                _quickChip("Site Visit"),
                _quickChip("30x40 Plot"),
                _quickChip("40x60 Plot"),
                _quickChip("Row House"),
                _quickChip("Shop Design"),
              ],
            ),

            const SizedBox(height: 30),

            // SEND BUTTON (Will Redirect if Guest)
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF25D366),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  elevation: 5,
                ),
                onPressed: _sendToWhatsApp,
                icon: const Icon(Icons.send),
                label: Text("SEND ENQUIRY", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
              ),
            ),
            
            const SizedBox(height: 30),

            // DIRECT CONTACT
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      final Uri url = Uri.parse("tel:+918788017458");
                      if (!await launchUrl(url)) {}
                    },
                    icon: const Icon(Icons.call, color: Colors.green),
                    label: const Text("Call Us"),
                    style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      final Uri url = Uri.parse("mailto:vishalmore9192@gmail.com");
                      if (!await launchUrl(url)) {}
                    },
                    icon: const Icon(Icons.email, color: Colors.blue),
                    label: const Text("Mail Us"),
                    style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _quickChip(String label) {
    return ActionChip(
      label: Text(label, style: const TextStyle(fontSize: 12)),
      onPressed: () => _addQuickText(label),
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }

  Widget _readOnlyCard(BuildContext context, IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh.withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary, size: 20),
          const SizedBox(width: 15),
          Expanded(child: Text(text, style: GoogleFonts.montserrat(fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }
}