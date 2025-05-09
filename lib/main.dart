import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

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

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: const Text(
          '[KF365] 유명산지 고당도 사과',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          Image.asset(
            'assets/images/apple.png',
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              '[KF365] 유명산지 고당도사과 1.5kg (5~6입)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '아삭아삭 달콤한 제철 과일',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text('원산지: 국산', style: TextStyle(fontSize: 14)),
          ),
          const Divider(height: 32),
          // 상품정보 등 상세 설명은 기존 심플 버전으로 유지
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.favorite_border),
              onPressed: () {},
            ),
            const SizedBox(width: 8),
            Expanded(
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // 구매하기 로직
                  },
                  child: const Text("구매하기", style: TextStyle(fontSize: 16)),
                ),
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
  String search = '';
  bool showAppleRegion = false;
  bool showFarmPins = false;

  // 경상북도(사과 유명) 폴리곤 예시 좌표 (실제와 다름)
  final List<LatLng> gyeongbukPolygon = [
    LatLng(36.5, 128.0),
    LatLng(36.7, 129.0),
    LatLng(36.2, 129.2),
    LatLng(35.7, 128.8),
    LatLng(35.8, 128.0),
    LatLng(36.1, 127.8),
    LatLng(36.5, 128.0),
  ];

  // 농가 마커 예시 좌표
  final List<LatLng> farmPins = [
    LatLng(36.4, 128.4),
    LatLng(36.0, 128.6),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: TextField(
          decoration: InputDecoration(
            hintText: '상품을 검색하세요',
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (value) {
            setState(() {
              search = value;
              showAppleRegion = value.contains('사과');
              showFarmPins = false;
            });
          },
          onSubmitted: (value) {
            if (value.contains('사과')) {
              setState(() {
                showAppleRegion = true;
                showFarmPins = false;
              });
            }
          },
        ),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(36.5, 128.5),
          zoom: 7.2,
          onTap: (tapPosition, point) {
            if (showAppleRegion && _pointInPolygon(point, gyeongbukPolygon)) {
              setState(() {
                showFarmPins = true;
              });
            }
          },
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png',
            subdomains: ['a', 'b', 'c', 'd'],
            userAgentPackageName: 'com.example.app',
          ),
          if (showAppleRegion)
            PolygonLayer(
              polygons: [
                Polygon(
                  points: gyeongbukPolygon,
                  color: Colors.red.withOpacity(0.4),
                  borderStrokeWidth: 2,
                  borderColor: Colors.red,
                ),
              ],
            ),
          if (showFarmPins)
            MarkerLayer(
              markers: farmPins
                  .map(
                    (pin) => Marker(
                      width: 40,
                      height: 40,
                      point: pin,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const ProductDetailPage()),
                          );
                        },
                        child: Icon(Icons.location_on, color: Colors.green, size: 36),
                      ),
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }

  // 폴리곤 내부 클릭 판정 (Ray-casting 알고리즘)
  bool _pointInPolygon(LatLng point, List<LatLng> polygon) {
    int intersectCount = 0;
    for (int j = 0; j < polygon.length - 1; j++) {
      if (_rayCastIntersect(point, polygon[j], polygon[j + 1])) {
        intersectCount++;
      }
    }
    return (intersectCount % 2) == 1;
  }

  bool _rayCastIntersect(LatLng point, LatLng vertA, LatLng vertB) {
    double aY = vertA.latitude;
    double bY = vertB.latitude;
    double aX = vertA.longitude;
    double bX = vertB.longitude;
    double pY = point.latitude;
    double pX = point.longitude;

    if ((aY > pY && bY > pY) || (aY < pY && bY < pY) || (aX < pX && bX < pX)) {
      return false;
    }
    double m = (bY - aY) / (bX - aX);
    double bee = -aX * m + aY;
    double x = (pY - bee) / m;
    return x > pX;
  }
}