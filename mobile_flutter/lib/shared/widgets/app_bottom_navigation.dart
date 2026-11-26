import 'package:flutter/material.dart';

class AppBottomNavigation extends StatelessWidget {
  final int selectedIndex;

  const AppBottomNavigation({super.key, required this.selectedIndex});

  void _openDestination(BuildContext context, int index) {
    if (index == selectedIndex) return;

    switch (index) {
      case 0:
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      case 1:
        Navigator.pushNamed(context, '/explore');
      case 2:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ruang 3D segera hadir.'),
            backgroundColor: Color(0xFF17243A),
            behavior: SnackBarBehavior.floating,
          ),
        );
      case 3:
        Navigator.pushNamed(context, '/profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    const labels = ['Beranda', 'Explore', 'Ruang 3D', 'Profil'];
    const icons = [
      Icons.home_outlined,
      Icons.explore_outlined,
      Icons.view_in_ar_outlined,
      Icons.person_outline_rounded,
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE8EBF2))),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: List.generate(labels.length, (index) {
            final selected = selectedIndex == index;
            final color = selected
                ? const Color(0xFFF2A000)
                : const Color(0xFF788397);

            return Expanded(
              child: InkWell(
                onTap: () => _openDestination(context, index),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (index == 2)
                        const Text(
                          'SEGERA',
                          style: TextStyle(
                            color: Color(0xFFE0A000),
                            fontSize: 6,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      Icon(icons[index], color: color, size: 18),
                      const SizedBox(height: 2),
                      Text(
                        labels[index],
                        style: TextStyle(
                          color: color,
                          fontSize: 8,
                          fontWeight: selected
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
    );
  }
}
