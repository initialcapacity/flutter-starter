import 'package:flutter/material.dart';
import 'package:flutter_starter/open_meteo/open_meteo_api.dart';

class LocationDetailsPage extends StatefulWidget {
  const LocationDetailsPage(this.location, {super.key});

  final Location location;

  @override
  State<StatefulWidget> createState() => _LocationDetailsPageState();
}

class _LocationDetailsPageState extends State<LocationDetailsPage> {
  _LocationDetailsPageState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final location = widget.location;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.inversePrimary,
        title: const Text('Location Details'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(location.name, style: textTheme.titleMedium),
          Text(location.region, style: textTheme.labelMedium),
        ],
      ),
    );
  }
}
