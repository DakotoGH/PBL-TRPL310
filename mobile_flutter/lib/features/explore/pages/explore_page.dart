import 'package:flutter/material.dart';

import '../../../shared/widgets/app_bottom_navigation.dart';
import '../../works/models/work_detail_data.dart';
import '../../works/pages/work_detail_page.dart';

class ExplorePage extends StatefulWidget {
  final bool openSearch;

  const ExplorePage({super.key, this.openSearch = false});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  static const _ink = Color(0xFF17243A);
  static const _muted = Color(0xFF68768C);
  static const _page = Color(0xFFF7F8FC);

  final _search = TextEditingController();
  final _focus = FocusNode();
  final Set<String> _saved = {};
  final Set<String> _liked = {};
  String _category = 'Semua';

  static const _categories = [
    'Semua',
    'IoT & Hardware',
    'AI & Data',
    'Mobile App',
  ];

  static const _works = [
    WorkDetailData(
      title: 'Smart Garden IoT: Monitoring Nutrisi Otomatis',
      owner: 'Tim Elektro',
      category: 'IoT & Hardware',
      description: 'Sistem cerdas pemantauan nutrisi tanaman hidroponik berbasis sensor pH, EC, dan kontrol pompa otomatis.',
      tags: ['Arduino', 'IoT', 'Sensor'],
      previewIcon: Icons.sensors_rounded,
      previewLabel: 'Pratinjau Model Perangkat',
    ),
    WorkDetailData(
      title: 'EduBot AI: Tutor Matematika Interaktif Mahasiswa',
      owner: 'Tim Ilmu Komputer',
      category: 'AI & Data',
      description: 'Chatbot tutor adaptif berbasis generative AI dan natural language processing untuk pembelajaran mandiri.',
      tags: ['Python', 'LLM', 'NLP', 'FastAPI'],
      previewIcon: Icons.psychology_outlined,
      previewLabel: 'Pratinjau Antarmuka EduBot',
    ),
    WorkDetailData(
      title: 'HealthPulse: Aplikasi Pantau Kebugaran Kampus',
      owner: 'Tim Rekayasa Perangkat Lunak',
      category: 'Mobile App',
      description: 'Aplikasi mobile pelacak aktivitas fisik terintegrasi dengan sensor wearable dan program tantangan kebugaran.',
      tags: ['Flutter', 'Health', 'Mobile'],
      previewIcon: Icons.phone_iphone_rounded,
      previewLabel: 'Pratinjau Aplikasi',
    ),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.openSearch) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _focus.requestFocus();
      });
    }
  }

  @override
  void dispose() {
    _search.dispose();
    _focus.dispose();
    super.dispose();
  }

  List<WorkDetailData> get _visibleWorks {
    final query = _search.text.trim().toLowerCase();
    return _works.where((work) {
      final categoryMatches =
          _category == 'Semua' || work.category == _category;
      final searchable = [
        work.title,
        work.owner,
        work.description,
        ...work.tags,
      ].join(' ').toLowerCase();
      return categoryMatches && (query.isEmpty || searchable.contains(query));
    }).toList();
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
          isSaved: _saved.contains(work.title),
          isLiked: _liked.contains(work.title),
        ),
      ),
    );
    if (!mounted || result == null) return;
    setState(() {
      if (result.isSaved) {
        _saved.add(work.title);
      } else {
        _saved.remove(work.title);
      }
      if (result.isLiked) {
        _liked.add(work.title);
      } else {
        _liked.remove(work.title);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _page,
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
                        const SizedBox(height: 18),
                        const Text(
                          'Jelajahi',
                          style: TextStyle(
                            color: _ink,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 3),
                        const Text(
                          'Temukan inovasi dan karya teknologi mahasiswa',
                          style: TextStyle(color: _muted, fontSize: 11),
                        ),
                        const SizedBox(height: 13),
                        _searchBar(),
                        const SizedBox(height: 8),
                        _categoryFilters(),
                        const SizedBox(height: 11),
                        const Text(
                          'Daftar Karya',
                          style: TextStyle(
                            color: _ink,
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (_visibleWorks.isEmpty)
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.all(24),
                              child: Text(
                                'Karya tidak ditemukan.',
                                style: TextStyle(color: _muted),
                              ),
                            ),
                          )
                        else
                          ..._visibleWorks.map(
                            (work) => Padding(
                              padding: const EdgeInsets.only(bottom: 11),
                              child: _ExploreWorkCard(
                                work: work,
                                saved: _saved.contains(work.title),
                                onDetail: () => _openWorkDetail(work),
                                onSave: () {
                                  setState(() {
                                    if (!_saved.add(work.title)) {
                                      _saved.remove(work.title);
                                    }
                                  });
                                  _message(
                                    _saved.contains(work.title)
                                        ? 'Karya disimpan.'
                                        : 'Karya dihapus dari simpanan.',
                                  );
                                },
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const AppBottomNavigation(selectedIndex: 1),
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
              'V-EduMatch',
              style: TextStyle(
                color: _ink,
                fontSize: 10,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              'VIRTUAL EXPO',
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
          visualDensity: VisualDensity.compact,
          icon: const Icon(Icons.account_circle_rounded, color: _ink, size: 22),
        ),
      ],
    );
  }

  Widget _searchBar() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _search,
            focusNode: _focus,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: 'Cari judul, tag, atau teknologi...',
              hintStyle: const TextStyle(color: _muted, fontSize: 10),
              prefixIcon: const Icon(Icons.search_rounded, size: 17),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 7),
        IconButton(
          tooltip: 'Filter kategori',
          onPressed: () => _message('Pilih kategori pada filter di bawah.'),
          style: IconButton.styleFrom(
            fixedSize: const Size(39, 39),
            backgroundColor: Colors.white,
            foregroundColor: _ink,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(11),
              side: const BorderSide(color: Color(0xFFE8EBF2)),
            ),
          ),
          icon: const Icon(Icons.tune_rounded, size: 17),
        ),
      ],
    );
  }

  Widget _categoryFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _categories.map((label) {
          final selected = _category == label;
          return Padding(
            padding: const EdgeInsets.only(right: 5),
            child: ChoiceChip(
              label: Text(label),
              selected: selected,
              onSelected: (_) => setState(() => _category = label),
              showCheckmark: false,
              visualDensity: VisualDensity.compact,
              labelStyle: TextStyle(
                color: selected ? Colors.white : _ink,
                fontSize: 8,
                fontWeight: FontWeight.w600,
              ),
              backgroundColor: Colors.white,
              selectedColor: Colors.black,
              side: BorderSide(
                color: selected ? Colors.black : const Color(0xFFE8EBF2),
              ),
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(horizontal: 4),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _ExploreWorkCard extends StatelessWidget {
  final WorkDetailData work;
  final bool saved;
  final VoidCallback onDetail;
  final VoidCallback onSave;

  const _ExploreWorkCard({
    required this.work,
    required this.saved,
    required this.onDetail,
    required this.onSave,
  });

  static const _ink = Color(0xFF17243A);
  static const _muted = Color(0xFF68768C);
  static const _pale = Color(0xFFE8EFFF);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Color(0x080F2340),
            blurRadius: 8,
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
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Icon(
                          work.previewIcon,
                          color: const Color(0xFF758199),
                          size: 24,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        work.previewLabel,
                        style: const TextStyle(color: _muted, fontSize: 9),
                      ),
                    ],
                  ),
                ),
                Positioned(top: 10, left: 10, child: _categoryChip()),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
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
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.visibility_outlined,
                      color: _muted,
                      size: 12,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      '${work.viewCount} dilihat',
                      style: const TextStyle(color: _muted, fontSize: 8),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  work.title,
                  style: const TextStyle(
                    color: _ink,
                    fontSize: 13,
                    height: 1.25,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  work.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _muted,
                    fontSize: 9,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: work.tags.map(_tagChip).toList(),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 34,
                        child: ElevatedButton.icon(
                          onPressed: onDetail,
                          iconAlignment: IconAlignment.end,
                          icon: const Icon(
                            Icons.arrow_forward_rounded,
                            size: 13,
                          ),
                          label: const Text('Lihat Detail'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 7),
                    SizedBox(
                      width: 36,
                      height: 34,
                      child: IconButton(
                        onPressed: onSave,
                        padding: EdgeInsets.zero,
                        tooltip: saved ? 'Hapus simpanan' : 'Simpan karya',
                        style: IconButton.styleFrom(
                          backgroundColor: const Color(0xFFF3F6FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9),
                            side: const BorderSide(color: Color(0xFFE4E9F2)),
                          ),
                        ),
                        icon: Icon(
                          saved
                              ? Icons.bookmark_rounded
                              : Icons.bookmark_border,
                          size: 15,
                          color: saved ? _ink : _muted,
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

  Widget _categoryChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFE1EAFF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        work.category,
        style: const TextStyle(
          color: Color(0xFF466AA8),
          fontSize: 7,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _tagChip(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: _pale,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        tag,
        style: const TextStyle(
          color: _ink,
          fontSize: 7,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
