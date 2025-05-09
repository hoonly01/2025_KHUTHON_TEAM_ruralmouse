import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:ui' as ui;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
                          MaterialPageRoute(builder: (_) => const SellInputPage()),
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

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final ScrollController _scrollController = ScrollController();
  final List<String> _tabs = ['상품설명', '상세정보', '후기 0', '문의'];
  int _selectedTab = 0;

  final _descKey = GlobalKey();
  final _detailKey = GlobalKey();
  final _reviewKey = GlobalKey();
  final _qnaKey = GlobalKey();
  final _listViewKey = GlobalKey();

  // 각 섹션의 위치를 저장
  final Map<int, double> _sectionOffsets = {};

  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) => _calculateSectionOffsets());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _calculateSectionOffsets() {
    _sectionOffsets.clear();
    RenderBox? box1 = _descKey.currentContext?.findRenderObject() as RenderBox?;
    RenderBox? box2 = _detailKey.currentContext?.findRenderObject() as RenderBox?;
    RenderBox? box3 = _reviewKey.currentContext?.findRenderObject() as RenderBox?;
    RenderBox? box4 = _qnaKey.currentContext?.findRenderObject() as RenderBox?;
    _sectionOffsets[0] = box1?.localToGlobal(Offset.zero)?.dy ?? 0 + _scrollController.offset;
    _sectionOffsets[1] = box2?.localToGlobal(Offset.zero)?.dy ?? 0 + _scrollController.offset;
    _sectionOffsets[2] = box3?.localToGlobal(Offset.zero)?.dy ?? 0 + _scrollController.offset;
    _sectionOffsets[3] = box4?.localToGlobal(Offset.zero)?.dy ?? 0 + _scrollController.offset;
  }

  void _onScroll() {
    if (_selectedTab >= 2) return;
    double scrollOffset = 0;
    int newTab = 0;
    for (int i = 0; i < 2; i++) {
      double? start = _sectionOffsets[i];
      double? end = (i + 1 < 2) ? _sectionOffsets[i + 1] : double.infinity;
      if (start != null && end != null && scrollOffset >= start && scrollOffset < end) {
        newTab = i;
        break;
      }
    }
    if (newTab != _selectedTab) {
      setState(() {
        _selectedTab = newTab;
      });
    }
  }

  void _scrollToSection(int idx) {
    if (idx < 2) {
    final offset = _sectionOffsets[idx];
    if (offset != null) {
      _scrollController.animateTo(
        offset - 80, // AppBar, 탭바 높이만큼 보정
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
      }
      setState(() => _selectedTab = idx);
    } else {
      setState(() => _selectedTab = idx);
    }
  }

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
        title: const Text(
          '춘산과수원',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // 탭바
          Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_tabs.length, (idx) {
                final selected = _selectedTab == idx;
                return GestureDetector(
                  onTap: () => _scrollToSection(idx),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: selected ? Colors.green : Colors.transparent,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Text(
                      _tabs[idx],
                      style: TextStyle(
                        color: selected ? Colors.green : Colors.grey[700],
                        fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                        fontSize: 15,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          Expanded(
            child: Builder(
              builder: (context) {
                if (_selectedTab == 0 || _selectedTab == 1) {
                  // 상품설명/상세정보는 기존처럼 스크롤 연동
                  return NotificationListener<ScrollEndNotification>(
              onNotification: (_) {
                WidgetsBinding.instance.addPostFrameCallback((_) => _calculateSectionOffsets());
                return false;
              },
              child: ListView(
                      key: _listViewKey,
                controller: _scrollController,
                padding: EdgeInsets.zero,
                children: [
                  // 상품 이미지
                  Image.asset(
                    'assets/images/apple.png',
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                  ),
                  // 상품 정보 카드
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('유명산지 고당도 사과 5kg',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Text('아삭아삭 달콤한 제철 과일',
                            style: TextStyle(fontSize: 14, color: Colors.grey)),
                        SizedBox(height: 8),
                        Text('원산지: 국산', style: TextStyle(fontSize: 14)),
                        SizedBox(height: 10),
                        Text('₩35,000', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)),
                      ],
                    ),
                  ),
                  // 상품설명
                  Container(
                    key: _descKey,
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                          child: const ProductOptionTable(),
                  ),
                  // 상세정보
                  Container(
                    key: _detailKey,
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                          child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              'assets/images/detail_sample.png',
                              fit: BoxFit.fitWidth,
                              width: double.infinity,
                            ),
                          ),
                  ),
                  const SizedBox(height: 80), // 하단 버튼 공간 확보
                ],
              ),
                  );
                } else if (_selectedTab == 2) {
                  // 후기
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: Text('등록된 후기가 없습니다.', style: TextStyle(fontSize: 16, color: Colors.grey)),
                    ),
                  );
                } else {
                  // 문의
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: Text('등록된 문의가 없습니다.', style: TextStyle(fontSize: 16, color: Colors.grey)),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: _isFavorite ? Colors.red : Colors.black54,
                ),
                onPressed: () {
                  setState(() {
                    _isFavorite = !_isFavorite;
                  });
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SizedBox(
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => OrderPage(productName: '[KF365] 유명산지 고당도 사과 5kg'),
                      ),
                    );
                  },
                  child: const Text("구매하기", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 쿠팡 스타일 옵션/가격 표 위젯
class ProductOptionTable extends StatefulWidget {
  const ProductOptionTable({super.key});

  @override
  State<ProductOptionTable> createState() => _ProductOptionTableState();
}

class _ProductOptionTableState extends State<ProductOptionTable> {
  int selectedCount = 1;
  final List<int> counts = [1, 2, 3];
  final List<int> prices = [35000, 69840, 103700];
  final List<String?> savings = [null, "2봉 사면 160원 절약", "3봉 사면 1,300원 절약"];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Text("중량 × 수량", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _tab("1kg", false),
              _tab("3kg(중과)", false),
              _tab("5kg(대과)", true),
            ],
          ),
          const Divider(height: 24),
          ...List.generate(counts.length, (i) => ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            leading: Radio<int>(
              value: counts[i],
              groupValue: selectedCount,
              onChanged: (v) => setState(() => selectedCount = v!),
              activeColor: Colors.green,
            ),
            title: Text("${counts[i]}봉", style: const TextStyle(fontWeight: FontWeight.bold)),
            trailing: Text(_formatPrice(prices[i]),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            subtitle: savings[i] != null ? Text(savings[i]!, style: const TextStyle(color: Colors.green, fontSize: 13)) : null,
          )),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 12, bottom: 8),
              child: Text("모든 옵션 보기 >", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tab(String label, bool selected) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: selected ? Colors.green : Colors.grey.shade300,
              width: 2,
            ),
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              color: selected ? Colors.green[900] : Colors.black,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    ) + '원';
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
    '사과': [Farm(LatLng(36.4, 128.4), '춘산과수원'), Farm(LatLng(36.0, 128.6), '청송사과팜')],
    '복숭아': [Farm(LatLng(36.3, 127.2), '치악산복숭아')],
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
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (_) => const ProductDetailPage()),
                                );
                              },
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

  int _selectedPayment = -1; // -1: 아무것도 선택 안됨, 0: 온누리, 1: 신용카드, 2: 무통장, 3: 휴대폰

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
                            onPressed: () async {
                              final result = await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const AddressSearchDemoPage(),
                                ),
                              );
                              if (result != null && result is String) {
                                setState(() {
                                  addressController.text = result;
                                });
                              }
                            },
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
                          backgroundColor: _selectedPayment == 0 ? Colors.green[100] : Colors.white,
                          foregroundColor: Colors.black,
                          elevation: 0,
                          side: BorderSide(color: _selectedPayment == 0 ? Colors.green : Colors.green, width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: const Size(0, 54),
                          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        ),
                        onPressed: () {
                          setState(() => _selectedPayment = 0);
                        },
                        child: const Text(
                          '디지털 온누리 상품권 사용',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _selectedPayment == 1 ? Colors.grey[300] : Colors.white,
                              foregroundColor: Colors.black,
                              side: const BorderSide(color: Colors.grey, width: 1.2),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              minimumSize: const Size(0, 54),
                              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                            ),
                            onPressed: () {
                              setState(() => _selectedPayment = 1);
                            },
                            child: const Text(
                              '신용카드',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _selectedPayment == 2 ? Colors.grey[300] : Colors.white,
                              foregroundColor: Colors.black,
                              side: const BorderSide(color: Colors.grey, width: 1.2),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              minimumSize: const Size(0, 54),
                              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                            ),
                            onPressed: () {
                              setState(() => _selectedPayment = 2);
                            },
                            child: const Text(
                              '무통장 입금',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _selectedPayment == 3 ? Colors.grey[300] : Colors.white,
                              foregroundColor: Colors.black,
                              side: const BorderSide(color: Colors.grey, width: 1.2),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              minimumSize: const Size(0, 54),
                              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                            ),
                            onPressed: () {
                              setState(() => _selectedPayment = 3);
                            },
                            child: const Text(
                              '휴대폰 결제',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
class DetailCreatePage extends StatefulWidget {
  const DetailCreatePage({super.key});

  @override
  State<DetailCreatePage> createState() => _DetailCreatePageState();
}

class _DetailCreatePageState extends State<DetailCreatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('홍보 방법 선택', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 안내 박스
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              margin: const EdgeInsets.only(bottom: 32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.green, width: 2),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '홍보 방법을',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      height: 1.1,
                    ),
                  ),
                  Text(
                    '선택해주세요',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      height: 1.1,
                    ),
                  ),
                ],
              ),
            ),
            // PDF 첨부하기 버튼
            _PromoSelectCard(
              title: 'PDF 첨부하기',
              description: '직접 만든 상품 소개서 PDF를 첨부해 주세요.',
              icon: Icons.picture_as_pdf,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const PdfUploadPage()),
                );
              },
            ),
            const SizedBox(height: 6),
            _PromoSelectCard(
              title: '자동 생성하기',
              description: '사진과 음성으로 상품 소개서를 자동으로 만들어드려요.',
              icon: Icons.auto_awesome,
              onTap: () {
                showAiIntroModal(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget _PromoSelectCard({
  required String title,
  required String description,
  required VoidCallback onTap,
  IconData? icon,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(18),
    child: Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(right: 18),
              child: Icon(icon, color: Colors.green, size: 38),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const GeneratedDetailPage()),
                  );
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

// 판매 상품 입력 페이지
class SellInputPage extends StatefulWidget {
  const SellInputPage({super.key});

  @override
  State<SellInputPage> createState() => _SellInputPageState();
}

class _SellInputPageState extends State<SellInputPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _products = [
    {'name': '사과', 'image': 'assets/images/applem.png'},
    {'name': '바나나', 'image': 'assets/images/bananam.png'},
    {'name': '양배추', 'image': 'assets/images/cabbagem.png'},
    {'name': '가지', 'image': 'assets/images/eggplantm.png'},
  ];
  int? _selectedIndex;

  void _goToNext(String product) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const DetailCreatePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('판매 상품 입력', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 안내 박스: 텍스트 + 이미지, 네모 테두리
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.green, width: 2),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            '판매하려는',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              height: 1.1,
                            ),
                          ),
                          Text(
                            '과일을 선택하세요',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              height: 1.1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      child: Image.asset(
                        'assets/images/fruits.png',
                        height: 110,
                        width: 110,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 2),
              // 카드 UI
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final product = _products[index];
                  final isSelected = _selectedIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                      Future.delayed(const Duration(milliseconds: 120), () => _goToNext(product['name']!));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? Colors.lightGreen : Colors.grey.shade200,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(product['image']!, width: 90, height: 90),
                          const SizedBox(height: 16),
                          Text(
                            product['name']!,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 2),
              const Text('여기에 없다면 직접 입력해 주세요', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
              const SizedBox(height: 4),
              Focus(
                child: Builder(
                  builder: (context) {
                    final hasFocus = Focus.of(context).hasFocus;
                    return TextField(
                      controller: _controller,
                      style: const TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        hintText: '예시) 사과',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: hasFocus ? Colors.green : Colors.grey,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green,
                            width: 2,
                          ),
                        ),
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.play_arrow, color: Colors.green, size: 36),
                          onPressed: () {
                            if (_controller.text.trim().isNotEmpty) {
                              _goToNext(_controller.text.trim());
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AutoGeneratePage extends StatefulWidget {
  const AutoGeneratePage({super.key});

  @override
  State<AutoGeneratePage> createState() => _AutoGeneratePageState();
}

class _AutoGeneratePageState extends State<AutoGeneratePage> {
  bool isRecording = false;
  Duration recordDuration = Duration.zero;
  Timer? _timer;
  List<File> _selectedImages = [];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickMultiImage();
    if (picked != null && picked.isNotEmpty) {
      setState(() {
        _selectedImages.addAll(picked.map((x) => File(x.path)));
      });
    }
  }

  void _startRecording() {
    setState(() {
      isRecording = true;
      recordDuration = Duration.zero;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        recordDuration += const Duration(seconds: 1);
      });
    });
  }

  void _stopRecording() {
    setState(() {
      isRecording = false;
    });
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('자동 생성', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 녹음 꿀팁 안내 박스 (더 크고 강조)
              Container(
                margin: const EdgeInsets.only(bottom: 32),
                padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.green, width: 2),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.lightbulb, color: Colors.amber, size: 40),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            '녹음 꿀팁!',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                '농가의 장점을',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                '전부 다 말해주세요',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // 사진 추가
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    children: [
                      if (_selectedImages.isNotEmpty)
                        SizedBox(
                          height: 120,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: _selectedImages.length,
                            separatorBuilder: (_, __) => const SizedBox(width: 10),
                            itemBuilder: (context, idx) => Stack(
                              children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                                  child: Image.file(_selectedImages[idx], width: 120, height: 120, fit: BoxFit.cover),
                                ),
                                Positioned(
                                  top: 4,
                                  right: 4,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedImages.removeAt(idx);
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Icon(Icons.close, color: Colors.white, size: 20),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else ...[
                        Icon(Icons.add, size: 48, color: Colors.green),
                        const SizedBox(height: 8),
                        Text('사진 추가', style: TextStyle(color: Colors.grey[700], fontSize: 16)),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // 음성 녹음
              Container(
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: isRecording ? _stopRecording : _startRecording,
                      child: Icon(
                        Icons.mic,
                        size: 48,
                        color: isRecording ? Colors.red : Colors.green,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _formatDuration(recordDuration),
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(isRecording ? '녹음 중...' : '녹음 시작', style: TextStyle(color: Colors.grey[600], fontSize: 15)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const VoicePriceSetAllInOnePage()),
              );
            },
            child: const Text('작성 완료', style: TextStyle(fontSize: 16, color: Colors.white)),
          ),
        ),
      ),
    );
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(d.inMinutes)}:${twoDigits(d.inSeconds % 60)}";
  }
}

// 한 페이지에서 모든 항목을 입력하는 가격 설정 페이지
class VoicePriceSetAllInOnePage extends StatefulWidget {
  const VoicePriceSetAllInOnePage({super.key});

  @override
  State<VoicePriceSetAllInOnePage> createState() => _VoicePriceSetAllInOnePageState();
}

class _VoicePriceSetAllInOnePageState extends State<VoicePriceSetAllInOnePage> {
  String size = '';
  String unit = '';
  String packaging = '';
  String discount = '';
  final TextEditingController priceController = TextEditingController();

  Widget _buildSelector(String title, List<String> options, String selected, ValueChanged<String> onSelect) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          children: options.map((opt) {
            final bool isSelected = selected == opt;
            return OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: isSelected ? Colors.green[50] : Colors.white,
                side: BorderSide(color: isSelected ? Colors.green : Colors.grey.shade300, width: 2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 22),
              ),
              onPressed: () => onSelect(opt),
              child: Text(
                opt,
                style: TextStyle(
                  color: isSelected ? Colors.green[800] : Colors.black,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 15,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 18),
      ],
    );
  }

  void _showLoadingAndNavigate() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
            SizedBox(height: 16),
            Text(
              '상품 정보를 생성중입니다...',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pop(); // 로딩 다이얼로그 닫기
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => ProductPreviewPage(
            size: size,
            unit: unit,
            packaging: packaging,
            discount: discount,
            price: priceController.text.isEmpty ? '35,000' : priceController.text,
          ),
        ),
      );
    });
  }

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
        title: const Text('상품 가격 설정', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSelector('과일 크기', ['소과', '중과', '대과'], size, (v) => setState(() => size = v)),
              _buildSelector('판매 단위', ['1kg', '3kg', '5kg'], unit, (v) => setState(() => unit = v)),
              _buildSelector('포장 방식', ['무포장', '박스포장', '선물포장'], packaging, (v) => setState(() => packaging = v)),
              const Text('가격 설정', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
          controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: '가격을 입력하세요',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _buildSelector('할인 적용', ['설정함', '설정안함'], discount, (v) => setState(() => discount = v)),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: _showLoadingAndNavigate,
                  child: const Text('완료', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 상세 이미지 페이지 + 생성 완료 팝업
class GeneratedDetailPage extends StatefulWidget {
  const GeneratedDetailPage({super.key});

  @override
  State<GeneratedDetailPage> createState() => _GeneratedDetailPageState();
}

class _GeneratedDetailPageState extends State<GeneratedDetailPage> {
  bool _showPopup = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _showPopup = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
            children: [
          SingleChildScrollView(
            child: Image.asset(
              'assets/images/detail_sample.png',
              fit: BoxFit.fitWidth,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          if (_showPopup)
            Positioned(
              top: 48,
              left: 24,
              right: 24,
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200, width: 1.5),
                  ),
                child: Row(
                  children: [
                      const Icon(Icons.check_circle, color: Colors.green, size: 28),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('생성 완료', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                            SizedBox(height: 2),
                            Text('상세 화면이 성공적으로 생성되었습니다.', style: TextStyle(fontSize: 14)),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() => _showPopup = false),
                        child: const Icon(Icons.close, size: 22, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// 후기/문의 별도 페이지 예시
class AppleReview extends StatelessWidget {
  const AppleReview({super.key});

  Widget _tab(String label, {bool selected = false}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: selected ? Colors.green : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.green : Colors.grey[700],
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }

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
        title: const Text('[KF365] 유명산지 고당도 사과', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: false,
      ),
      body: Column(
                        children: [
          Container(
                              color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _tab('상품설명'),
                _tab('상세정보'),
                _tab('후기 ', selected: true),
                _tab('문의'),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                // 사진 후기, 후기 개수 등 예시
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Row(
                    children: [
                      ...List.generate(4, (i) => Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          height: 60,
                          color: Colors.grey[300],
                          child: i == 3 ? const Center(child: Text('+ 더보기')) : null,
                        ),
                      )),
                        ],
                      ),
                    ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('총 117,315 개', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('추천순', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
                // 후기 리스트 등 추가 가능
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// AI 소개 페이지
class AiIntroPage extends StatelessWidget {
  const AiIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('AI 자동 작성', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0xFFF3F6FF),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '✨AI가 도와줘요!',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '사진을 녹음을 등록하면 AI가 자동으로 글을 작성해요.\n빠르고 간편하게 판매를 시작해보세요.',
                    style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      elevation: 2,
                    ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const AutoGeneratePage()),
                  );
                },
                child: const Text(
                  '확인',
                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                  ),
                ),
              ),
            ],
        ),
      ),
    );
  }
}

// AppleAsk의 AppBar title/body 오류도 함께 수정
class AppleAsk extends StatelessWidget {
  const AppleAsk({super.key});

  Widget _tab(String label, {bool selected = false}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: selected ? Colors.green : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.green : Colors.grey[700],
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('[KF365] 유명산지 고당도 사과', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _tab('상품설명'),
                _tab('상세정보'),
                _tab('후기 9,999+'),
                _tab('문의', selected: true),
              ],
            ),
          ),
          // 문의 내용 등 추가 가능
        ],
      ),
    );
  }
}

void showAiIntroModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      final mq = MediaQuery.of(context);
      return Stack(
        children: [
          // 반투명 배경
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: mq.size.width,
              height: mq.size.height,
              color: Colors.black.withOpacity(0.25),
            ),
          ),
          Center(
            child: Container(
              width: mq.size.width * 0.85,
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 36),
      decoration: BoxDecoration(
        color: Colors.white,
                borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
        children: [
                  const Text(
                    '✨AI가 도와줘요!',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '사진을 녹음을 등록하면 AI가 자동으로 글을 작성해요.\n빠르고 간편하게 판매를 시작해보세요.',
                    style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        elevation: 2,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const AutoGeneratePage()),
                        );
                      },
                      child: const Text(
                        '확인',
                        style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                      ),
                    ),
          ),
        ],
      ),
            ),
          ),
        ],
      );
    },
  );

}

// 상품 미리보기 페이지 (ProductDetailPage의 간소화 버전)
class ProductPreviewPage extends StatefulWidget {
  final String size;
  final String unit;
  final String packaging;
  final String discount;
  final String price;

  const ProductPreviewPage({
    super.key,
    required this.size,
    required this.unit,
    required this.packaging,
    required this.discount,
    required this.price,
  });

  @override
  State<ProductPreviewPage> createState() => _ProductPreviewPageState();
}

class _ProductPreviewPageState extends State<ProductPreviewPage> {
  int _selectedTab = 0;
  final List<String> _tabs = ['상품설명', '상세정보', '후기 0', '문의'];
  bool _showPopup = false;

  void _showCompletionPopup() {
    setState(() => _showPopup = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const IntroScreen()),
          (route) => false,
        );
      }
    });
  }

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
        title: const Text(
          '춘산과수원',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // 탭바
              Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(_tabs.length, (idx) {
                    final selected = _selectedTab == idx;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedTab = idx),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: selected ? Colors.green : Colors.transparent,
                              width: 2,
                            ),
                          ),
                        ),
                        child: Text(
                          _tabs[idx],
                          style: TextStyle(
                            color: selected ? Colors.green : Colors.grey[700],
                            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // 상품 이미지
                      Image.asset(
                        'assets/images/apple.png',
                        width: double.infinity,
                        fit: BoxFit.fitWidth,
                      ),
                      // 상품 정보 카드 (양옆 여백 없이 전체 너비)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
                            Text('유명산지 고당도 사과 ${widget.unit}',
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Text('${widget.size} / ${widget.packaging}',
                                style: const TextStyle(fontSize: 14, color: Colors.grey)),
                            const SizedBox(height: 8),
                            const Text('원산지: 국산', style: TextStyle(fontSize: 14)),
                            const SizedBox(height: 10),
                            Text('₩${widget.price}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)),
                          ],
                        ),
                      ),
                      // 상품설명
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const ProductOptionTable(),
                      ),
                      // 상세정보
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        padding: const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/images/detail_sample.png',
                            fit: BoxFit.fitWidth,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      const SizedBox(height: 80), // 하단 버튼 공간 확보
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (_showPopup)
            Positioned(
              top: 48,
              left: 24,
              right: 24,
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200, width: 1.5),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle, color: Colors.green, size: 28),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('게시 완료', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                            SizedBox(height: 2),
                            Text('상품이 성공적으로 등록되었습니다.', style: TextStyle(fontSize: 14)),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() => _showPopup = false),
                        child: const Icon(Icons.close, size: 22, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: _showCompletionPopup,
            child: const Text(
              "게시하기",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

// 주소 검색 데모 페이지
class AddressSearchDemoPage extends StatefulWidget {
  const AddressSearchDemoPage({super.key});

  @override
  State<AddressSearchDemoPage> createState() => _AddressSearchDemoPageState();
}

class _AddressSearchDemoPageState extends State<AddressSearchDemoPage> {
  final TextEditingController _controller = TextEditingController();
  String _searchResult = '';
  bool _searched = false;

  void _onSearch() {
    setState(() {
      _searched = true;
      if (_controller.text.trim() == '경희대 국제캠' || _controller.text.trim() == '경희대학교 국제캠퍼스') {
        _searchResult = 'found';
      } else {
        _searchResult = 'none';
      }
    });
  }

  void _selectAddress(String address) {
    Navigator.of(context).pop(address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('주소록·배송지 관리', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: '입력',
                      border: OutlineInputBorder(),
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    ),
                    onSubmitted: (_) => _onSearch(),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: _onSearch,
                    child: const Icon(Icons.search, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          if (_searched && _searchResult == 'found') ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                children: const [
                  Text('1건', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(width: 16),
                  Text('시/도', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                  SizedBox(width: 8),
                  Text('시/군/구', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => _selectAddress('경기도 용인시 기흥구 덕영대로 1732'),
                    child: Container(
                      color: Colors.grey[100],
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Row(
                        children: const [
                          Text('도로명', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                          SizedBox(width: 12),
                          Expanded(child: Text('경기도 용인시 기흥구 덕영대로 1732')),
                          SizedBox(width: 8),
                          Text('[17104]', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _selectAddress('경기도 용인시 기흥구 서천동 1 경희대학교 국제캠퍼스'),
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Row(
                        children: const [
                          Text('지번', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                          SizedBox(width: 12),
                          Expanded(child: Text('경기도 용인시 기흥구 서천동 1 경희대학교 국제캠퍼스')),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ] else if (_searched && _searchResult == 'none') ...[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Text('검색 결과 없음', style: TextStyle(color: Colors.grey, fontSize: 16)),
            ),
          ],
        ],
      ),
    );
  }
}