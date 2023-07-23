import 'package:flutter/material.dart';
import 'package:flutter_starter/app_dependencies.dart';
import 'package:flutter_starter/app_pages/page_layout.dart';
import 'package:flutter_starter/forecast/forecast_api.dart';
import 'package:flutter_starter/forecast/forecast_page.dart';
import 'package:flutter_starter/location_search/location_search_api.dart';
import 'package:flutter_starter/location_search/location_search_page.dart';

import 'paging_indicator.dart';

final class AppPages extends StatefulWidget {
  const AppPages({super.key});

  @override
  State<StatefulWidget> createState() => _AppPagesState();
}

final class _AppPagesState extends State<AppPages> {
  final List<ApiLocation> _locations = [];
  final PageController _controller = PageController();

  int _page = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final newPage = _controller.page?.round() ?? 0;

      setState(() {
        _page = newPage;
      });
    });
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
                controller: _controller,
                children: [
                  PageLayout(
                    title: 'Add Location',
                    body: LocationSearchPage(onSelect: _addToLocations),
                  ),
                  ..._locations.map(
                    (location) => PageLayout(
                      title: location.name,
                      body: ForecastPage(_buildLocationForecast(context, location)),
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
        )
      ],
    );
  }

  LocationForecast _buildLocationForecast(BuildContext context, ApiLocation location) {
    final appDependencies = context.appDependencies();
    return LocationForecast(location, fetchForecast(appDependencies, location));
  }

  void _addToLocations(ApiLocation location) {
    setState(() {
      _locations.add(location);
      _page = _locations.length;
    });

    _controller.animateToPage(
      _locations.length,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }
}
