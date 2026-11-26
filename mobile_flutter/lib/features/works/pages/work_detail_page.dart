import 'package:flutter/material.dart';

import '../models/work_detail_data.dart';

class WorkDetailPage extends StatefulWidget {
  final WorkDetailData work;
  final bool isSaved;
  final bool isLiked;

  const WorkDetailPage({
    super.key,
    required this.work,
    this.isSaved = false,
    this.isLiked = false,
  });

  @override
  State<WorkDetailPage> createState() => _WorkDetailPageState();
}

class _WorkDetailPageState extends State<WorkDetailPage> {
  static const _page = Color(0xFFF7F8FC);
  static const _ink = Color(0xFF17243A);
  static const _muted = Color(0xFF68768C);
  static const _pale = Color(0xFFEFF3FF);
  static const _line = Color(0xFFE5EAF4);
  static const _gold = Color(0xFFFFB62E);

  late bool _isSaved;
  late bool _isLiked;

  @override
  void initState() {
    super.initState();
    _isSaved = widget.isSaved;
    _isLiked = widget.isLiked;
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: _ink,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _goBack() {
    Navigator.pop(
      context,
      WorkDetailResult(isSaved: _isSaved, isLiked: _isLiked),
    );
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
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 520),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _topBar(),
                        const SizedBox(height: 10),
                        _backButton(),
                        const SizedBox(height: 9),
                        _poster(),
                        const SizedBox(height: 9),
                        _workInfo(),
                        const SizedBox(height: 9),
                        _description(),
                        const SizedBox(height: 9),
                        _videoPreview(),
                        const SizedBox(height: 9),
                        _roomPreview(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            _bottomActions(),
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
            color: _ink,
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
              'Detail Karya',
              style: TextStyle(
                color: _ink,
                fontSize: 10,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          tooltip: 'Profil',
          onPressed: () => Navigator.pushNamed(context, '/profile'),
          visualDensity: VisualDensity.compact,
          style: IconButton.styleFrom(
            backgroundColor: _pale,
            fixedSize: const Size(28, 28),
          ),
          icon: const Icon(Icons.person_rounded, color: _ink, size: 16),
        ),
      ],
    );
  }

  Widget _backButton() {
    return OutlinedButton.icon(
      onPressed: _goBack,
      icon: const Icon(Icons.arrow_back_rounded, size: 13),
      label: const Text('Kembali'),
      style: OutlinedButton.styleFrom(
        foregroundColor: _ink,
        backgroundColor: Colors.white,
        side: const BorderSide(color: _line),
        minimumSize: const Size(0, 30),
        padding: const EdgeInsets.symmetric(horizontal: 11),
        textStyle: const TextStyle(fontSize: 8, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _poster() {
    return Container(
      width: double.infinity,
      height: 132,
      decoration: BoxDecoration(
        color: _pale,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _line),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 31,
            height: 31,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.image_outlined,
              color: Color(0xFF9AA7BD),
              size: 17,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Poster karya',
            style: const TextStyle(
              color: _muted,
              fontSize: 8,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _workInfo() {
    return _whiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.work.title,
            style: const TextStyle(
              color: _ink,
              fontSize: 13,
              height: 1.25,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 7),
          Row(
            children: [
              const Icon(Icons.groups_2_outlined, color: _gold, size: 13),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  widget.work.owner,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF9A6500),
                    fontSize: 8,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              const Text('•', style: TextStyle(color: _muted, fontSize: 8)),
              const SizedBox(width: 5),
              Text(
                widget.work.year.toString(),
                style: const TextStyle(color: _muted, fontSize: 8),
              ),
            ],
          ),
          const SizedBox(height: 7),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: [
              _tag(widget.work.category, featured: true),
              ...widget.work.tags.map((tag) => _tag(tag)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _description() {
    return _whiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'DESKRIPSI KARYA',
            style: TextStyle(
              color: Color(0xFF9AA5B7),
              fontSize: 8,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            widget.work.description,
            style: const TextStyle(color: _muted, fontSize: 9, height: 1.45),
          ),
        ],
      ),
    );
  }

  Widget _videoPreview() {
    return InkWell(
      onTap: () => _showMessage('Video demo untuk karya ini belum tersedia.'),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        height: 132,
        decoration: BoxDecoration(
          color: _pale,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _line),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFFFE2A1)),
              ),
              child: const Icon(
                Icons.play_arrow_rounded,
                color: Color(0xFFE49A17),
                size: 20,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Tonton Video Demo',
              style: TextStyle(
                color: _ink,
                fontSize: 8,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _roomPreview() {
    return _whiteCard(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF7E4),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.view_in_ar_outlined,
              color: Color(0xFFE5A321),
              size: 17,
            ),
          ),
          const SizedBox(width: 7),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ruang 3D',
                  style: TextStyle(
                    color: _ink,
                    fontSize: 8,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF0D5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    widget.work.roomStatus,
                    style: const TextStyle(
                      color: Color(0xFF9A6500),
                      fontSize: 6,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  widget.work.roomDescription,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: _muted, fontSize: 7),
                ),
              ],
            ),
          ),
          const SizedBox(width: 5),
          OutlinedButton(
            onPressed: () => _showMessage('Ruang 3D segera hadir.'),
            style: OutlinedButton.styleFrom(
              foregroundColor: _muted,
              backgroundColor: const Color(0xFFF6F8FC),
              side: const BorderSide(color: _line),
              minimumSize: const Size(58, 24),
              padding: const EdgeInsets.symmetric(horizontal: 6),
              textStyle: const TextStyle(fontSize: 7),
            ),
            child: const Text('Segera Hadir'),
          ),
        ],
      ),
    );
  }

  Widget _bottomActions() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: _line)),
      ),
      child: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() => _isLiked = !_isLiked);
                          _showMessage(
                            _isLiked ? 'Karya disukai.' : 'Suka dibatalkan.',
                          );
                        },
                        icon: Icon(
                          _isLiked
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          color: const Color(0xFFFF6878),
                          size: 14,
                        ),
                        label: Text(_isLiked ? 'Disukai' : 'Suka'),
                        style: _actionButtonStyle(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() => _isSaved = !_isSaved);
                          _showMessage(
                            _isSaved
                                ? 'Karya disimpan.'
                                : 'Karya dihapus dari simpanan.',
                          );
                        },
                        icon: Icon(
                          _isSaved
                              ? Icons.bookmark_rounded
                              : Icons.bookmark_add_outlined,
                          color: _gold,
                          size: 14,
                        ),
                        label: Text(_isSaved ? 'Tersimpan' : 'Simpan Karya'),
                        style: _actionButtonStyle(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ButtonStyle _actionButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: _ink,
      foregroundColor: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
      textStyle: const TextStyle(fontSize: 9, fontWeight: FontWeight.w800),
    );
  }

  Widget _tag(String label, {bool featured = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      decoration: BoxDecoration(
        color: featured ? _ink : _pale,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: featured ? Colors.white : const Color(0xFF5275B1),
          fontSize: 7,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _whiteCard({required Widget child, EdgeInsets? padding}) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF0F2F7)),
      ),
      child: child,
    );
  }
}
