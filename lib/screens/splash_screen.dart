import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import '../main.dart'; 

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;
  double _scale = 0.8;

  @override
  void initState() {
    super.initState();
    // Start Animation after small delay
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
        _scale = 1.0;
      });
    });

    // Navigate to Home
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const MainNavigation(),
          transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
          transitionDuration: const Duration(milliseconds: 800),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Deep Navy Blue Background
    const Color bg = Color(0xFF0D47A1); 

    return Scaffold(
      backgroundColor: bg,
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 1500),
          curve: Curves.easeOutExpo,
          transform: Matrix4.identity()..scale(_scale),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 1200),
            opacity: _opacity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Minimal Logo Container
                Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 30, spreadRadius: 5)
                    ],
                  ),
                  child: const Icon(Icons.apartment_rounded, size: 50, color: bg),
                ),
                const SizedBox(height: 30),
                
                // Typography
                Text("TRIMURTI", 
                  style: GoogleFonts.montserrat(
                    fontSize: 32, 
                    fontWeight: FontWeight.bold, 
                    color: Colors.white,
                    letterSpacing: 5
                  )
                ),
                const SizedBox(height: 5),
                Container(
                  width: 50, 
                  height: 2, 
                  color: Colors.white54
                ), // Minimal Divider
                const SizedBox(height: 5),
                Text("INFRASTRUCTURE", 
                  style: GoogleFonts.lato(
                    fontSize: 12, 
                    color: Colors.white70, 
                    letterSpacing: 6
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}