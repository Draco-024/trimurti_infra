import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart'; // ✅ IMPORTED
import 'package:trimurti_infra/main.dart'; 

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _addressCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load current values
    if (userNameNotifier.value == "Guest User") {
      _nameCtrl.text = "";
      _phoneCtrl.text = "";
      _addressCtrl.text = "";
    } else {
      _nameCtrl.text = userNameNotifier.value;
      _phoneCtrl.text = userPhoneNotifier.value;
      _addressCtrl.text = userAddressNotifier.value;
    }
  }

  // ✅ FIX: Save to Phone Storage
  Future<void> _saveProfile() async {
    if (_nameCtrl.text.isEmpty || _addressCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Name and Address are required!"), backgroundColor: Colors.redAccent)
      );
      return;
    }

    // 1. Update State (Immediate)
    userNameNotifier.value = _nameCtrl.text;
    userPhoneNotifier.value = _phoneCtrl.text.isEmpty ? "+91 00000 00000" : _phoneCtrl.text;
    userAddressNotifier.value = _addressCtrl.text;

    // 2. Save to Storage (Persistent)
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', userNameNotifier.value);
    await prefs.setString('userPhone', userPhoneNotifier.value);
    await prefs.setString('userAddress', userAddressNotifier.value);
    
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profile Saved Successfully!"), backgroundColor: Colors.green)
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: colorScheme.primaryContainer,
                child: Text(
                  _nameCtrl.text.isNotEmpty ? _nameCtrl.text[0].toUpperCase() : "U", 
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: colorScheme.primary)
                ),
              ),
            ),
            const SizedBox(height: 30),
            
            _buildField("Your Name", Icons.person, _nameCtrl),
            const SizedBox(height: 15),
            _buildField("Your Phone Number", Icons.phone, _phoneCtrl, isNumber: true),
            const SizedBox(height: 15),
            _buildField("Your Address (Required)", Icons.location_on, _addressCtrl),
            
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: FilledButton.icon(
                onPressed: _saveProfile, // Calls new async function
                icon: const Icon(Icons.save),
                label: const Text("SAVE CHANGES"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, IconData icon, TextEditingController ctrl, {bool isNumber = false}) {
    return TextField(
      controller: ctrl,
      keyboardType: isNumber ? TextInputType.phone : TextInputType.text,
      onChanged: (val) {
        setState(() {}); // Update Avatar letter
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}