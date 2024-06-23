//import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

buildTitle36(String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: TextStyle(
          fontSize: 36, fontWeight: FontWeight.w900, color: Colors.black),
    ),
  );
}

buildTitle24Variation(String text, bool opacity) {
  return Padding(
    padding: EdgeInsets.only(bottom: 16),
    child: Text(
      text,
      style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: opacity ? Colors.grey[600] : Colors.black),
    ),
  );
}

buildTitle16Variation(String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[600]),
    ),
  );
}

buildTitle16Variation2Overflow(String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[600]),
    ),
  );
}

buildRecipeTitle22(String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: 22, fontWeight: FontWeight.bold, color: Colors.grey[600]),
    ),
  );
}
