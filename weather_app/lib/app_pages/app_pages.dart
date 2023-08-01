import 'package:flutter/material.dart';
import 'package:weather_app/app_dependencies.dart';
import 'package:weather_app/forecast/forecast_page.dart';
import 'package:weather_app/forecast/forecasts_repository.dart';
import 'package:weather_app/location_search/location_search_api.dart';
import 'package:weather_app/location_search/location_search_page.dart';

import 'paging_indicator.dart';

final class AppPages extends StatefulWidget {
  const AppPages({super.key});

  @override
  State<StatefulWidget> createState() => _AppPagesState();
}

final class _AppPagesState extends State<AppPages> {
  static const searchPage = 0;

  final ApiLocation _boulder = const ApiLocation(
    name: 'Boulder',
    region: 'Colorado',
    latitude: 40.01499,
    longitude: -105.27055,
  );

  late List<ApiLocation> _locations;
  final PageController _pageController = PageController(initialPage: 1);
  late ForecastsRepository _forecastsRepo;

  int _page = 1;

  @override
  void initState() {
    super.initState();
    final appDependencies = context.appDependencies();

    _locations = [_boulder];
    _forecastsRepo = ForecastsRepository(
      appDependencies.httpClientProvider,
      appDependencies.asyncCompute,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        titleTextStyle: textTheme.titleLarge?.copyWith(color: colorScheme.onPrimary),
        title: Text(
          _pageTitle(),
          textScaleFactor: 1.5,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: _buildActions(),
        toolbarHeight: 80,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _updatePage,
        children: [
          LocationSearchPage(onSelect: _addToLocations),
          ..._locations.map((location) => ForecastPage(_buildLocationForecast(context, location))),
        ],
      ),
      bottomNavigationBar: PagingIndicator(
        locationCount: _locations.length,
        currentPage: _page,
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  String _pageTitle() {
    if (_page == 0) {
      return 'Add Location';
    }

    final locationIndex = _page - 1;

    return _locations.elementAtOrNull(locationIndex)?.name ?? '';
  }

  List<Widget>? _buildActions() {
    if (_page == 0) {
      return null;
    }

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return [
      IconButton(
        icon: Icon(Icons.remove_circle_outline_outlined, color: colorScheme.onPrimary),
        tooltip: 'Remove',
        onPressed: () => _removeLocation(_page),
      ),
    ];
  }

  void _updatePage(int newPage) {
    setState(() {
      _page = newPage;
      if (newPage > 0) {
        FocusManager.instance.primaryFocus?.unfocus();
      }
    });
  }

  Widget _buildFloatingActionButton() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AnimatedScale(
      scale: _page == searchPage ? 0 : 1,
      duration: const Duration(milliseconds: 500),
      curve: Curves.bounceInOut,
      child: FloatingActionButton(
        onPressed: () => _animateToPage(searchPage),
        backgroundColor: colorScheme.tertiary,
        child: Icon(Icons.search, semanticLabel: 'Go to search', color: colorScheme.onTertiary),
      ),
    );
  }

  LocationForecast _buildLocationForecast(BuildContext context, ApiLocation location) {
    return LocationForecast(location, _forecastsRepo.fetch(location));
  }

  void _addToLocations(ApiLocation location) {
    setState(() {
      _locations.add(location);
      _page = _locations.length;
    });

    _animateToPage(_locations.length);
  }

  void _removeLocation(int page) {
    _animateToPage(page - 1);

    final locationIndex = page - 1;
    final location = _locations[locationIndex];

    setState(() {
      _locations.removeAt(locationIndex);
    });

    final snackBar = SnackBar(
      content: const Text('Location removed'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          setState(() {
            _locations.insert(locationIndex, location);
          });

          _animateToPage(page);
        },
      ),
    );

    final messenger = ScaffoldMessenger.of(context);
    messenger.showSnackBar(snackBar);
  }

  void _animateToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }
}
