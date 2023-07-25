import 'package:flutter/material.dart';
import 'package:flutter_starter/app_dependencies.dart';
import 'package:flutter_starter/app_pages/page_layout.dart';
import 'package:flutter_starter/forecast/forecast_page.dart';
import 'package:flutter_starter/forecast/forecasts_repository.dart';
import 'package:flutter_starter/location_search/location_search_api.dart';
import 'package:flutter_starter/location_search/location_search_page.dart';

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
    _forecastsRepo = ForecastsRepository(appDependencies);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const PageLayout(title: ''),
        Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: _updatePage,
                children: [
                  PageLayout(
                    title: 'Add Location',
                    body: LocationSearchPage(onSelect: _addToLocations),
                  ),
                  ..._locations.map(
                    (location) => PageLayout(
                      title: location.name,
                      body: ForecastPage(_buildLocationForecast(context, location)),
                      actions: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline_outlined),
                          tooltip: 'Remove',
                          onPressed: () => _removeLocation(location),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            PagingIndicator(
              locationCount: _locations.length,
              currentPage: _page,
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            padding: const EdgeInsets.only(right: 16, bottom: 100),
            child: _buildFloatingActionButton(),
          ),
        )
      ],
    );
  }

  void _updatePage(int newPage) {
    setState(() {
      _page = newPage;
    });
  }

  Widget _buildFloatingActionButton() {
    return AnimatedScale(
      scale: _page == searchPage ? 0 : 1,
      duration: const Duration(milliseconds: 500),
      curve: Curves.bounceInOut,
      child: FloatingActionButton(
        onPressed: () => _animateToPage(searchPage),
        child: const Icon(Icons.search, semanticLabel: 'Go to search'),
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

  void _removeLocation(ApiLocation location) {
    _animateToPage(searchPage);

    final previousIndex = _locations.indexOf(location);

    setState(() {
      _locations.remove(location);
    });

    final snackBar = SnackBar(
      content: const Text('Location removed'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          setState(() {
            _locations.insert(previousIndex, location);
          });

          _animateToPage(previousIndex + 1);
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
