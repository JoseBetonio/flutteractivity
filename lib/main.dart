import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// MODEL CLASS
class MLHero {
  final String name;
  final String role;
  final String price;
  final String description;
  final String image;

  MLHero({
    required this.name,
    required this.role,
    required this.price,
    required this.description,
    required this.image,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mobile Legends Heroes',
      home: const HeroListPage(),
    );
  }
}

class HeroListPage extends StatefulWidget {
  const HeroListPage({super.key});

  @override
  State<HeroListPage> createState() => _HeroListPageState();
}

class _HeroListPageState extends State<HeroListPage> {
  /// SAMPLE HERO DATA
  final List<MLHero> heroes = [
    MLHero(
      name: "Alucard",
      role: "Fighter / Assassin",
      price: "32,000 BP",
      description:
          "A lifesteal-based hero who excels in close combat and chasing enemies.",
      image: "assets/images/alucard.jpg",
    ),
    MLHero(
      name: "Layla",
      role: "Marksman",
      price: "6,500 BP",
      description:
          "A long-range marksman with strong late-game damage output.",
      image: "assets/images/layla.jpg",
    ),
    MLHero(
      name: "Tigreal",
      role: "Tank",
      price: "6,500 BP",
      description:
          "A durable tank with strong crowd control and teamfight presence.",
      image: "assets/images/tigreal.jpg",
    ),
    MLHero(
      name: "Eudora",
      role: "Mage",
      price: "2,000 BP",
      description:
          "A burst mage capable of stunning and instantly eliminating enemies.",
      image: "assets/images/eudora.jpg",
    ),
    MLHero(
      name: "Gusion",
      role: "Assassin",
      price: "32,000 BP",
      description:
          "A fast and deadly assassin known for high-skill combo gameplay.",
      image: "assets/images/gusion.jpg",
    ),
  ];

  MLHero? selectedHero;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    selectedHero = heroes.first; // Pre-select first hero
  }

  /// HANDLE HERO SELECTION WITH DELAY
  void selectHero(MLHero hero) async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      selectedHero = hero;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mobile Legends Heroes"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
      /// TOP SECTION - SELECTED HERO DETAILS
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        color: Colors.grey.shade200,
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : selectedHero == null
                // Kept centered from previous step
                ? const Center(child: Text("Select a hero to view details"))
                : Column(
                    // Kept centered from previous step
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        // --- CHANGE START ---
                        // Replaced ClipRRect with CircleAvatar
                        child: CircleAvatar(
                          // Radius should be half the desired diameter.
                          // Previous height was 160, so radius is 80.
                          radius: 80,
                          backgroundImage: AssetImage(selectedHero!.image),
                          // Optional: add a background color in case image has transparent parts or fails to load
                          backgroundColor: Colors.grey.shade400,
                        ),
                        // --- CHANGE END ---
                      ),
                      const SizedBox(height: 12),
                      Text(
                        selectedHero!.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Role: ${selectedHero!.role}",
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Price: ${selectedHero!.price}",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        selectedHero!.description,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
      ),

          /// BOTTOM SECTION - HERO LIST
          Expanded(
            child: ListView.builder(
              itemCount: heroes.length,
              itemBuilder: (context, index) {
                final hero = heroes[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        hero.image,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(hero.name),
                    subtitle: Text(hero.role),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () => selectHero(hero),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
