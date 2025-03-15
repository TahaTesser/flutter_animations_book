import 'package:flutter/material.dart';

class CurveItem {
  final Curve curve;
  final String label;

  const CurveItem(this.curve, this.label);
}

final List<CurveItem> curveItems = [
  // Easings.
  CurveItem(Easing.emphasizedAccelerate, 'emphasizedAccelerate'),
  CurveItem(Easing.emphasizedDecelerate, 'emphasizedDecelerate'),
  CurveItem(Easing.legacy, 'legacy'),
  CurveItem(Easing.legacyAccelerate, 'legacyAccelerate'),
  CurveItem(Easing.legacyDecelerate, 'legacyDecelerate'),
  CurveItem(Easing.linear, 'linear'),
  CurveItem(Easing.standard, 'standard'),
  CurveItem(Easing.standardAccelerate, 'standardAccelerate'),
  CurveItem(Easing.standardDecelerate, 'standardDecelerate'),
  // Curves.
  CurveItem(Curves.linear, 'linear'),
  CurveItem(Curves.decelerate, 'decelerate'),
  CurveItem(Curves.ease, 'ease'),
  CurveItem(Curves.easeIn, 'easeIn'),
  CurveItem(Curves.easeInOut, 'easeInOut'),
  CurveItem(Curves.easeOut, 'easeOut'),
  CurveItem(Curves.fastEaseInToSlowEaseOut, 'fastEaseInToSlowEaseOut'),
  CurveItem(Curves.fastLinearToSlowEaseIn, 'fastLinearToSlowEaseIn'),
  CurveItem(Curves.fastOutSlowIn, 'fastOutSlowIn'),
  CurveItem(Curves.linearToEaseOut, 'linearToEaseOut'),
  CurveItem(Curves.slowMiddle, 'slowMiddle'),
  CurveItem(Curves.bounceIn, 'bounceIn'),
  CurveItem(Curves.bounceInOut, 'bounceInOut'),
  CurveItem(Curves.bounceOut, 'bounceOut'),
  CurveItem(Curves.easeInBack, 'easeInBack'),
  CurveItem(Curves.easeInCirc, 'easeInCirc'),
  CurveItem(Curves.easeInCubic, 'easeInCubic'),
  CurveItem(Curves.easeInExpo, 'easeInExpo'),
  CurveItem(Curves.easeInOutBack, 'easeInOutBack'),
  CurveItem(Curves.easeInOutCirc, 'easeInOutCirc'),
  CurveItem(Curves.easeInOutCubic, 'easeInOutCubic'),
  CurveItem(Curves.easeInOutCubicEmphasized, 'easeInOutCubicEmphasized'),
  CurveItem(Curves.easeInOutExpo, 'easeInOutExpo'),
  CurveItem(Curves.easeInOutQuad, 'easeInOutQuad'),
  CurveItem(Curves.easeInOutQuart, 'easeInOutQuart'),
  CurveItem(Curves.easeInOutQuint, 'easeInOutQuint'),
  CurveItem(Curves.easeInOutSine, 'easeInOutSine'),
  CurveItem(Curves.easeInQuad, 'easeInQuad'),
  CurveItem(Curves.easeInQuart, 'easeInQuart'),
  CurveItem(Curves.easeInQuint, 'easeInQuint'),
  CurveItem(Curves.easeInSine, 'easeInSine'),
  CurveItem(Curves.easeInToLinear, 'easeInToLinear'),
  CurveItem(Curves.easeOutBack, 'easeOutBack'),
  CurveItem(Curves.easeOutCirc, 'easeOutCirc'),
  CurveItem(Curves.easeOutCubic, 'easeOutCubic'),
  CurveItem(Curves.easeOutExpo, 'easeOutExpo'),
  CurveItem(Curves.easeOutQuad, 'easeOutQuad'),
  CurveItem(Curves.easeOutQuart, 'easeOutQuart'),
  CurveItem(Curves.easeOutQuint, 'easeOutQuint'),
  CurveItem(Curves.easeOutSine, 'easeOutSine'),
  CurveItem(Curves.elasticIn, 'elasticIn'),
  CurveItem(Curves.elasticInOut, 'elasticInOut'),
  CurveItem(Curves.elasticOut, 'elasticOut'),
];