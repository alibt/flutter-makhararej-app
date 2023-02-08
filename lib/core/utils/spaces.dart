// ignore_for_file: constant_identifier_names

import 'package:flutter/widgets.dart';

import '../theming/sizes.dart';

class Spaces {
  static const VERTICAL_XS = Padding(padding: EdgeInsets.only(top: Sizes.xs));
  static const VERTICAL_S = Padding(padding: EdgeInsets.only(top: Sizes.s));
  static const VERTICAL_M = Padding(padding: EdgeInsets.only(top: Sizes.m));
  static const VERTICAL_L = Padding(padding: EdgeInsets.only(top: Sizes.l));
  static const VERTICAL_XL = Padding(padding: EdgeInsets.only(top: Sizes.l));

  static const HORIZONTAL_S = Padding(padding: EdgeInsets.only(right: Sizes.s));
  static const HORIZONTAL_XS =
      Padding(padding: EdgeInsets.only(right: Sizes.xs));
  static const HORIZONTAL_M = Padding(padding: EdgeInsets.only(right: Sizes.m));
}
