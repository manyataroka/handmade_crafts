import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'profile_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Match Your Style',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFFCEEEE),
      ),
      home: const DashboardScreenView(),
    );
  }
}

// ==================== MODEL ====================

class JewelryItem {
  final String name;
  final double price;
  final String imagePath;
  final String category;
  bool isFavorited;

  JewelryItem({
    required this.name,
    required this.price,
    required this.imagePath,
    required this.category,
    this.isFavorited = false,
  });
}

// ==================== DASHBOARD SCREEN ====================

class DashboardScreenView extends StatefulWidget {
  const DashboardScreenView({super.key});

  @override
  State<DashboardScreenView> createState() => _DashboardScreenViewState();
}

class _DashboardScreenViewState extends State<DashboardScreenView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCEEEE),
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          HomeScreen(),
          MenuScreen(),
          CartScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.home_outlined,
                filledIcon: Icons.home,
                index: 0,
                selectedIndex: _selectedIndex,
                onTap: _onItemTapped,
              ),
              _NavItem(
                icon: Icons.menu,
                filledIcon: Icons.menu,
                index: 1,
                selectedIndex: _selectedIndex,
                onTap: _onItemTapped,
              ),
              _NavItem(
                icon: Icons.shopping_cart_outlined,
                filledIcon: Icons.shopping_cart,
                index: 2,
                selectedIndex: _selectedIndex,
                onTap: _onItemTapped,
              ),
              _NavItem(
                icon: Icons.person_outline,
                filledIcon: Icons.person,
                index: 3,
                selectedIndex: _selectedIndex,
                onTap: _onItemTapped,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== NAV ITEM ====================

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData filledIcon;
  final int index;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const _NavItem({
    required this.icon,
    required this.filledIcon,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = index == selectedIndex;
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 56,
        child: Icon(
          isSelected ? filledIcon : icon,
          color: isSelected ? Colors.black : Colors.black54,
          size: 26,
        ),
      ),
    );
  }
}

// ==================== HOME SCREEN ====================

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedFilter = 0;
  final List<String> _filters = ['All', 'Trending Now', 'New'];
  String _searchQuery = '';

  final List<JewelryItem> _items = [
    JewelryItem(
      name: 'Pearl Beads Bracelet',
      price: 699,
      imagePath: 'assets/images/img5.jpg',
      category: 'bracelet',
    ),
    JewelryItem(
      name: 'Adjustable Bracelet',
      price: 499,
      imagePath: 'assets/images/img6.jpg',
      category: 'bracelet',
    ),
    JewelryItem(
      name: 'Silver Ring',
      price: 999,
      imagePath: 'assets/images/img7.jpg',
      category: 'ring',
    ),
    JewelryItem(
      name: 'Panchadhatu Ring',
      price: 1099,
      imagePath: 'assets/images/img8.jpg',
      category: 'ring',
    ),
    JewelryItem(
      name: 'Adjustable Silver Ring',
      price: 999,
      imagePath: 'assets/images/img9.jpg',
      category: 'ring',
    ),
    JewelryItem(
      name: 'Pearl Bracelet',
      price: 599,
      imagePath: 'assets/images/img10.jpg',
      category: 'bracelet',
    ),
    JewelryItem(
      name: 'Pearl Neck Piece',
      price: 649,
      imagePath: 'assets/images/img2.jpg',
      category: 'necklace',
    ),
    JewelryItem(
      name: 'Gemstone Anklet',
      price: 1199,
      imagePath: 'assets/images/img12.jpg',
      category: 'anklet',
    ),
    JewelryItem(
      name: 'Laliguras Necklace Set',
      price: 3099,
      imagePath: 'assets/images/img13.jpg',
      category: 'necklace',
    ),
    JewelryItem(
      name: 'Silver NecklaceSet',
      price: 2099,
      imagePath: 'assets/images/img14.jpg',
      category: 'necklace',
    ),
    JewelryItem(
      name: 'Flower Necklace Set',
      price: 1099,
      imagePath: 'assets/images/img15.jpg',
      category: 'necklace',
    ),
    JewelryItem(
      name: 'Flower earring',
      price: 499,
      imagePath: 'assets/images/img17.jpg',
      category: 'earring',
    ),
    JewelryItem(
      name: 'Artisan earring',
      price: 899,
      imagePath: 'assets/images/img16.jpg',
      category: 'earring',
    ),
    JewelryItem(
      name: 'Dropdown Earring',
      price: 799,
      imagePath: 'assets/images/img18.jpg',
      category: 'earring',
    ),
  ];

  // ── FIX: Load favorites from SharedPreferences on init ──
  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList('favorites') ?? [];
    setState(() {
      for (final item in _items) {
        item.isFavorited = saved.contains(item.name);
      }
    });
  }

  Future<void> _toggleFavorite(JewelryItem item) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => item.isFavorited = !item.isFavorited);

    final saved = prefs.getStringList('favorites') ?? [];
    if (item.isFavorited) {
      if (!saved.contains(item.name)) saved.add(item.name);
    } else {
      saved.remove(item.name);
    }
    await prefs.setStringList('favorites', saved);
  }

  @override
  Widget build(BuildContext context) {
    final double bottomPadding =
        kBottomNavigationBarHeight + MediaQuery.of(context).padding.bottom + 16;

    // Prepare filtered display items for the grid based on selected filter.
    final trendingNames = {
      'pearl beads bracelet',
      'panchadhatu ring',
      'laliguras necklace set',
      'dropdown earring',
    };
    final newNames = {
      'flower earring',
      'pearl neck piece',
      'adjustable bracelet',
    };

    List<JewelryItem> _displayItemsForGrid() {
      if (_selectedFilter == 1) {
        return _items
            .where((it) => trendingNames.contains(it.name.toLowerCase()))
            .toList();
      } else if (_selectedFilter == 2) {
        return _items
            .where((it) => newNames.contains(it.name.toLowerCase()))
            .toList();
      }
      return List.of(_items);
    }

    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── Header ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.grid_view_rounded,
                    color: Color(0xFFE53935),
                    size: 28,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Match Your Style',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _SearchBar(
                    onChanged: (v) => setState(() => _searchQuery = v.trim()),
                  ),
                  const SizedBox(height: 18),
                  _FilterChips(
                    filters: _filters,
                    selectedIndex: _selectedFilter,
                    onSelected: (i) => setState(() => _selectedFilter = i),
                  ),
                  const SizedBox(height: 18),
                ],
              ),
            ),
          ),

          // ── Grid or Search Results ──
          if (_searchQuery.isNotEmpty) ...[
            ..._buildCategorySection('necklace', 'Necklaces'),
            ..._buildCategorySection('bracelet', 'Bracelets'),
            ..._buildCategorySection('earring', 'Earrings'),
            ..._buildCategorySection('ring', 'Rings'),
          ] else ...[
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 12,
                  // FIX: increased childAspectRatio to prevent overflow
                  childAspectRatio: 0.72,
                ),
                delegate: SliverChildBuilderDelegate((context, index) {
                  final displayItems = _displayItemsForGrid();
                  final item = displayItems[index];
                  return GestureDetector(
                    onTap: () => _showProductSheet(context, item),
                    child: _ProductCard(
                      item: item,
                      onFavoriteToggle: () => _toggleFavorite(item),
                    ),
                  );
                }, childCount: _displayItemsForGrid().length),
              ),
            ),
          ],

          SliverToBoxAdapter(child: SizedBox(height: bottomPadding)),
        ],
      ),
    );
  }

  List<Widget> _buildCategorySection(String categoryKey, String title) {
    final matches = _items.where((it) {
      final q = _searchQuery.toLowerCase().trim();
      final name = it.name.toLowerCase();
      final cat = it.category.toLowerCase();

      // Match when the item's category matches the section and either:
      // - the name contains the query, or
      // - the category and query partially match (handles plural/singular/partial)
      final categoryMatchesSection = cat == categoryKey;
      final categoryMatchByQuery =
          cat.contains(q) ||
          q.contains(cat) ||
          (q.endsWith('s') && q.substring(0, q.length - 1) == cat) ||
          (cat.endsWith('s') && cat.substring(0, cat.length - 1) == q);

      return categoryMatchesSection &&
          (name.contains(q) || categoryMatchByQuery);
    }).toList();

    if (matches.isEmpty) return [];

    return [
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.72,
          ),
          delegate: SliverChildBuilderDelegate((context, index) {
            final item = matches[index];
            return GestureDetector(
              onTap: () => _showProductSheet(context, item),
              child: _ProductCard(
                item: item,
                onFavoriteToggle: () => _toggleFavorite(item),
              ),
            );
          }, childCount: matches.length),
        ),
      ),
    ];
  }

  void _showProductSheet(BuildContext context, JewelryItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        int qty = 1;
        return StatefulBuilder(
          builder: (context, setStateSheet) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: SizedBox(
                height: 320,
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    Container(
                      width: 48,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          // ── FIX: Use Image.asset with error builder ──
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              item.imagePath,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              errorBuilder: (c, e, s) => Container(
                                color: const Color(0xFFF5F0EB),
                                width: 100,
                                height: 100,
                                child: const Icon(
                                  Icons.image_not_supported_outlined,
                                  color: Colors.black26,
                                  size: 32,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  '₹ ${item.price.toStringAsFixed(0)}',
                                  style: const TextStyle(
                                    color: Color(0xFFE53935),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () => setStateSheet(() {
                            if (qty > 1) qty--;
                          }),
                          icon: const Icon(Icons.remove_circle_outline),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          qty.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 6),
                        IconButton(
                          onPressed: () => setStateSheet(() => qty++),
                          icon: const Icon(Icons.add_circle_outline),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE53935),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Added $qty × ${item.name} to cart',
                                ),
                              ),
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            child: Text(
                              'Add to cart',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

// ==================== SEARCH BAR ====================

class _SearchBar extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  const _SearchBar({this.onChanged});

  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  // FIX: controller moved to State so clear() works correctly
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFFEEEEEE),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          const SizedBox(width: 14),
          const Icon(Icons.search, color: Colors.black54, size: 22),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: widget.onChanged,
              decoration: const InputDecoration(
                hintText: 'Search (bracelet, necklace, earring)',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.clear, size: 20, color: Colors.black45),
            onPressed: () {
              _controller.clear();
              widget.onChanged?.call('');
            },
          ),
        ],
      ),
    );
  }
}

// ==================== FILTER CHIPS ====================

class _FilterChips extends StatelessWidget {
  final List<String> filters;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const _FilterChips({
    required this.filters,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(filters.length, (i) {
        final bool isSelected = i == selectedIndex;
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: GestureDetector(
            onTap: () => onSelected(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFE53935) : Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFFE53935)
                      : const Color(0xFFDDDDDD),
                ),
              ),
              child: Text(
                filters[i],
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black54,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

// ==================== PRODUCT CARD (Grid) ====================

class _ProductCard extends StatelessWidget {
  final JewelryItem item;
  final VoidCallback onFavoriteToggle;
  static const double _imageHeight = 155;

  const _ProductCard({required this.item, required this.onFavoriteToggle});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      // FIX: use Column with mainAxisSize.min inside a fixed-height container
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Image
          SizedBox(
            height: _imageHeight,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: SizedBox.expand(
                    child: Image.asset(
                      item.imagePath,
                      fit: BoxFit.cover,
                      // FIX: proper error builder shows placeholder instead of crash
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: const Color(0xFFF5F0EB),
                        child: const Center(
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            size: 40,
                            color: Colors.black26,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: onFavoriteToggle,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.85),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        item.isFavorited
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: const Color(0xFFE53935),
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // FIX: reduced padding to avoid overflow
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '₹ ${item.price.toStringAsFixed(0)}',
                  style: const TextStyle(
                    color: Color(0xFFE53935),
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// _WideProductCard removed — last item now included in the grid instead of full-width

// ==================== OTHER SCREENS ====================

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
        child: Text(
          'Menu',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
        child: Text(
          'Cart',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// ProfileScreen moved to profile_view.dart
