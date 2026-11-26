import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../auth/auth_service.dart';
import '../../../shared/widgets/app_bottom_navigation.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const _page = Color(0xFFF7F8FC);
  static const _navy = Color(0xFF141D32);
  static const _ink = Color(0xFF17243A);
  static const _muted = Color(0xFF66738A);
  static const _pale = Color(0xFFEDF2FF);
  static const _line = Color(0xFFE8EBF2);
  static const _gold = Color(0xFFFFB62E);
  static const _red = Color(0xFFD83B3B);

  bool _isSigningOut = false;

  String get _displayName {
    final user = FirebaseAuth.instance.currentUser;
    final name = user?.displayName?.trim();
    if (name != null && name.isNotEmpty) return name;
    final emailName = user?.email?.split('@').first;
    if (emailName != null && emailName.isNotEmpty) return emailName;
    return 'Nama Anda';
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: _navy,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _signOut() async {
    setState(() => _isSigningOut = true);
    try {
      await AuthService.signOut();
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    } catch (_) {
      if (mounted) _showMessage('Tidak bisa keluar. Coba lagi.');
    } finally {
      if (mounted) setState(() => _isSigningOut = false);
    }
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
                padding: const EdgeInsets.fromLTRB(16, 7, 16, 16),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 520),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _topBar(),
                        const SizedBox(height: 13),
                        _profileSummary(),
                        const SizedBox(height: 12),
                        _submitWorkButton(),
                        const SizedBox(height: 17),
                        _sectionHeading(),
                        const SizedBox(height: 8),
                        _workCard(
                          category: 'Mobile App',
                          status: 'Tayang',
                          title:
                              'HealthPulse: Aplikasi Pantau Kebugaran Kampus',
                          description: 'Integrasi sensor detak jantung dan pelacak aktivitas fisik untuk civitas akademika Polibatam.',
                          activity: 'Update 3 hari lalu',
                        ),
                        const SizedBox(height: 9),
                        _workCard(
                          category: 'AI & Data',
                          status: 'Menunggu Persetujuan',
                          title: 'EduBot AI: Tutor Matematika Interaktif Mahasiswa',
                          description: 'Sistem asisten pembelajaran kalkulus berbasis LLM terkurasi untuk kurikulum kampus.',
                          activity: 'Diajukan kemarin',
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'Lainnya',
                          style: TextStyle(
                            color: _ink,
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 7),
                        _otherOptions(),
                        const SizedBox(height: 11),
                        _signOutButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const AppBottomNavigation(selectedIndex: 3),
          ],
        ),
      ),
    );
  }

  Widget _topBar() {
    return Row(
      children: [
        Container(
          width: 22,
          height: 22,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _navy,
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Text(
            'V',
            style: TextStyle(
              color: _gold,
              fontSize: 14,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(width: 6),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'V-EDUMATCH',
              style: TextStyle(
                color: Color(0xFF9A6500),
                fontSize: 7,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              'Profil',
              style: TextStyle(
                color: _ink,
                fontSize: 10,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const Spacer(),
        Container(
          width: 28,
          height: 28,
          decoration: const BoxDecoration(color: _pale, shape: BoxShape.circle),
          child: const Icon(Icons.person_rounded, color: _muted, size: 17),
        ),
      ],
    );
  }

  Widget _profileSummary() {
    return Container(
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        boxShadow: const [
          BoxShadow(
            color: Color(0x080F2340),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: const Color(0xFFDDE8FF),
                child: Text(
                  _displayName.isEmpty ? '?' : _displayName[0].toUpperCase(),
                  style: const TextStyle(
                    color: _ink,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _displayName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: _ink,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Text(
                      'Teknik Rekayasa Perangkat Lunak',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: _muted, fontSize: 8),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          const Row(
            children: [
              Expanded(
                child: _ProfileStatistic(value: '2', label: 'Karya'),
              ),
              SizedBox(width: 6),
              Expanded(
                child: _ProfileStatistic(value: '0', label: 'Suka'),
              ),
              SizedBox(width: 6),
              Expanded(
                child: _ProfileStatistic(value: '0', label: 'Disimpan'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _submitWorkButton() {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: ElevatedButton.icon(
        onPressed: () => _showMessage('Form pengajuan karya segera tersedia.'),
        icon: const Icon(Icons.add_circle_outline, color: _gold, size: 14),
        label: const Text(
          'Ajukan Karya Baru',
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: _navy,
          foregroundColor: Colors.white,
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
        ),
      ),
    );
  }

  Widget _sectionHeading() {
    return Row(
      children: [
        const Text(
          'Karya Saya',
          style: TextStyle(
            color: _ink,
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(width: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          decoration: const BoxDecoration(color: _pale, shape: BoxShape.circle),
          child: const Text(
            '2',
            style: TextStyle(
              color: _muted,
              fontSize: 7,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const Spacer(),
        const Text(
          'Virtual Expo',
          style: TextStyle(
            color: Color(0xFF9A6500),
            fontSize: 8,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _workCard({
    required String category,
    required String status,
    required String title,
    required String description,
    required String activity,
  }) {
    final isLive = status == 'Tayang';
    return Container(
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
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
          Row(
            children: [
              _smallTag(category, background: _pale, foreground: _ink),
              const SizedBox(width: 4),
              _smallTag(
                status,
                background: isLive
                    ? const Color(0xFFFFF0D5)
                    : const Color(0xFFFFE8C2),
                foreground: const Color(0xFF9A6500),
                icon: isLive ? null : Icons.hourglass_top_rounded,
              ),
              const Spacer(),
              _squareAction(
                icon: Icons.edit_outlined,
                label: 'Ubah karya',
                onTap: () => _showMessage('Fitur ubah karya segera tersedia.'),
              ),
              const SizedBox(width: 4),
              _squareAction(
                icon: Icons.delete_outline_rounded,
                label: 'Hapus karya',
                foreground: _red,
                onTap: () => _showMessage('Fitur hapus karya segera tersedia.'),
              ),
            ],
          ),
          const SizedBox(height: 7),
          Text(
            title,
            style: const TextStyle(
              color: _ink,
              fontSize: 10,
              height: 1.25,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: _muted, fontSize: 8, height: 1.35),
          ),
          const SizedBox(height: 7),
          Row(
            children: [
              const Icon(Icons.favorite_border_rounded, color: _gold, size: 10),
              const SizedBox(width: 3),
              const Text(
                '0 suka',
                style: TextStyle(color: _muted, fontSize: 7),
              ),
              const SizedBox(width: 9),
              const Icon(Icons.visibility_outlined, color: _muted, size: 10),
              const SizedBox(width: 3),
              Text(
                isLive ? '0 dilihat' : 'Dalam tinjauan',
                style: const TextStyle(color: _muted, fontSize: 7),
              ),
              const Spacer(),
              Text(
                activity,
                style: const TextStyle(
                  color: _muted,
                  fontSize: 7,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _smallTag(
    String label, {
    required Color background,
    required Color foreground,
    IconData? icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 7, color: foreground),
            const SizedBox(width: 2),
          ],
          Text(
            label,
            style: TextStyle(
              color: foreground,
              fontSize: 6,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _squareAction({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color foreground = _muted,
  }) {
    return SizedBox(
      width: 23,
      height: 23,
      child: IconButton(
        onPressed: onTap,
        tooltip: label,
        padding: EdgeInsets.zero,
        style: IconButton.styleFrom(
          backgroundColor: _pale,
          foregroundColor: foreground,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        icon: Icon(icon, size: 12),
      ),
    );
  }

  Widget _otherOptions() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x080F2340),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _menuRow(
            Icons.bookmark_border_rounded,
            'Tersimpan',
            'Koleksi karya inovasi yang disimpan',
            () => _showMessage('Daftar karya tersimpan segera tersedia.'),
          ),
          const Divider(height: 1, color: _line),
          _menuRow(
            Icons.auto_awesome_outlined,
            'Minat Saya',
            'Preferensi bidang & teknologi favorit',
            () => _showMessage('Pengaturan minat segera tersedia.'),
          ),
          const Divider(height: 1, color: _line),
          _menuRow(
            Icons.history_rounded,
            'Aktivitas',
            'Riwayat aktivitas dan interaksi karya',
            () => _showMessage('Riwayat aktivitas segera tersedia.'),
          ),
        ],
      ),
    );
  }

  Widget _menuRow(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Row(
          children: [
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: _pale,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(icon, color: _ink, size: 14),
            ),
            const SizedBox(width: 7),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: _ink,
                      fontSize: 8,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: _muted, fontSize: 7),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: _muted, size: 15),
          ],
        ),
      ),
    );
  }

  Widget _signOutButton() {
    return SizedBox(
      width: double.infinity,
      height: 38,
      child: TextButton.icon(
        onPressed: _isSigningOut ? null : _signOut,
        icon: _isSigningOut
            ? const SizedBox(
                width: 13,
                height: 13,
                child: CircularProgressIndicator(strokeWidth: 2, color: _red),
              )
            : const Icon(Icons.logout_rounded, size: 13),
        label: const Text(
          'Keluar',
          style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700),
        ),
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: _red,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
        ),
      ),
    );
  }
}

class _ProfileStatistic extends StatelessWidget {
  final String value;
  final String label;

  const _ProfileStatistic({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      decoration: BoxDecoration(
        color: _ProfilePageState._pale,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: _ProfilePageState._ink,
              fontSize: 9,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: _ProfilePageState._muted,
              fontSize: 6,
            ),
          ),
        ],
      ),
    );
  }
}
