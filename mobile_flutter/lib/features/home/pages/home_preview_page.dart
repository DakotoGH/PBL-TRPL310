import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../shared/widgets/app_bottom_navigation.dart';
import '../../works/models/work_detail_data.dart';
import '../../works/pages/work_detail_page.dart';

class HomePreviewPage extends StatefulWidget {
  final bool isGuest;

  const HomePreviewPage({super.key, this.isGuest = true});

  @override
  State<HomePreviewPage> createState() => _HomePreviewPageState();
}

class _HomePreviewPageState extends State<HomePreviewPage> {
  static const _ink = Color(0xFF17243A);
  static const _muted = Color(0xFF68768C);
  static const _pale = Color(0xFFE8EFFF);

  final _search = TextEditingController();
  final Set<String> _savedWorks = {};
  final Set<String> _likedWorks = {};
  String _category = 'Semua';

  static const _categories = [
    'Semua',
    'IoT & Hardware',
    'AI & Data',
    'Mobile App',
  ];

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  bool get _isGuest =>
      widget.isGuest || FirebaseAuth.instance.currentUser == null;

  String get _userName {
    final user = FirebaseAuth.instance.currentUser;
    final displayName = user?.displayName?.trim();
    if (displayName != null && displayName.isNotEmpty) return displayName;
    return user?.email?.split('@').first ?? 'Pengunjung Tamu';
  }

  void _message(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: _ink,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _openWorkDetail(WorkDetailData work) async {
    final result = await Navigator.push<WorkDetailResult>(
      context,
      MaterialPageRoute(
        builder: (_) => WorkDetailPage(
          work: work,
          isSaved: _savedWorks.contains(work.title),
          isLiked: _likedWorks.contains(work.title),
        ),
      ),
    );
    if (!mounted || result == null) return;
    setState(() {
      if (result.isSaved) {
        _savedWorks.add(work.title);
      } else {
        _savedWorks.remove(work.title);
      }
      if (result.isLiked) {
        _likedWorks.add(work.title);
      } else {
        _likedWorks.remove(work.title);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 18),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 520),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _topBar(),
                        const SizedBox(height: 14),
                        const Text(
                          'Karya Mahasiswa',
                          style: TextStyle(
                            color: _ink,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 3),
                        const Text(
                          'Temukan ide dan inovasi dari berbagai bidang.',
                          style: TextStyle(color: _muted, fontSize: 12),
                        ),
                        const SizedBox(height: 12),
                        _greetingCard(),
                        const SizedBox(height: 10),
                        _searchBar(),
                        const SizedBox(height: 7),
                        _categoryFilters(),
                        const SizedBox(height: 12),
                        _expoBanner(),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Rekomendasi untukmu  ✨',
                                style: TextStyle(
                                  color: _ink,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            IconButton(
                              tooltip: 'Muat ulang rekomendasi',
                              onPressed: () =>
                                  _message('Rekomendasi sudah diperbarui.'),
                              icon: const Icon(Icons.autorenew_rounded),
                              color: const Color(0xFF9A6A00),
                              style: IconButton.styleFrom(
                                backgroundColor: _pale,
                                fixedSize: const Size(34, 34),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Dipersonalisasi berdasarkan ketertarikan teknologi Anda',
                          style: TextStyle(color: _muted, fontSize: 9),
                        ),
                        const SizedBox(height: 9),
                        _workCard(
                          const WorkDetailData(
                            title:
                                'Smart Garden IoT: Monitoring Nutrisi Otomatis',
                            owner: 'Tim Elektro',
                            category: 'IoT & Hardware',
                            tags: ['Arduino', 'IoT', 'Sensor'],
                            description: 'Sistem cerdas pemantauan pH air dan formulasi nutrisi tanaman hidroponik berbasis sensor.',
                            previewIcon: Icons.grid_view_rounded,
                            previewLabel: 'Pratinjau Model Perangkat',
                          ),
                        ),
                        const SizedBox(height: 10),
                        _workCard(
                          const WorkDetailData(
                            title: 'EduBot AI: Tutor Matematika Interaktif Mahasiswa',
                            owner: 'Tim Ilmu Komputer',
                            category: 'AI & Data',
                            tags: ['Python', 'LLM', 'NLP', 'FastAPI'],
                            description: 'Chatbot tutor adaptif berbasis generative AI dan natural language processing untuk pembelajaran mandiri.',
                            previewIcon: Icons.smart_toy_outlined,
                            previewLabel: 'Pratinjau Antarmuka EduBot',
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const AppBottomNavigation(selectedIndex: 0),
          ],
        ),
      ),
    );
  }

  Widget _topBar() {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _ink,
            borderRadius: BorderRadius.circular(9),
          ),
          child: const Text(
            'V',
            style: TextStyle(
              color: Color(0xFFFFC928),
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(width: 7),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'V-EDUMATCH',
              style: TextStyle(
                color: _ink,
                fontSize: 10,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              'Beranda',
              style: TextStyle(
                color: Color(0xFF976900),
                fontSize: 7,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          tooltip: 'Profil',
          onPressed: () => Navigator.pushNamed(context, '/profile'),
          icon: const Icon(Icons.account_circle_rounded, color: _ink),
        ),
      ],
    );
  }

  Widget _greetingCard() {
    return Container(
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: _pale,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 16,
            backgroundColor: Color(0xFFFFE4C0),
            child: Icon(
              Icons.waving_hand_rounded,
              color: Color(0xFFE89A28),
              size: 18,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isGuest ? 'Halo, Pengunjung Tamu' : 'Halo, $_userName',
                  style: const TextStyle(
                    color: _ink,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  _isGuest
                      ? 'Simpan karya favorit dengan akunmu'
                      : 'Temukan karya yang sesuai minatmu',
                  style: const TextStyle(color: _muted, fontSize: 8),
                ),
              ],
            ),
          ),
          const SizedBox(width: 5),
          SizedBox(
            height: 29,
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(
                context,
                _isGuest ? '/login' : '/profile',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: _ink,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 9),
              ),
              child: Text(_isGuest ? 'Masuk Akun' : 'Profil'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchBar() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _search,
            onSubmitted: (_) =>
                Navigator.pushNamed(context, '/explore', arguments: true),
            decoration: InputDecoration(
              hintText: 'Cari karya, tag, teknologi...',
              hintStyle: const TextStyle(color: _muted, fontSize: 10),
              prefixIcon: const Icon(Icons.search_rounded, size: 18),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 7),
        IconButton(
          tooltip: 'Cari dan filter',
          onPressed: () => Navigator.pushNamed(context, '/explore'),
          icon: const Icon(Icons.tune_rounded),
          style: IconButton.styleFrom(backgroundColor: Colors.white),
        ),
      ],
    );
  }

  Widget _categoryFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _categories.map((category) {
          final selected = category == _category;
          return Padding(
            padding: const EdgeInsets.only(right: 5),
            child: ChoiceChip(
              label: Text(category),
              selected: selected,
              onSelected: (_) => setState(() => _category = category),
              showCheckmark: false,
              visualDensity: VisualDensity.compact,
              labelStyle: TextStyle(
                color: selected ? Colors.white : _ink,
                fontSize: 8,
              ),
              backgroundColor: Colors.white,
              selectedColor: Colors.black,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _expoBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF17243A), Color(0xFF506583)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '✦ DALAM PENGEMBANGAN • SEGERA HADIR',
            style: TextStyle(
              color: Color(0xFFFFD77A),
              fontSize: 7,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Jelajahi Expo dalam Ruang Virtual 3D',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Berkeliling booth pameran inovasi mahasiswa dengan pengalaman interaktif.',
            style: TextStyle(
              color: Color(0xFFD9E1EE),
              fontSize: 8,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 7),
          OutlinedButton.icon(
            onPressed: () => _message('Ruang 3D segera hadir.'),
            icon: const Icon(Icons.lock_outline_rounded, size: 11),
            label: const Text('Segera Hadir'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Color(0x66FFFFFF)),
              visualDensity: VisualDensity.compact,
              textStyle: const TextStyle(fontSize: 8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _workCard(WorkDetailData work) {
    final isLiked = _likedWorks.contains(work.title);
    final isSaved = _savedWorks.contains(work.title);

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x080F2340),
            blurRadius: 9,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1.75,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ColoredBox(
                  color: _pale,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        work.previewIcon,
                        color: const Color(0xFF758199),
                        size: 43,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        work.previewLabel,
                        style: const TextStyle(color: _muted, fontSize: 11),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: _categoryChip(work.category, dark: true),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 13, 16, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${work.owner} • ${work.year}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFF9A6A00),
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.visibility_outlined,
                      color: Color(0xFF8B929E),
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${work.viewCount} Dilihat',
                      style: const TextStyle(
                        color: Color(0xFF8B929E),
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  work.title,
                  style: const TextStyle(
                    color: _ink,
                    fontSize: 16,
                    height: 1.25,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  work.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _muted,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 9),
                Wrap(
                  spacing: 6,
                  runSpacing: 5,
                  children: work.tags.map(_tagChip).toList(),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 44,
                        child: ElevatedButton.icon(
                          onPressed: () => _openWorkDetail(work),
                          iconAlignment: IconAlignment.end,
                          icon: const Icon(
                            Icons.arrow_forward_rounded,
                            size: 17,
                          ),
                          label: const Text('Lihat Detail Karya'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    _workActionButton(
                      icon: isLiked
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      color: isLiked ? const Color(0xFFE35265) : _muted,
                      tooltip: isLiked ? 'Batal suka' : 'Suka karya',
                      onPressed: () => setState(() {
                        if (isLiked) {
                          _likedWorks.remove(work.title);
                        } else {
                          _likedWorks.add(work.title);
                        }
                      }),
                    ),
                    const SizedBox(width: 7),
                    _workActionButton(
                      icon: isSaved
                          ? Icons.bookmark_rounded
                          : Icons.bookmark_border_rounded,
                      color: isSaved ? const Color(0xFF365A9C) : _muted,
                      tooltip: isSaved ? 'Hapus simpanan' : 'Simpan karya',
                      onPressed: () => setState(() {
                        if (isSaved) {
                          _savedWorks.remove(work.title);
                        } else {
                          _savedWorks.add(work.title);
                        }
                      }),
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

  Widget _workActionButton({
    required IconData icon,
    required Color color,
    required String tooltip,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 48,
      height: 44,
      child: IconButton(
        onPressed: onPressed,
        tooltip: tooltip,
        style: IconButton.styleFrom(
          backgroundColor: _pale,
          foregroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: Icon(icon, size: 19),
      ),
    );
  }

  Widget _categoryChip(String label, {bool dark = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: dark ? _ink : _pale,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: dark ? Colors.white : _ink,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _tagChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: _pale,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: _ink,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
