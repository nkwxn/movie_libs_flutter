import 'package:flutter/material.dart';

class MovieDetailInfoCard extends StatelessWidget {
  final String title;
  final Widget content;
  const MovieDetailInfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Card(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                Container(padding: const EdgeInsets.only(top: 10.0), child: content),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
