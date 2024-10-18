import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlideAction extends StatelessWidget {
  const SlideAction({
    super.key,
    required this.color,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.flex = 1,
  });

  final Color color;
  final IconData icon;
  final int flex;
  final String label;
  final SlidableActionCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SlidableAction(
      flex: flex,
      padding: EdgeInsets.zero,
      backgroundColor: color,
      foregroundColor: Colors.white,
      onPressed: onPressed,
      icon: icon,
      label: label,
    );
  }}