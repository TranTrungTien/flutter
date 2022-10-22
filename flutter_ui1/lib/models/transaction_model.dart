import 'package:flutter/material.dart';

class Transaction {
  String title;
  String subtitle;
  double price;
  IconData icon;

  Transaction(this.title, this.subtitle, this.price, this.icon);
}