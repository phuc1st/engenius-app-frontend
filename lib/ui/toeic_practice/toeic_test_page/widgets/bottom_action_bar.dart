import 'package:flutter/material.dart';

class BottomActionBar extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onOverviewSubmit;
  final VoidCallback onNext;

  const BottomActionBar({
    super.key,
    required this.onBack,
    required this.onOverviewSubmit,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Back Button
          _roundedRectangleButton(
            icon: Icons.arrow_back_sharp,
            onPressed: onBack,
          ),
          // Overview & Submit Button
          ElevatedButton.icon(
            onPressed: onOverviewSubmit,
            icon: const Icon(Icons.grid_view_outlined, size: 20),
            label: const Text(
              'Tổng quan & Nộp bài',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              backgroundColor: const Color(0xFF5A7FFF),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
          ),
          _roundedRectangleButton(
            icon: Icons.arrow_forward_sharp,
            onPressed: onNext,
          ),
        ],
      ),
    );
  }

  Widget _roundedRectangleButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, size: 21),
      style: IconButton.styleFrom(
        foregroundColor: const Color(0xFF5A7FFF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
      ),
    );
  }
}
