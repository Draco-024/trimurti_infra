import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trimurti_infra/main.dart'; 

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  String _selectedCat = 'cat_all'; 

  final List<Map<String, dynamic>> _allProjects = [
    // --- RESIDENTIAL (Your Work) ---
    {'img': 'assets/images/chari_front.png', 'cat': 'cat_res', 'title': '10 Chari (Front View)', 'isAsset': true},
    {'img': 'assets/images/chari_3d.png', 'cat': 'cat_res', 'title': '10 Chari (3D Model)', 'isAsset': true},
    {'img': 'assets/images/kadapa_3d.png', 'cat': 'cat_res', 'title': 'Kadapa G+3 (3D STAAD)', 'isAsset': true},
    {'img': 'assets/images/kadapa_plan.png', 'cat': 'cat_res', 'title': 'Kadapa (Layout Plan)', 'isAsset': true},
    {'img': 'assets/images/g4_plan.png', 'cat': 'cat_res', 'title': 'G+4 Apt (Plan)', 'isAsset': true},
    
    // --- RESIDENTIAL (Premium / Concepts) ---
    {'img': 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=600', 'cat': 'cat_res', 'title': 'Luxury Villa Concept', 'isAsset': false},
    {'img': 'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=600', 'cat': 'cat_res', 'title': 'Modern Duplex', 'isAsset': false},
    {'img': 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=600', 'cat': 'cat_res', 'title': 'Row House Design', 'isAsset': false},

    // --- COMMERCIAL (Your Work) ---
    {'img': 'assets/images/mumbai_3d.png', 'cat': 'cat_com', 'title': 'Mumbai High-Rise (3D)', 'isAsset': true},
    {'img': 'assets/images/hotel_phil.png', 'cat': 'cat_com', 'title': 'Hotel G+8 (Philosophy)', 'isAsset': true},
    
    // --- COMMERCIAL (Premium / Concepts) ---
    {'img': 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=600', 'cat': 'cat_com', 'title': 'Corporate Hub Design', 'isAsset': false},
    {'img': 'https://images.unsplash.com/photo-1554469384-e58fac16e23a?w=600', 'cat': 'cat_com', 'title': 'Shopping Complex', 'isAsset': false},

    // --- TECHNICAL / STRUCTURAL ---
    {'img': 'assets/images/chari_disp.png', 'cat': 'cat_tech', 'title': 'Chari (Displacement)', 'isAsset': true},
    {'img': 'assets/images/kadapa_bm.png', 'cat': 'cat_tech', 'title': 'Kadapa (Bending Moment)', 'isAsset': true},
    {'img': 'assets/images/g4_torsion.png', 'cat': 'cat_tech', 'title': 'G+4 (Torsion)', 'isAsset': true},
    {'img': 'assets/images/hotel_beam.png', 'cat': 'cat_tech', 'title': 'Hotel (Beam Design)', 'isAsset': true},
    {'img': 'assets/images/hotel_col.png', 'cat': 'cat_tech', 'title': 'Hotel (Column Design)', 'isAsset': true},
    {'img': 'assets/images/mumbai_beam.png', 'cat': 'cat_tech', 'title': 'Mumbai (Beam Detail)', 'isAsset': true},
    {'img': 'assets/images/mumbai_load.png', 'cat': 'cat_tech', 'title': 'Mumbai (Load Apps)', 'isAsset': true},
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> displayProjects = _selectedCat == 'cat_all' 
        ? _allProjects 
        : _allProjects.where((p) => p['cat'] == _selectedCat).toList();

    return Scaffold(
      appBar: AppBar(title: Text(t('portfolio'), style: GoogleFonts.montserrat(fontWeight: FontWeight.bold))),
      body: Column(
        children: [
          // CATEGORY TABS
          SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              children: [
                _catChip('cat_all'),
                const SizedBox(width: 10),
                _catChip('cat_res'),
                const SizedBox(width: 10),
                _catChip('cat_com'),
                const SizedBox(width: 10),
                _catChip('cat_tech'),
              ],
            ),
          ),

          // GRID
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 0.8,
              ),
              itemCount: displayProjects.length,
              itemBuilder: (context, index) {
                final project = displayProjects[index];
                bool isAsset = project['isAsset'] as bool;

                // ✅ ANIMATION: Staggered Fade In Up
                return _FadeInUp(
                  delay: index * 50, // 50ms delay per item
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20), 
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        // LOGIC FOR ASSET VS NETWORK IMAGE
                        isAsset
                        ? Image.asset(
                            project['img']!, 
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey.shade300, child: const Icon(Icons.broken_image, color: Colors.grey)),
                          )
                        : Image.network(
                            project['img']!, 
                            fit: BoxFit.cover,
                            loadingBuilder: (ctx, child, progress) {
                              if (progress == null) return child;
                              return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor, strokeWidth: 2));
                            },
                            errorBuilder: (ctx, _, __) => Container(color: Colors.grey.shade300, child: const Center(child: Icon(Icons.wifi_off, color: Colors.grey))),
                          ),
                        
                        // TITLE OVERLAY
                        Positioned(
                          bottom: 0, left: 0, right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [Colors.black.withOpacity(0.9), Colors.transparent],
                              ),
                            ),
                            child: Text(
                              project['title']!, 
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _catChip(String key) {
    bool isSelected = _selectedCat == key;
    return FilterChip(
      label: Text(t(key)),
      selected: isSelected,
      onSelected: (bool selected) {
        setState(() {
          _selectedCat = key;
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.transparent,
      selectedColor: Theme.of(context).colorScheme.primaryContainer,
    );
  }
}

// ✅ HELPER: Staggered Animation Wrapper
class _FadeInUp extends StatefulWidget {
  final Widget child;
  final int delay;
  const _FadeInUp({required this.child, required this.delay});

  @override
  State<_FadeInUp> createState() => _FadeInUpState();
}

class _FadeInUpState extends State<_FadeInUp> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _fade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _slide = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if(mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}