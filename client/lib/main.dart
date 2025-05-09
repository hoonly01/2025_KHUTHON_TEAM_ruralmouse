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
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const DetailCreatePage()),
                        );
                      },
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

// 주문/결제 화면
class OrderPage extends StatefulWidget {
  final String productName;
  const OrderPage({super.key, required this.productName});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  int quantity = 1;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController detailAddressController = TextEditingController();

  int get productPrice => 35000;
  int get shippingFee => 3000;
  int get totalPrice => productPrice * quantity + shippingFee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('주문/결제', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 주문 상품
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/images/apple.png',
                        width: 56,
                        height: 56,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.productName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 2),
                          const Text('5kg', style: TextStyle(color: Colors.grey, fontSize: 13)),
                          const SizedBox(height: 2),
                          const Text('₩35,000', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () {
                            setState(() {
                              if (quantity > 1) quantity--;
                            });
                          },
                        ),
                        Text('$quantity', style: const TextStyle(fontSize: 16)),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          onPressed: () {
                            setState(() {
                              quantity++;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              // 배송 정보
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('배송 정보', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    const SizedBox(height: 12),
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: '받는 분',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: '연락처',
                        hintText: '010-0000-0000',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: addressController,
                            decoration: const InputDecoration(
                              labelText: '주소',
                              border: OutlineInputBorder(),
                              isDense: true,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          height: 44,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[200],
                              foregroundColor: Colors.black,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text('검색'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: detailAddressController,
                      decoration: const InputDecoration(
                        labelText: '상세주소',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              // 결제 방법
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('결제 방법', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                          foregroundColor: Colors.black,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          minimumSize: const Size(0, 36),
                          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        ),
                        onPressed: () {},
                        child: const Text(
                          '디지털 온누리 상품권 사용',
                          style: TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              side: const BorderSide(color: Colors.grey),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              minimumSize: const Size(0, 36),
                              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                            ),
                            onPressed: () {},
                            child: const Text(
                              '신용카드',
                              style: TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              side: const BorderSide(color: Colors.grey),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              minimumSize: const Size(0, 36),
                              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                            ),
                            onPressed: () {},
                            child: const Text(
                              '무통장 입금',
                              style: TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              side: const BorderSide(color: Colors.grey),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              minimumSize: const Size(0, 36),
                              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                            ),
                            onPressed: () {},
                            child: const Text(
                              '휴대폰 결제',
                              style: TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              // 결제 금액
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('결제 금액', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('상품 금액', style: TextStyle(fontSize: 15)),
                        Text('₩${productPrice * quantity}', style: const TextStyle(fontSize: 15)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('배송비', style: TextStyle(fontSize: 15)),
                        Text('₩$shippingFee', style: const TextStyle(fontSize: 15)),
                      ],
                    ),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('총 결제 금액', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Text('₩$totalPrice', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.green)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              // 결제하기 버튼
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text('결제하기', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 상세 화면 작성 페이지
class DetailCreatePage extends StatelessWidget {
  const DetailCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('판매글 작성', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            _SelectBox(
              title: 'PDF 첨부하기',
              subtitle: '직접 만드신 상품 소개서의\nPDF를 첨부해주세요.',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const PdfUploadPage()),
                );
              },
            ),
            const SizedBox(height: 32),
            _SelectBox(
              title: '자동으로 생성하기',
              subtitle: '사진과 음성을 통해서 자동으로\n상품의 상세 화면을 생성해드려요.',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectBox extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const _SelectBox({required this.title, required this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 56, horizontal: 20),
        constraints: const BoxConstraints(minHeight: 160),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            const SizedBox(height: 18),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// PDF 첨부 페이지
class PdfUploadPage extends StatefulWidget {
  const PdfUploadPage({super.key});

  @override
  State<PdfUploadPage> createState() => _PdfUploadPageState();
}

class _PdfUploadPageState extends State<PdfUploadPage> {
  String? fileName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('PDF 첨부', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            // PDF 업로드 큰 박스
            Container(
              padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300, width: 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.picture_as_pdf, color: Colors.red, size: 40),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    fileName ?? '첨부된 PDF가 없습니다.',
                    style: TextStyle(
                      fontSize: 16,
                      color: fileName == null ? Colors.grey : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                        foregroundColor: Colors.black,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          fileName = '상품소개서.pdf';
                        });
                      },
                      child: const Text('PDF 업로드', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: fileName == null
                    ? null
                    : () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const PriceSettingPage()),
                        );
                      },
                child: const Text('업로드 완료', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 가격 설정 페이지
class PriceSettingPage extends StatefulWidget {
  const PriceSettingPage({super.key});

  @override
  State<PriceSettingPage> createState() => _PriceSettingPageState();
}

class _PriceSettingPageState extends State<PriceSettingPage> {
  final TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('가격 설정', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text('상품 가격을 입력해 주세요.', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: '가격 (원)',
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // 가격 저장 및 다음 단계로 이동 로직
                },
                child: const Text('다음', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}