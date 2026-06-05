// import 'package:flutter/material.dart';
//
// extension SpacingExtension on num {
//   // --- Widgets d'espacement classiques ---
//   Widget get height => SizedBox(height: toDouble());
//   Widget get width => SizedBox(width: toDouble());
//
//   // --- Widgets d'espacement pour Slivers (CustomScrollView) ---
//   // Très utile pour ta HomeScreen !
//   Widget get sHeight => SliverToBoxAdapter(child: SizedBox(height: toDouble()));
//   Widget get sWidth => SliverToBoxAdapter(child: SizedBox(width: toDouble()));
//
//   // --- Raccourcis pour les Paddings (EdgeInsets) ---
//   EdgeInsets get all => EdgeInsets.all(toDouble());
//   EdgeInsets get horizontal => EdgeInsets.symmetric(horizontal: toDouble());
//   EdgeInsets get vertical => EdgeInsets.symmetric(vertical: toDouble());
//   EdgeInsets get top => EdgeInsets.only(top: toDouble());
//   EdgeInsets get bottom => EdgeInsets.only(bottom: toDouble());
// }