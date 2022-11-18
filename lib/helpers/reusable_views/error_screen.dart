import 'package:flutter/material.dart';
import 'package:movie_libs/helpers/networking/error_model.dart';

class ErrorScreen extends StatelessWidget {
  final TMDBError error;

  const ErrorScreen({
    super.key,
    required this.error,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.warning,
              size: 150,
              color: Colors.red,
            ),
            Text(
              'Error ${error.statusCode}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(error.statusMessage ?? error.errors[0]),
          ],
        ),
      ),
    );
  }
}
