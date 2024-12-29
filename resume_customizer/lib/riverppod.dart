import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fontSizeProvider = StateProvider<double>((ref) => 12.0);
final fontColorProvider = StateProvider<Color>((ref) => Colors.black);
final backgroundColorProvider = StateProvider<Color>((ref) => Colors.white);
