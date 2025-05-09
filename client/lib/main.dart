import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:ui' as ui;

class Farm {
  final LatLng location;
  final String name;
  Farm(this.location, this.name);
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: GestureDetector(
          onTap: () {
            Future.delayed(const Duration(milliseconds: 400), () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const IntroScreen()),
              );
            });
          },
          child: CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child: Icon(Icons.eco, color: Colors.green, size: 48),
          ),
        ),
      ),
    );
  }
}

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF5FFF8),
              Color(0xFFE0F7EF),
            ],
          ),
        ),
        child: Stack(
          children: [
            // 여러 개의 작은 leaf 이미지 배경에 흩뿌리기
            Positioned(
              top: 40,
              left: 24,
              child: Opacity(
                opacity: 0.22,
                child: Transform.rotate(
                  angle: -0.2,
                  child: Image.asset('assets/images/leaf.png', width: 38),
                ),
              ),
            ),
            Positioned(
              top: 100,
              right: 32,
              child: Opacity(
                opacity: 0.18,
                child: Transform.rotate(
                  angle: 0.3,
                  child: Image.asset('assets/images/leaf.png', width: 44),
                ),
              ),
            ),
            Positioned(
              top: 200,
              left: 80,
              child: Opacity(
                opacity: 0.15,
                child: Transform.rotate(
                  angle: 0.7,
                  child: Image.asset('assets/images/leaf.png', width: 32),
                ),
              ),
            ),
            Positioned(
              bottom: 120,
              left: 32,
              child: Opacity(
                opacity: 0.28,
                child: Transform.rotate(
                  angle: -0.5,
                  child: Image.asset('assets/images/leaf.png', width: 36),
                ),
              ),
            ),
            Positioned(
              bottom: 60,
              right: 24,
              child: Opacity(
                opacity: 0.21,
                child: Transform.rotate(
                  angle: 0.9,
                  child: Image.asset('assets/images/leaf.png', width: 40),
                ),
              ),
            ),
            Positioned(
              bottom: 200,
              right: 80,
              child: Opacity(
                opacity: 0.19,
                child: Transform.rotate(
                  angle: -0.8,
                  child: Image.asset('assets/images/leaf.png', width: 30),
                ),
              ),
            ),
            Positioned(
              top: 300,
              right: 20,
              child: Opacity(
                opacity: 0.16,
                child: Transform.rotate(
                  angle: 0.5,
                  child: Image.asset('assets/images/leaf.png', width: 60),
                ),
              ),
            ),
            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.15),
                          blurRadius: 24,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(18),
                    child: Icon(Icons.eco, color: Colors.green, size: 48),
                  ),
                  const SizedBox(height: 36),
                  Text(
                    '농가에서 직접\n배송해드립니다',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    '농가와 소비자를 바로 잇는 신선한 연결',
                    style: TextStyle(color: Colors.grey[600], fontSize: 15),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: 220,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        elevation: 6,
                        shadowColor: Colors.green.withOpacity(0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const MapSearchPage()),
                        );
                      },
                      child: Text('구매', style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 220,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        elevation: 6,
                        shadowColor: Colors.green.withOpacity(0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {},
                      child: Text('판매', style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MapSearchPage extends StatefulWidget {
  const MapSearchPage({super.key});

  @override
  State<MapSearchPage> createState() => _MapSearchPageState();
}

class _MapSearchPageState extends State<MapSearchPage> {
  String selectedCategory = '';
  final MapController _mapController = MapController();

  // 카테고리별 지역 폴리곤 (예시, 실제 좌표는 필요시 수정)
  final Map<String, List<LatLng>> categoryPolygons = {
    '사과': [
      LatLng(36.5, 128.0), LatLng(36.7, 129.0), LatLng(36.2, 129.2), LatLng(35.7, 128.8), LatLng(35.8, 128.0), LatLng(36.1, 127.8), LatLng(36.5, 128.0),
    ], // 경상북도
    '복숭아': [
      LatLng(36.5, 127.0), LatLng(36.7, 127.5), LatLng(36.2, 127.7), LatLng(35.7, 127.3), LatLng(35.8, 127.0), LatLng(36.1, 126.8), LatLng(36.5, 127.0),
    ], // 충남(예시)
    '포도': [
      LatLng(36.2, 128.0), LatLng(36.4, 128.7), LatLng(35.9, 128.9), LatLng(35.5, 128.5), LatLng(35.7, 128.0), LatLng(36.0, 127.7), LatLng(36.2, 128.0),
    ], // 경북(예시)
    '귤': [
      LatLng(33.3, 126.2), LatLng(33.5, 126.7), LatLng(33.2, 126.9), LatLng(33.1, 126.5), LatLng(33.3, 126.2),
    ], // 제주(예시)
  };

  // 카테고리별 중심 좌표와 줌
  final Map<String, LatLng> categoryCenters = {
    '사과': LatLng(36.5, 128.5),
    '복숭아': LatLng(36.3, 127.2),
    '포도': LatLng(36.1, 128.5),
    '귤': LatLng(33.4, 126.5),
  };
  final Map<String, double> categoryZooms = {
    '사과': 8.0,
    '복숭아': 8.0,
    '포도': 8.0,
    '귤': 9.0,
  };

  // 2. 농가 마커에 이름 포함
  final Map<String, List<Farm>> categoryFarms = {
    '사과': [Farm(LatLng(36.4, 128.4), '경북사과농장'), Farm(LatLng(36.0, 128.6), '청송사과팜')],
    '복숭아': [Farm(LatLng(36.3, 127.2), '충남복숭아농장')],
    '포도': [Farm(LatLng(36.1, 128.5), '경북포도농장')],
    '귤': [Farm(LatLng(33.4, 126.6), '제주귤농장')],
  };

  final List<String> categories = [
    '사과', '복숭아', '포도', '귤', '배', '자두', '감', '딸기', '참외', '수박', '멜론', '블루베리', '오렌지', '레몬', '체리'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('농가 지도 검색', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // 지도
          Positioned.fill(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                center: selectedCategory.isNotEmpty && categoryCenters[selectedCategory] != null
                    ? categoryCenters[selectedCategory]!
                    : LatLng(36.5, 127.8),
                zoom: selectedCategory.isNotEmpty && categoryZooms[selectedCategory] != null
                    ? categoryZooms[selectedCategory]!
                    : 6.5,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                if (selectedCategory.isNotEmpty && categoryPolygons[selectedCategory] != null)
                  PolygonLayer(
                    polygons: [
                      Polygon(
                        points: categoryPolygons[selectedCategory]!,
                        color: Colors.green.withOpacity(0.22),
                        borderStrokeWidth: 2,
                        borderColor: Colors.green,
                      ),
                    ],
                  ),
                if (selectedCategory.isNotEmpty && categoryFarms[selectedCategory] != null)
                  MarkerLayer(
                    markers: categoryFarms[selectedCategory]!
                        .map(
                          (farm) => Marker(
                            width: 120,
                            height: 40,
                            point: farm.location,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.location_on, color: Colors.green, size: 36),
                                SizedBox(width: 4),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.85),
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.07),
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    farm.name,
                                    style: TextStyle(fontSize: 12, color: Colors.green[900], fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
              ],
            ),
          ),
          // 지도 위에 오버레이 (사과, 복숭아, 포도)
          if (['사과', '복숭아', '포도'].contains(selectedCategory) && categoryPolygons[selectedCategory] != null)
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(
                  painter: _BlurExceptPolygonPainter(categoryPolygons[selectedCategory]!, _mapController),
                ),
              ),
            ),
          // 카테고리 바 (지도 위에 둥둥)
          Positioned(
            top: kToolbarHeight - 50,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  for (final cat in categories) ...[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = cat;
                        });
                        if (categoryCenters.containsKey(cat)) {
                          _mapController.move(
                            categoryCenters[cat]!,
                            categoryZooms[cat]!,
                          );
                        }
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 180),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: selectedCategory == cat ? Colors.green : Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.green),
                          boxShadow: selectedCategory == cat
                              ? [BoxShadow(color: Colors.green.withOpacity(0.10), blurRadius: 8, offset: Offset(0, 2))]
                              : [],
                        ),
                        child: Text(
                          cat,
                          style: TextStyle(
                            color: selectedCategory == cat ? Colors.white : Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ]
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BlurExceptPolygonPainter extends CustomPainter {
  final List<LatLng> polygon;
  final MapController mapController;

  _BlurExceptPolygonPainter(this.polygon, this.mapController);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.7)
      ..style = PaintingStyle.fill;

    // 전체 사각형
    final rectPath = ui.Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // 폴리곤(경상북도) 영역 (여기만 투명하게)
    final polyPath = ui.Path();
    if (polygon.isNotEmpty) {
      final first = mapController.latLngToScreenPoint(polygon.first);
      polyPath.moveTo(first.x, first.y);
      for (final latlng in polygon.skip(1)) {
        final pt = mapController.latLngToScreenPoint(latlng);
        polyPath.lineTo(pt.x, pt.y);
      }
      polyPath.close();
    }

    // 전체에서 폴리곤 부분만 빼기
    final mask = ui.Path.combine(ui.PathOperation.difference, rectPath, polyPath);

    canvas.drawPath(mask, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}