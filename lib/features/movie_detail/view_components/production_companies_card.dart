import 'package:flutter/material.dart';

class ProductionCompanyCard extends StatelessWidget {
  const ProductionCompanyCard({
    super.key,
    required this.imageUrl,
    required this.name
  });

  final String imageUrl;
  final String name;

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
          color: appTheme.colorScheme.background,
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Flexible(child: Image.network(imageUrl)),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(name),
          ),
        ],
      ),
    );
  }
}
