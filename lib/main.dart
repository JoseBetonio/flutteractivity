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

  MLHero({
    required this.name,
    required this.role,
    required this.price,
    required this.description,
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
    ),
    MLHero(
      name: "Layla",
      role: "Marksman",
      price: "6,500 BP",
      description:
          "A long-range marksman with strong late-game damage output.",
    ),
    MLHero(
      name: "Tigreal",
      role: "Tank",
      price: "6,500 BP",
      description:
          "A durable tank with strong crowd control and teamfight presence.",
    ),
    MLHero(
      name: "Eudora",
      role: "Mage",
      price: "2,000 BP",
      description:
          "A burst mage capable of stunning and instantly eliminating enemies.",
    ),
    MLHero(
      name: "Gusion",
      role: "Assassin",
      price: "32,000 BP",
      description:
          "A fast and deadly assassin known for high-skill combo gameplay.",
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
        leading: const Icon(Icons.sports_esports),
        backgroundColor: Colors.blueGrey,
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
                    ? const Text("Select a hero to view details")
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedHero!.name,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text("Role: ${selectedHero!.role}"),
                          Text("Price: ${selectedHero!.price}"),
                          const SizedBox(height: 8),
                          Text(selectedHero!.description),
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
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: ListTile(
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
