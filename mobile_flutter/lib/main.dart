import 'package:flutter/material.dart';

void main() {
  runApp(const VEduMatchApp());
}

class AppColors {
  static const background = Color(0xFF0E1110);
  static const surface = Color(0xFF171B19);
  static const surfaceLight = Color(0xFF222825);
  static const gold = Color(0xFFFFC928);
  static const goldDark = Color(0xFFE4A914);
  static const textPrimary = Color(0xFFF8F6EE);
  static const textSecondary = Color(0xFFB8B9B4);
  static const border = Color(0xFF343A36);
}

class VEduMatchApp extends StatelessWidget {
  const VEduMatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'V-EduMatch',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: 'Arial',
      ),
      home: const WelcomePage(),
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  void showInfo(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.surfaceLight,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 20,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 40,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),

                      // Logo sementara.
                      Center(
                        child: Container(
                          width: 92,
                          height: 92,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFFFD445),
                                Color(0xFFE3A514),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'V',
                              style: TextStyle(
                                color: AppColors.background,
                                fontSize: 48,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 26),

                      const Center(
                        child: Text(
                          'V-EduMatch',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w800,
                            fontSize: 32,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Center(
                        child: Text(
                          'Virtual Exhibition & AI Matchmaking',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 15,
                          ),
                        ),
                      ),

                      const Spacer(),

                      const Text(
                        'Jelajahi karya,\ntemukan inspirasi.',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w800,
                          fontSize: 32,
                          height: 1.15,
                        ),
                      ),

                      const SizedBox(height: 12),

                      const Text(
                        'Temukan karya mahasiswa dan kreator melalui '
                        'pameran digital yang interaktif.',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 38),

                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed: () {
                            showInfo(
                              context,
                              'Halaman login akan dibuat setelah UI dasar selesai.',
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.gold,
                            foregroundColor: AppColors.background,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            'Masuk',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: OutlinedButton(
                          onPressed: () {
                            showInfo(
                              context,
                              'Halaman pendaftaran akan dibuat setelah UI dasar selesai.',
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.textPrimary,
                            side: const BorderSide(
                              color: AppColors.border,
                              width: 1.3,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            'Daftar',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePreviewPage(),
                              ),
                            );
                          },
                          child: const Text(
                            'Lihat Pameran Tanpa Akun  →',
                            style: TextStyle(
                              color: AppColors.gold,
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class HomePreviewPage extends StatefulWidget {
  const HomePreviewPage({super.key});

  @override
  State<HomePreviewPage> createState() => _HomePreviewPageState();
}

class _HomePreviewPageState extends State<HomePreviewPage> {
  int selectedMenu = 0;

  final List<String> menuLabels = [
    'Beranda',
    'Eksplor',
    'Ruang 3D',
    'Profil',
  ];

  void showGuestMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Silakan masuk atau daftar untuk memakai fitur ini.'),
        backgroundColor: AppColors.surfaceLight,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Pameran Aktif',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'PBL Expo 2026',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 22),

                    InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ExplorePage(
                              openSearch: true,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 52,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.search_rounded,
                              color: AppColors.textSecondary,
                            ),
                            SizedBox(width: 12),
                            Text(
                              'Cari karya, tag, teknologi...',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF2A2412),
                            Color(0xFF151916),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: const Color(0xFF4A4020),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.view_in_ar_rounded,
                            color: AppColors.gold,
                            size: 34,
                          ),
                          const SizedBox(height: 14),
                          const Text(
                            'Jelajahi Ruang Karya 3D',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 23,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Ruang pameran berdasarkan prodi',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 18),
                          SizedBox(
                            height: 46,
                            child: ElevatedButton(
                              onPressed: () {
                                showGuestMessage();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.gold,
                                foregroundColor: AppColors.background,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: const Text(
                                'Masuk Ruang 3D',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    const Text(
                      'Rekomendasi untukmu',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 14),

                    const WorkCard(
                      title: 'Smart Garden IoT',
                      owner: 'Tim Elektro',
                      tags: ['Arduino', 'IoT', 'Sensor'],
                      score: '92% cocok',
                      accentColor: Color(0xFFB28A18),
                    ),

                    const SizedBox(height: 14),

                    const WorkCard(
                      title: 'Aplikasi Kasir Flutter',
                      owner: 'Tim Informatika',
                      tags: ['Flutter', 'REST API'],
                      score: '87% cocok',
                      accentColor: Color(0xFF7860C8),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF141816),
                border: Border(
                  top: BorderSide(color: AppColors.border),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(menuLabels.length, (index) {
                  final isSelected = selectedMenu == index;

                  return Expanded(
                    child: InkWell(
                      onTap: () {
                        if (index == 1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ExplorePage(),
                            ),
                          );
                          return;
                        }

                        if (index == 0) {
                          setState(() {
                            selectedMenu = 0;
                          });
                          return;
                        }

                        showGuestMessage();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              [
                                Icons.home_rounded,
                                Icons.explore_rounded,
                                Icons.view_in_ar_rounded,
                                Icons.person_rounded,
                              ][index],
                              color: isSelected
                                  ? AppColors.gold
                                  : AppColors.textSecondary,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              menuLabels[index],
                              style: TextStyle(
                                color: isSelected
                                    ? AppColors.gold
                                    : AppColors.textSecondary,
                                fontSize: 12,
                                fontWeight: isSelected
                                    ? FontWeight.w800
                                    : FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WorkCard extends StatelessWidget {
  final String title;
  final String owner;
  final List<String> tags;
  final String score;
  final Color accentColor;

  const WorkCard({
    super.key,
    required this.title,
    required this.owner,
    required this.tags,
    required this.score,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 125,
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            alignment: Alignment.bottomLeft,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: tags.map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2A302C),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        tag,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '$owner · 2026',
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF33301E),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        score,
                        style: const TextStyle(
                          color: AppColors.gold,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class ExplorePage extends StatefulWidget {
  final bool openSearch;

  const ExplorePage({
    super.key,
    this.openSearch = false,
  });

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  String searchQuery = '';
    String selectedStudyProgram = 'Semua Prodi';
  String selectedYear = 'Semua Tahun';

  final List<String> studyPrograms = [
    'Semua Prodi',
    'TRPL',
    'Teknik Informatika',
    'Teknik Elektro',
    'Multimedia',
  ];

  final List<String> exhibitionYears = [
    'Semua Tahun',
    '2026',
    '2025',
    '2024',
  ];
  String selectedCategory = 'Semua';
  String selectedTag = 'Flutter';

  final List<String> categories = [
    'Semua',
    'Electro',
    'IoT',
    'Web',
    'Mobile',
    'UI/UX',
  ];

  final List<String> tags = [
    'Arduino',
    'Flutter',
    'Unity',
    'Firebase',
    'MySQL',
  ];

  @override
  void initState() {
    super.initState();

    if (widget.openSearch) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        searchFocusNode.requestFocus();
      });
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  void showGuestMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Silakan masuk atau daftar untuk memakai fitur ini.'),
        backgroundColor: AppColors.surfaceLight,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Eksplor',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      controller: searchController,
                      focusNode: searchFocusNode,
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 15,
                      ),
                      cursorColor: AppColors.gold,
                      decoration: InputDecoration(
                        hintText: 'Cari judul, tag, teknologi...',
                        hintStyle: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 15,
                        ),
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: AppColors.textSecondary,
                        ),
                        suffixIcon: searchQuery.isEmpty
                            ? null
                            : IconButton(
                                onPressed: () {
                                  searchController.clear();

                                  setState(() {
                                    searchQuery = '';
                                  });
                                },
                                icon: const Icon(
                                  Icons.close_rounded,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                        filled: true,
                        fillColor: AppColors.surface,
                        contentPadding: const EdgeInsets.symmetric(vertical: 17),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: AppColors.border,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: AppColors.gold,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      'Filter Tambahan',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 10),

                    AppFilterDropdown(
                      label: 'Prodi',
                      value: selectedStudyProgram,
                      items: studyPrograms,
                      onChanged: (value) {
                        setState(() {
                          selectedStudyProgram = value!;
                        });
                      },
                    ),

                    const SizedBox(height: 12),

                    AppFilterDropdown(
                      label: 'Tahun Pameran',
                      value: selectedYear,
                      items: exhibitionYears,
                      onChanged: (value) {
                        setState(() {
                          selectedYear = value!;
                        });
                      },
                    ),

                    const SizedBox(height: 26),

                    const Text(
                      'Kategori',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Wrap(
                      spacing: 9,
                      runSpacing: 9,
                      children: categories.map((category) {
                        final isSelected = selectedCategory == category;

                        return ChoiceChip(
                          label: Text(category),
                          selected: isSelected,
                          onSelected: (_) {
                            setState(() {
                              selectedCategory = category;
                            });
                          },
                          backgroundColor: AppColors.surface,
                          selectedColor: AppColors.gold,
                          side: BorderSide(
                            color: isSelected
                                ? AppColors.gold
                                : AppColors.border,
                          ),
                          labelStyle: TextStyle(
                            color: isSelected
                                ? AppColors.background
                                : AppColors.textPrimary,
                            fontWeight: isSelected
                                ? FontWeight.w800
                                : FontWeight.w500,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      'Tag / Teknologi',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Wrap(
                      spacing: 9,
                      runSpacing: 9,
                      children: tags.map((tag) {
                        final isSelected = selectedTag == tag;

                        return ChoiceChip(
                          label: Text(tag),
                          selected: isSelected,
                          onSelected: (_) {
                            setState(() {
                              selectedTag = tag;
                            });
                          },
                          backgroundColor: AppColors.surface,
                          selectedColor: AppColors.gold,
                          side: BorderSide(
                            color: isSelected
                                ? AppColors.gold
                                : AppColors.border,
                          ),
                          labelStyle: TextStyle(
                            color: isSelected
                                ? AppColors.background
                                : AppColors.textPrimary,
                            fontWeight: isSelected
                                ? FontWeight.w800
                                : FontWeight.w500,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 30),

                    Text(
                      searchQuery.isEmpty
                          ? '24 karya ditemukan'
                          : 'Hasil pencarian untuk "$searchQuery"',
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 16),

                    ExploreWorkCard(
                      title: 'Aplikasi Kasir Flutter',
                      owner: 'Tim Informatika',
                      likes: '96 suka',
                      tags: const ['Flutter', 'REST API'],
                      onSave: showGuestMessage,
                    ),

                    const SizedBox(height: 14),

                    ExploreWorkCard(
                      title: 'Katalog Wisata Batam',
                      owner: 'Tim Multimedia',
                      likes: '74 suka',
                      tags: const ['Flutter', 'Firebase'],
                      onSave: showGuestMessage,
                    ),

                    const SizedBox(height: 14),

                    ExploreWorkCard(
                      title: 'Game Edukasi 3D',
                      owner: 'Tim Game',
                      likes: '61 suka',
                      tags: const ['Unity', 'C#'],
                      onSave: showGuestMessage,
                    ),
                  ],
                ),
              ),
            ),

            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF141816),
                border: Border(
                  top: BorderSide(color: AppColors.border),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ExploreNavItem(
                    icon: Icons.home_rounded,
                    label: 'Beranda',
                    selected: false,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ExploreNavItem(
                    icon: Icons.explore_rounded,
                    label: 'Eksplor',
                    selected: true,
                    onTap: () {},
                  ),
                  ExploreNavItem(
                    icon: Icons.view_in_ar_rounded,
                    label: 'Ruang 3D',
                    selected: false,
                    onTap: showGuestMessage,
                  ),
                  ExploreNavItem(
                    icon: Icons.person_rounded,
                    label: 'Profil',
                    selected: false,
                    onTap: showGuestMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExploreNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const ExploreNavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.gold : AppColors.textSecondary;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: selected ? FontWeight.w800 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExploreWorkCard extends StatelessWidget {
  final String title;
  final String owner;
  final String likes;
  final List<String> tags;
  final VoidCallback onSave;

  const ExploreWorkCard({
    super.key,
    required this.title,
    required this.owner,
    required this.likes,
    required this.tags,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              TextButton(
                onPressed: onSave,
                child: const Text(
                  'Simpan',
                  style: TextStyle(
                    color: AppColors.gold,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          Text(
            '$owner · $likes',
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: tags.map((tag) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  tag,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
class AppFilterDropdown extends StatelessWidget {
  final String label;
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const AppFilterDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      dropdownColor: AppColors.surfaceLight,
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        color: AppColors.gold,
      ),
      style: const TextStyle(
        color: AppColors.textPrimary,
        fontSize: 15,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: AppColors.textSecondary,
        ),
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.border,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.gold,
            width: 1.5,
          ),
        ),
      ),
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}