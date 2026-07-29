// import 'dart:async';
// import 'dart:convert';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:sensors_plus/sensors_plus.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'checkout_view.dart';
// import 'profile_view.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Match Your Style',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         fontFamily: 'Roboto',
//         scaffoldBackgroundColor: const Color(0xFFFCEEEE),
//       ),
//       home: const DashboardScreenView(),
//     );
//   }
// }

// // ==================== MODELS ====================

// class JewelryItem {
//   final String name;
//   final double price;
//   final String imagePath;
//   final String category;
//   bool isFavorited;

//   JewelryItem({
//     required this.name,
//     required this.price,
//     required this.imagePath,
//     required this.category,
//     this.isFavorited = false,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'price': price,
//       'imagePath': imagePath,
//       'category': category,
//       'isFavorited': isFavorited,
//     };
//   }

//   factory JewelryItem.fromJson(Map<String, dynamic> json) {
//     return JewelryItem(
//       name: json['name'],
//       price: json['price'],
//       imagePath: json['imagePath'],
//       category: json['category'],
//       isFavorited: json['isFavorited'] ?? false,
//     );
//   }
// }

// class CartItem {
//   final JewelryItem item;
//   int quantity;

//   CartItem({required this.item, this.quantity = 1});

//   Map<String, dynamic> toJson() {
//     return {'item': item.toJson(), 'quantity': quantity};
//   }

//   factory CartItem.fromJson(Map<String, dynamic> json) {
//     return CartItem(
//       item: JewelryItem.fromJson(json['item']),
//       quantity: json['quantity'],
//     );
//   }

//   double get totalPrice => item.price * quantity;
// }

// // ==================== DASHBOARD SCREEN ====================

// class DashboardScreenView extends StatefulWidget {
//   const DashboardScreenView({super.key});

//   @override
//   State<DashboardScreenView> createState() => _DashboardScreenViewState();
// }

// class _DashboardScreenViewState extends State<DashboardScreenView> {
//   int _selectedIndex = 0;
//   List<CartItem> _cartItems = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadCart();
//   }

//   Future<void> _loadCart() async {
//     final prefs = await SharedPreferences.getInstance();
//     final cartJson = prefs.getStringList('cart') ?? [];
//     if (mounted) {
//       setState(() {
//         _cartItems = cartJson
//             .map(
//               (e) => CartItem.fromJson(jsonDecode(e) as Map<String, dynamic>),
//             )
//             .toList();
//       });
//     }
//   }

//   Future<void> _saveCart() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setStringList(
//       'cart',
//       _cartItems.map((e) => jsonEncode(e.toJson())).toList(),
//     );
//   }

//   Future<void> addToCart(JewelryItem item, int quantity) async {
//     bool found = false;
//     for (var cartItem in _cartItems) {
//       if (cartItem.item.name == item.name) {
//         cartItem.quantity += quantity;
//         found = true;
//         break;
//       }
//     }
//     if (!found) {
//       _cartItems.add(CartItem(item: item, quantity: quantity));
//     }
//     setState(() {});
//     await _saveCart();
//   }

//   Future<void> removeFromCart(int index) async {
//     _cartItems.removeAt(index);
//     setState(() {});
//     await _saveCart();
//   }

//   Future<void> updateQuantity(int index, int delta) async {
//     final newQty = _cartItems[index].quantity + delta;
//     if (newQty <= 0) {
//       _cartItems.removeAt(index);
//     } else {
//       _cartItems[index].quantity = newQty;
//     }
//     setState(() {});
//     await _saveCart();
//   }

//   Future<void> clearCart() async {
//     _cartItems.clear();
//     setState(() {});
//     await _saveCart();
//   }

//   int get _cartItemCount {
//     return _cartItems.fold(0, (sum, item) => sum + item.quantity);
//   }

//   void _onItemTapped(int index) {
//     setState(() => _selectedIndex = index);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFCEEEE),
//       body: IndexedStack(
//         index: _selectedIndex,
//         children: [
//           HomeScreen(onAddToCart: addToCart),
//           MenuScreen(onAddToCart: addToCart),
//           CartScreen(
//             cartItems: _cartItems,
//             onRemove: removeFromCart,
//             onUpdateQuantity: updateQuantity,
//             onClearCart: clearCart,
//           ),
//           const ProfileScreen(),
//         ],
//       ),
//       bottomNavigationBar: _buildBottomNav(),
//     );
//   }

//   Widget _buildBottomNav() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 10,
//             offset: const Offset(0, -2),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         child: SizedBox(
//           height: 64,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               _NavItem(
//                 icon: Icons.home_outlined,
//                 filledIcon: Icons.home,
//                 index: 0,
//                 selectedIndex: _selectedIndex,
//                 onTap: _onItemTapped,
//               ),
//               _NavItem(
//                 icon: Icons.menu,
//                 filledIcon: Icons.menu,
//                 index: 1,
//                 selectedIndex: _selectedIndex,
//                 onTap: _onItemTapped,
//               ),
//               _CartNavItem(
//                 icon: Icons.shopping_cart_outlined,
//                 filledIcon: Icons.shopping_cart,
//                 index: 2,
//                 selectedIndex: _selectedIndex,
//                 onTap: _onItemTapped,
//                 itemCount: _cartItemCount,
//               ),
//               _NavItem(
//                 icon: Icons.person_outline,
//                 filledIcon: Icons.person,
//                 index: 3,
//                 selectedIndex: _selectedIndex,
//                 onTap: _onItemTapped,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // ==================== NAV ITEM ====================

// class _NavItem extends StatelessWidget {
//   final IconData icon;
//   final IconData filledIcon;
//   final int index;
//   final int selectedIndex;
//   final ValueChanged<int> onTap;

//   const _NavItem({
//     required this.icon,
//     required this.filledIcon,
//     required this.index,
//     required this.selectedIndex,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final bool isSelected = index == selectedIndex;
//     return GestureDetector(
//       onTap: () => onTap(index),
//       behavior: HitTestBehavior.opaque,
//       child: SizedBox(
//         width: 56,
//         child: Icon(
//           isSelected ? filledIcon : icon,
//           color: isSelected ? Colors.black : Colors.black54,
//           size: 26,
//         ),
//       ),
//     );
//   }
// }

// class _CartNavItem extends StatelessWidget {
//   final IconData icon;
//   final IconData filledIcon;
//   final int index;
//   final int selectedIndex;
//   final ValueChanged<int> onTap;
//   final int itemCount;

//   const _CartNavItem({
//     required this.icon,
//     required this.filledIcon,
//     required this.index,
//     required this.selectedIndex,
//     required this.onTap,
//     required this.itemCount,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final bool isSelected = index == selectedIndex;
//     return GestureDetector(
//       onTap: () => onTap(index),
//       behavior: HitTestBehavior.opaque,
//       child: SizedBox(
//         width: 56,
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             Icon(
//               isSelected ? filledIcon : icon,
//               color: isSelected ? Colors.black : Colors.black54,
//               size: 26,
//             ),
//             if (itemCount > 0)
//               Positioned(
//                 top: 4,
//                 right: 4,
//                 child: Container(
//                   padding: const EdgeInsets.all(4),
//                   decoration: const BoxDecoration(
//                     color: Color(0xFFE53935),
//                     shape: BoxShape.circle,
//                   ),
//                   constraints: const BoxConstraints(
//                     minWidth: 18,
//                     minHeight: 18,
//                   ),
//                   child: Text(
//                     itemCount > 99 ? '99+' : itemCount.toString(),
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 10,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ==================== HOME SCREEN ====================

// class HomeScreen extends StatefulWidget {
//   final Future<void> Function(JewelryItem item, int quantity)? onAddToCart;

//   const HomeScreen({super.key, this.onAddToCart});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedFilter = 0;
//   final List<String> _filters = ['All', 'Trending Now', 'New'];
//   String _searchQuery = '';

//   final List<JewelryItem> _items = [
//     JewelryItem(
//       name: 'Pearl Beads Bracelet',
//       price: 699,
//       imagePath: 'assets/images/img5.jpg',
//       category: 'bracelet',
//     ),
//     JewelryItem(
//       name: 'Adjustable Bracelet',
//       price: 499,
//       imagePath: 'assets/images/img6.jpg',
//       category: 'bracelet',
//     ),
//     JewelryItem(
//       name: 'Silver Ring',
//       price: 999,
//       imagePath: 'assets/images/img7.jpg',
//       category: 'ring',
//     ),
//     JewelryItem(
//       name: 'Panchadhatu Ring',
//       price: 1099,
//       imagePath: 'assets/images/img8.jpg',
//       category: 'ring',
//     ),
//     JewelryItem(
//       name: 'Adjustable Silver Ring',
//       price: 999,
//       imagePath: 'assets/images/img9.jpg',
//       category: 'ring',
//     ),
//     JewelryItem(
//       name: 'Pearl Bracelet',
//       price: 599,
//       imagePath: 'assets/images/img10.jpg',
//       category: 'bracelet',
//     ),
//     JewelryItem(
//       name: 'Pearl Neck Piece',
//       price: 649,
//       imagePath: 'assets/images/img2.jpg',
//       category: 'necklace',
//     ),
//     JewelryItem(
//       name: 'Gemstone Anklet',
//       price: 1199,
//       imagePath: 'assets/images/img12.jpg',
//       category: 'anklet',
//     ),
//     JewelryItem(
//       name: 'Laliguras Necklace Set',
//       price: 3099,
//       imagePath: 'assets/images/img13.jpg',
//       category: 'necklace',
//     ),
//     JewelryItem(
//       name: 'Silver NecklaceSet',
//       price: 2099,
//       imagePath: 'assets/images/img14.jpg',
//       category: 'necklace',
//     ),
//     JewelryItem(
//       name: 'Flower Necklace Set',
//       price: 1099,
//       imagePath: 'assets/images/img15.jpg',
//       category: 'necklace',
//     ),
//     JewelryItem(
//       name: 'Flower earring',
//       price: 499,
//       imagePath: 'assets/images/img17.jpg',
//       category: 'earring',
//     ),
//     JewelryItem(
//       name: 'Artisan earring',
//       price: 899,
//       imagePath: 'assets/images/img16.jpg',
//       category: 'earring',
//     ),
//     JewelryItem(
//       name: 'Dropdown Earring',
//       price: 799,
//       imagePath: 'assets/images/img18.jpg',
//       category: 'earring',
//     ),
//   ];

//   // ── Load favorites from SharedPreferences on init ──
//   @override
//   void initState() {
//     super.initState();
//     _loadFavorites();
//   }

//   Future<void> _loadFavorites() async {
//     final prefs = await SharedPreferences.getInstance();
//     final saved = prefs.getStringList('favorites') ?? [];
//     setState(() {
//       for (final item in _items) {
//         item.isFavorited = saved.contains(item.name);
//       }
//     });
//   }

//   Future<void> _toggleFavorite(JewelryItem item) async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() => item.isFavorited = !item.isFavorited);

//     final saved = prefs.getStringList('favorites') ?? [];
//     if (item.isFavorited) {
//       if (!saved.contains(item.name)) saved.add(item.name);
//     } else {
//       saved.remove(item.name);
//     }
//     await prefs.setStringList('favorites', saved);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double bottomPadding =
//         kBottomNavigationBarHeight + MediaQuery.of(context).padding.bottom + 16;

//     // Prepare filtered display items for the grid based on selected filter.
//     final trendingNames = {
//       'pearl beads bracelet',
//       'panchadhatu ring',
//       'laliguras necklace set',
//       'dropdown earring',
//     };
//     final newNames = {
//       'flower earring',
//       'pearl neck piece',
//       'adjustable bracelet',
//     };

//     List<JewelryItem> _displayItemsForGrid() {
//       if (_selectedFilter == 1) {
//         return _items
//             .where((it) => trendingNames.contains(it.name.toLowerCase()))
//             .toList();
//       } else if (_selectedFilter == 2) {
//         return _items
//             .where((it) => newNames.contains(it.name.toLowerCase()))
//             .toList();
//       }
//       return List.of(_items);
//     }

//     return SafeArea(
//       child: CustomScrollView(
//         physics: const BouncingScrollPhysics(),
//         slivers: [
//           // ── Header ──
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Icon(
//                     Icons.grid_view_rounded,
//                     color: Color(0xFFE53935),
//                     size: 28,
//                   ),
//                   const SizedBox(height: 20),
//                   const Text(
//                     'Match Your Style',
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   _SearchBar(
//                     onChanged: (v) => setState(() => _searchQuery = v.trim()),
//                   ),
//                   const SizedBox(height: 18),
//                   _FilterChips(
//                     filters: _filters,
//                     selectedIndex: _selectedFilter,
//                     onSelected: (i) => setState(() => _selectedFilter = i),
//                   ),
//                   const SizedBox(height: 18),
//                 ],
//               ),
//             ),
//           ),

//           // ── Grid or Search Results ──
//           if (_searchQuery.isNotEmpty) ...[
//             ..._buildCategorySection('necklace', 'Necklaces'),
//             ..._buildCategorySection('bracelet', 'Bracelets'),
//             ..._buildCategorySection('earring', 'Earrings'),
//             ..._buildCategorySection('ring', 'Rings'),
//           ] else ...[
//             SliverPadding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               sliver: SliverGrid(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   mainAxisSpacing: 16,
//                   crossAxisSpacing: 12,
//                   // FIX: increased childAspectRatio to prevent overflow
//                   childAspectRatio: 0.72,
//                 ),
//                 delegate: SliverChildBuilderDelegate((context, index) {
//                   final displayItems = _displayItemsForGrid();
//                   final item = displayItems[index];
//                   return GestureDetector(
//                     onTap: () => _showProductSheet(context, item),
//                     child: _ProductCard(
//                       item: item,
//                       onFavoriteToggle: () => _toggleFavorite(item),
//                     ),
//                   );
//                 }, childCount: _displayItemsForGrid().length),
//               ),
//             ),
//           ],

//           SliverToBoxAdapter(child: SizedBox(height: bottomPadding)),
//         ],
//       ),
//     );
//   }

//   List<Widget> _buildCategorySection(String categoryKey, String title) {
//     final matches = _items.where((it) {
//       final q = _searchQuery.toLowerCase().trim();
//       final name = it.name.toLowerCase();
//       final cat = it.category.toLowerCase();

//       // Match when the item's category matches the section and either:
//       // - the name contains the query, or
//       // - the category and query partially match (handles plural/singular/partial)
//       final categoryMatchesSection = cat == categoryKey;
//       final categoryMatchByQuery =
//           cat.contains(q) ||
//           q.contains(cat) ||
//           (q.endsWith('s') && q.substring(0, q.length - 1) == cat) ||
//           (cat.endsWith('s') && cat.substring(0, cat.length - 1) == q);

//       return categoryMatchesSection &&
//           (name.contains(q) || categoryMatchByQuery);
//     }).toList();

//     if (matches.isEmpty) return [];

//     return [
//       SliverToBoxAdapter(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
//           child: Text(
//             title,
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ),
//       SliverPadding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         sliver: SliverGrid(
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             mainAxisSpacing: 12,
//             crossAxisSpacing: 12,
//             childAspectRatio: 0.72,
//           ),
//           delegate: SliverChildBuilderDelegate((context, index) {
//             final item = matches[index];
//             return GestureDetector(
//               onTap: () => _showProductSheet(context, item),
//               child: _ProductCard(
//                 item: item,
//                 onFavoriteToggle: () => _toggleFavorite(item),
//               ),
//             );
//           }, childCount: matches.length),
//         ),
//       ),
//     ];
//   }

//   void _showProductSheet(BuildContext context, JewelryItem item) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (context) {
//         int qty = 1;
//         return StatefulBuilder(
//           builder: (context, setStateSheet) {
//             return Padding(
//               padding: MediaQuery.of(context).viewInsets,
//               child: SizedBox(
//                 height: 320,
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 12),
//                     Container(
//                       width: 48,
//                       height: 6,
//                       decoration: BoxDecoration(
//                         color: Colors.black12,
//                         borderRadius: BorderRadius.circular(3),
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: Row(
//                         children: [
//                           // ── Use Image.asset with error builder ──
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(12),
//                             child: Image.asset(
//                               item.imagePath,
//                               width: 100,
//                               height: 100,
//                               fit: BoxFit.cover,
//                               errorBuilder: (c, e, s) => Container(
//                                 color: const Color(0xFFF5F0EB),
//                                 width: 100,
//                                 height: 100,
//                                 child: const Icon(
//                                   Icons.image_not_supported_outlined,
//                                   color: Colors.black26,
//                                   size: 32,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   item.name,
//                                   style: const TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 6),
//                                 Text(
//                                   '₹ ${item.price.toStringAsFixed(0)}',
//                                   style: const TextStyle(
//                                     color: Color(0xFFE53935),
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 18),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         IconButton(
//                           onPressed: () => setStateSheet(() {
//                             if (qty > 1) qty--;
//                           }),
//                           icon: const Icon(Icons.remove_circle_outline),
//                         ),
//                         const SizedBox(width: 6),
//                         Text(
//                           qty.toString(),
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(width: 6),
//                         IconButton(
//                           onPressed: () => setStateSheet(() => qty++),
//                           icon: const Icon(Icons.add_circle_outline),
//                         ),
//                       ],
//                     ),
//                     const Spacer(),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 12,
//                       ),
//                       child: SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFFE53935),
//                           ),
//                           onPressed: () async {
//                             if (widget.onAddToCart != null) {
//                               await widget.onAddToCart!(item, qty);
//                             }
//                             if (mounted) {
//                               Navigator.of(context).pop();
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content: Text(
//                                     'Added $qty × ${item.name} to cart',
//                                   ),
//                                 ),
//                               );
//                             }
//                           },
//                           child: const Padding(
//                             padding: EdgeInsets.symmetric(vertical: 14),
//                             child: Text(
//                               'Add to cart',
//                               style: TextStyle(fontSize: 16),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }

// // ==================== SEARCH BAR ====================

// class _SearchBar extends StatefulWidget {
//   final ValueChanged<String>? onChanged;
//   const _SearchBar({this.onChanged});

//   @override
//   State<_SearchBar> createState() => _SearchBarState();
// }

// class _SearchBarState extends State<_SearchBar> {
//   // FIX: controller moved to State so clear() works correctly
//   final _controller = TextEditingController();

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 48,
//       decoration: BoxDecoration(
//         color: const Color(0xFFEEEEEE),
//         borderRadius: BorderRadius.circular(30),
//       ),
//       child: Row(
//         children: [
//           const SizedBox(width: 14),
//           const Icon(Icons.search, color: Colors.black54, size: 22),
//           const SizedBox(width: 8),
//           Expanded(
//             child: TextField(
//               controller: _controller,
//               onChanged: widget.onChanged,
//               decoration: const InputDecoration(
//                 hintText: 'Search (bracelet, necklace, earring)',
//                 border: InputBorder.none,
//               ),
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.clear, size: 20, color: Colors.black45),
//             onPressed: () {
//               _controller.clear();
//               widget.onChanged?.call('');
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ==================== FILTER CHIPS ====================

// class _FilterChips extends StatelessWidget {
//   final List<String> filters;
//   final int selectedIndex;
//   final ValueChanged<int> onSelected;

//   const _FilterChips({
//     required this.filters,
//     required this.selectedIndex,
//     required this.onSelected,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: List.generate(filters.length, (i) {
//         final bool isSelected = i == selectedIndex;
//         return Padding(
//           padding: const EdgeInsets.only(right: 10),
//           child: GestureDetector(
//             onTap: () => onSelected(i),
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 200),
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               decoration: BoxDecoration(
//                 color: isSelected ? const Color(0xFFE53935) : Colors.white,
//                 borderRadius: BorderRadius.circular(24),
//                 border: Border.all(
//                   color: isSelected
//                       ? const Color(0xFFE53935)
//                       : const Color(0xFFDDDDDD),
//                 ),
//               ),
//               child: Text(
//                 filters[i],
//                 style: TextStyle(
//                   color: isSelected ? Colors.white : Colors.black54,
//                   fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
//                   fontSize: 13,
//                 ),
//               ),
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }

// // ==================== PRODUCT CARD (Grid) ====================

// class _ProductCard extends StatelessWidget {
//   final JewelryItem item;
//   final VoidCallback onFavoriteToggle;
//   static const double _imageHeight = 155;

//   const _ProductCard({required this.item, required this.onFavoriteToggle});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       // FIX: use Column with mainAxisSize.min inside a fixed-height container
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // Image
//           SizedBox(
//             height: _imageHeight,
//             child: Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: const BorderRadius.vertical(
//                     top: Radius.circular(16),
//                   ),
//                   child: SizedBox.expand(
//                     child: Image.asset(
//                       item.imagePath,
//                       fit: BoxFit.cover,
//                       // FIX: proper error builder shows placeholder instead of crash
//                       errorBuilder: (context, error, stackTrace) => Container(
//                         color: const Color(0xFFF5F0EB),
//                         child: const Center(
//                           child: Icon(
//                             Icons.image_not_supported_outlined,
//                             size: 40,
//                             color: Colors.black26,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 8,
//                   right: 8,
//                   child: GestureDetector(
//                     onTap: onFavoriteToggle,
//                     child: Container(
//                       padding: const EdgeInsets.all(4),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.85),
//                         shape: BoxShape.circle,
//                       ),
//                       child: Icon(
//                         item.isFavorited
//                             ? Icons.favorite
//                             : Icons.favorite_border,
//                         color: const Color(0xFFE53935),
//                         size: 20,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // FIX: reduced padding to avoid overflow
//           Padding(
//             padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   item.name,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 13,
//                     color: Colors.black87,
//                   ),
//                   textAlign: TextAlign.center,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   '₹ ${item.price.toStringAsFixed(0)}',
//                   style: const TextStyle(
//                     color: Color(0xFFE53935),
//                     fontWeight: FontWeight.w600,
//                     fontSize: 13,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // _WideProductCard removed — last item now included in the grid instead of full-width

// // ==================== OTHER SCREENS ====================

// class MenuScreen extends StatefulWidget {
//   final Future<void> Function(JewelryItem item, int quantity)? onAddToCart;

//   const MenuScreen({super.key, this.onAddToCart});

//   @override
//   State<MenuScreen> createState() => _MenuScreenState();
// }

// class _MenuScreenState extends State<MenuScreen> with WidgetsBindingObserver {
//   String? _selectedCategory;

//   // ── Accelerometer Shake-to-Shuffle ──
//   StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;
//   DateTime _lastShakeTime = DateTime.now();
//   bool _shakeDetected = false;
//   static const double _shakeThreshold = 25.0; // m/s²
//   static const Duration _shakeCooldown = Duration(seconds: 2);

//   final List<JewelryItem> _allItems = [
//     JewelryItem(
//       name: 'Pearl Beads Bracelet',
//       price: 699,
//       imagePath: 'assets/images/img5.jpg',
//       category: 'bracelet',
//     ),
//     JewelryItem(
//       name: 'Adjustable Bracelet',
//       price: 499,
//       imagePath: 'assets/images/img6.jpg',
//       category: 'bracelet',
//     ),
//     JewelryItem(
//       name: 'Silver Ring',
//       price: 999,
//       imagePath: 'assets/images/img7.jpg',
//       category: 'ring',
//     ),
//     JewelryItem(
//       name: 'Panchadhatu Ring',
//       price: 1099,
//       imagePath: 'assets/images/img8.jpg',
//       category: 'ring',
//     ),
//     JewelryItem(
//       name: 'Adjustable Silver Ring',
//       price: 999,
//       imagePath: 'assets/images/img9.jpg',
//       category: 'ring',
//     ),
//     JewelryItem(
//       name: 'Pearl Bracelet',
//       price: 599,
//       imagePath: 'assets/images/img10.jpg',
//       category: 'bracelet',
//     ),
//     JewelryItem(
//       name: 'Pearl Neck Piece',
//       price: 649,
//       imagePath: 'assets/images/img2.jpg',
//       category: 'necklace',
//     ),
//     JewelryItem(
//       name: 'Gemstone Anklet',
//       price: 1199,
//       imagePath: 'assets/images/img12.jpg',
//       category: 'anklet',
//     ),
//     JewelryItem(
//       name: 'Laliguras Necklace Set',
//       price: 3099,
//       imagePath: 'assets/images/img13.jpg',
//       category: 'necklace',
//     ),
//     JewelryItem(
//       name: 'Silver NecklaceSet',
//       price: 2099,
//       imagePath: 'assets/images/img14.jpg',
//       category: 'necklace',
//     ),
//     JewelryItem(
//       name: 'Flower Necklace Set',
//       price: 1099,
//       imagePath: 'assets/images/img15.jpg',
//       category: 'necklace',
//     ),
//     JewelryItem(
//       name: 'Flower earring',
//       price: 499,
//       imagePath: 'assets/images/img17.jpg',
//       category: 'earring',
//     ),
//     JewelryItem(
//       name: 'Artisan earring',
//       price: 899,
//       imagePath: 'assets/images/img16.jpg',
//       category: 'earring',
//     ),
//     JewelryItem(
//       name: 'Dropdown Earring',
//       price: 799,
//       imagePath: 'assets/images/img18.jpg',
//       category: 'earring',
//     ),
//   ];

//   List<String> get _categories {
//     return _allItems.map((item) => item.category).toSet().toList()..sort();
//   }

//   List<JewelryItem> get _filteredItems {
//     if (_selectedCategory == null) return _allItems;
//     return _allItems
//         .where((item) => item.category == _selectedCategory)
//         .toList();
//   }

//   String _capitalize(String s) {
//     if (s.isEmpty) return s;
//     return s[0].toUpperCase() + s.substring(1);
//   }

//   // ── Lifecycle ──
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     _initAccelerometer();
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     _accelerometerSubscription?.cancel();
//     super.dispose();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {
//       _initAccelerometer();
//     } else if (state == AppLifecycleState.paused) {
//       _accelerometerSubscription?.cancel();
//       _accelerometerSubscription = null;
//     }
//   }

//   void _initAccelerometer() {
//     _accelerometerSubscription?.cancel();
//     _accelerometerSubscription = accelerometerEventStream().listen(
//       (AccelerometerEvent event) {
//         final now = DateTime.now();
//         if (now.difference(_lastShakeTime) < _shakeCooldown) return;

//         final magnitude = sqrt(
//           event.x * event.x + event.y * event.y + event.z * event.z,
//         );
//         if (magnitude > _shakeThreshold) {
//           _lastShakeTime = now;
//           _handleShake();
//         }
//       },
//       onError: (Object error) {
//         // Sensors not available — silently ignore
//       },
//     );
//   }

//   void _handleShake() {
//     setState(() {
//       _shakeDetected = true;
//       _allItems.shuffle(Random());
//     });

//     // Show a brief snackbar
//     if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Row(
//             children: [
//               Icon(Icons.vibration, color: Colors.white, size: 20),
//               SizedBox(width: 8),
//               Text('Shake detected! Products shuffled.'),
//             ],
//           ),
//           backgroundColor: Color(0xFFE53935),
//           duration: Duration(seconds: 1),
//           behavior: SnackBarBehavior.floating,
//         ),
//       );
//     }

//     // Reset shake indicator after a short delay
//     Future.delayed(const Duration(milliseconds: 500), () {
//       if (mounted) setState(() => _shakeDetected = false);
//     });
//   }

//   void _showProductSheet(BuildContext context, JewelryItem item) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (context) {
//         int qty = 1;
//         return StatefulBuilder(
//           builder: (context, setStateSheet) {
//             return Padding(
//               padding: MediaQuery.of(context).viewInsets,
//               child: SizedBox(
//                 height: 320,
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 12),
//                     Container(
//                       width: 48,
//                       height: 6,
//                       decoration: BoxDecoration(
//                         color: Colors.black12,
//                         borderRadius: BorderRadius.circular(3),
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: Row(
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(12),
//                             child: Image.asset(
//                               item.imagePath,
//                               width: 100,
//                               height: 100,
//                               fit: BoxFit.cover,
//                               errorBuilder: (c, e, s) => Container(
//                                 color: const Color(0xFFF5F0EB),
//                                 width: 100,
//                                 height: 100,
//                                 child: const Icon(
//                                   Icons.image_not_supported_outlined,
//                                   color: Colors.black26,
//                                   size: 32,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   item.name,
//                                   style: const TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 6),
//                                 Text(
//                                   '₹ ${item.price.toStringAsFixed(0)}',
//                                   style: const TextStyle(
//                                     color: Color(0xFFE53935),
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 18),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         IconButton(
//                           onPressed: () => setStateSheet(() {
//                             if (qty > 1) qty--;
//                           }),
//                           icon: const Icon(Icons.remove_circle_outline),
//                         ),
//                         const SizedBox(width: 6),
//                         Text(
//                           qty.toString(),
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(width: 6),
//                         IconButton(
//                           onPressed: () => setStateSheet(() => qty++),
//                           icon: const Icon(Icons.add_circle_outline),
//                         ),
//                       ],
//                     ),
//                     const Spacer(),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 12,
//                       ),
//                       child: SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFFE53935),
//                           ),
//                           onPressed: () async {
//                             if (widget.onAddToCart != null) {
//                               await widget.onAddToCart!(item, qty);
//                             }
//                             if (mounted) {
//                               Navigator.of(context).pop();
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content: Text(
//                                     'Added $qty × ${item.name} to cart',
//                                   ),
//                                 ),
//                               );
//                             }
//                           },
//                           child: const Padding(
//                             padding: EdgeInsets.symmetric(vertical: 14),
//                             child: Text(
//                               'Add to cart',
//                               style: TextStyle(fontSize: 16),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
//             child: Row(
//               children: [
//                 const Icon(Icons.menu, color: Color(0xFFE53935), size: 28),
//                 const SizedBox(width: 12),
//                 const Text(
//                   'Categories',
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black87,
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Shake hint indicator
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
//             child: TweenAnimationBuilder<double>(
//               tween: Tween(begin: 0.0, end: _shakeDetected ? 1.0 : 0.0),
//               duration: const Duration(milliseconds: 300),
//               builder: (context, value, child) {
//                 return Opacity(
//                   opacity: value,
//                   child: Transform.scale(
//                     scale: 1.0 + value * 0.05,
//                     child: child,
//                   ),
//                 );
//               },
//               child: Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 10,
//                 ),
//                 decoration: BoxDecoration(
//                   color: _shakeDetected
//                       ? const Color(0xFFE53935).withOpacity(0.1)
//                       : Colors.transparent,
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(
//                     color: _shakeDetected
//                         ? const Color(0xFFE53935)
//                         : Colors.transparent,
//                   ),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(
//                       _shakeDetected ? Icons.vibration : Icons.shuffle,
//                       size: 18,
//                       color: _shakeDetected
//                           ? const Color(0xFFE53935)
//                           : Colors.black45,
//                     ),
//                     const SizedBox(width: 8),
//                     Text(
//                       _shakeDetected
//                           ? 'Products shuffled!'
//                           : 'Shake phone to shuffle products',
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: _shakeDetected
//                             ? const Color(0xFFE53935)
//                             : Colors.black45,
//                         fontWeight: _shakeDetected
//                             ? FontWeight.w600
//                             : FontWeight.normal,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),

//           // Category chips
//           Padding(
//             padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               physics: const BouncingScrollPhysics(),
//               child: Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(right: 10),
//                     child: GestureDetector(
//                       onTap: () {
//                         setState(() => _selectedCategory = null);
//                       },
//                       child: AnimatedContainer(
//                         duration: const Duration(milliseconds: 200),
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 20,
//                           vertical: 10,
//                         ),
//                         decoration: BoxDecoration(
//                           color: _selectedCategory == null
//                               ? const Color(0xFFE53935)
//                               : Colors.white,
//                           borderRadius: BorderRadius.circular(24),
//                           border: Border.all(
//                             color: _selectedCategory == null
//                                 ? const Color(0xFFE53935)
//                                 : const Color(0xFFDDDDDD),
//                           ),
//                         ),
//                         child: Text(
//                           'All',
//                           style: TextStyle(
//                             color: _selectedCategory == null
//                                 ? Colors.white
//                                 : Colors.black54,
//                             fontWeight: _selectedCategory == null
//                                 ? FontWeight.w600
//                                 : FontWeight.normal,
//                             fontSize: 13,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   ..._categories.map((category) {
//                     final isSelected = _selectedCategory == category;
//                     return Padding(
//                       padding: const EdgeInsets.only(right: 10),
//                       child: GestureDetector(
//                         onTap: () {
//                           setState(() => _selectedCategory = category);
//                         },
//                         child: AnimatedContainer(
//                           duration: const Duration(milliseconds: 200),
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 20,
//                             vertical: 10,
//                           ),
//                           decoration: BoxDecoration(
//                             color: isSelected
//                                 ? const Color(0xFFE53935)
//                                 : Colors.white,
//                             borderRadius: BorderRadius.circular(24),
//                             border: Border.all(
//                               color: isSelected
//                                   ? const Color(0xFFE53935)
//                                   : const Color(0xFFDDDDDD),
//                             ),
//                           ),
//                           child: Text(
//                             _capitalize(category),
//                             style: TextStyle(
//                               color: isSelected ? Colors.white : Colors.black54,
//                               fontWeight: isSelected
//                                   ? FontWeight.w600
//                                   : FontWeight.normal,
//                               fontSize: 13,
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   }),
//                 ],
//               ),
//             ),
//           ),

//           // Items grid
//           Expanded(
//             child: _filteredItems.isEmpty
//                 ? const Center(
//                     child: Text(
//                       'No items in this category',
//                       style: TextStyle(color: Colors.black54),
//                     ),
//                   )
//                 : GridView.builder(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 20,
//                       vertical: 8,
//                     ),
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2,
//                           mainAxisSpacing: 16,
//                           crossAxisSpacing: 12,
//                           childAspectRatio: 0.7,
//                         ),
//                     itemCount: _filteredItems.length,
//                     itemBuilder: (context, index) {
//                       final item = _filteredItems[index];
//                       return GestureDetector(
//                         onTap: () => _showProductSheet(context, item),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(16),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.05),
//                                 blurRadius: 8,
//                                 offset: const Offset(0, 2),
//                               ),
//                             ],
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               SizedBox(
//                                 height: 130,
//                                 child: ClipRRect(
//                                   borderRadius: const BorderRadius.vertical(
//                                     top: Radius.circular(16),
//                                   ),
//                                   child: Image.asset(
//                                     item.imagePath,
//                                     width: double.infinity,
//                                     fit: BoxFit.cover,
//                                     errorBuilder: (c, e, s) => Container(
//                                       color: const Color(0xFFF5F0EB),
//                                       child: const Center(
//                                         child: Icon(
//                                           Icons.image_not_supported_outlined,
//                                           size: 40,
//                                           color: Colors.black26,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   children: [
//                                     Text(
//                                       item.name,
//                                       textAlign: TextAlign.center,
//                                       maxLines: 2,
//                                       overflow: TextOverflow.ellipsis,
//                                       style: const TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 12,
//                                         color: Colors.black87,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 4),
//                                     Text(
//                                       '₹ ${item.price.toStringAsFixed(0)}',
//                                       style: const TextStyle(
//                                         color: Color(0xFFE53935),
//                                         fontWeight: FontWeight.w600,
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CartScreen extends StatefulWidget {
//   final List<CartItem> cartItems;
//   final Future<void> Function(int index) onRemove;
//   final Future<void> Function(int index, int delta) onUpdateQuantity;
//   final Future<void> Function() onClearCart;

//   const CartScreen({
//     super.key,
//     required this.cartItems,
//     required this.onRemove,
//     required this.onUpdateQuantity,
//     required this.onClearCart,
//   });

//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }

// class _CartScreenState extends State<CartScreen> {
//   double get _totalPrice {
//     return widget.cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double bottomPadding = MediaQuery.of(context).padding.bottom + 20;

//     return SafeArea(
//       child: Column(
//         children: [
//           // Header
//           Padding(
//             padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
//             child: Row(
//               children: [
//                 const Icon(
//                   Icons.shopping_cart_outlined,
//                   color: Color(0xFFE53935),
//                   size: 28,
//                 ),
//                 const SizedBox(width: 12),
//                 const Text(
//                   'Your Cart',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 const Spacer(),
//                 if (widget.cartItems.isNotEmpty)
//                   Text(
//                     '${widget.cartItems.length} item${widget.cartItems.length > 1 ? 's' : ''}',
//                     style: const TextStyle(color: Colors.black54),
//                   ),
//               ],
//             ),
//           ),

//           // Cart Items or Empty State
//           Expanded(
//             child: widget.cartItems.isEmpty
//                 ? Center(
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Icon(
//                           Icons.shopping_bag_outlined,
//                           size: 80,
//                           color: Colors.black26,
//                         ),
//                         const SizedBox(height: 20),
//                         const Text(
//                           'Your cart is empty',
//                           style: TextStyle(fontSize: 18, color: Colors.black54),
//                         ),
//                       ],
//                     ),
//                   )
//                 : ListView.builder(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     itemCount: widget.cartItems.length,
//                     itemBuilder: (context, index) {
//                       final cartItem = widget.cartItems[index];
//                       return Padding(
//                         padding: const EdgeInsets.only(bottom: 12),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(16),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.05),
//                                 blurRadius: 8,
//                                 offset: const Offset(0, 2),
//                               ),
//                             ],
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(12),
//                             child: Row(
//                               children: [
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(12),
//                                   child: Image.asset(
//                                     cartItem.item.imagePath,
//                                     width: 80,
//                                     height: 80,
//                                     fit: BoxFit.cover,
//                                     errorBuilder: (c, e, s) => Container(
//                                       color: const Color(0xFFF5F0EB),
//                                       width: 80,
//                                       height: 80,
//                                       child: const Icon(
//                                         Icons.image_not_supported_outlined,
//                                         color: Colors.black26,
//                                         size: 32,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 12),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         cartItem.item.name,
//                                         style: const TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.black87,
//                                         ),
//                                         maxLines: 2,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                       const SizedBox(height: 4),
//                                       Text(
//                                         '₹ ${cartItem.item.price.toStringAsFixed(0)}',
//                                         style: const TextStyle(
//                                           color: Color(0xFFE53935),
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                       const SizedBox(height: 8),
//                                       Row(
//                                         children: [
//                                           IconButton(
//                                             onPressed: () => widget
//                                                 .onUpdateQuantity(index, -1),
//                                             icon: const Icon(
//                                               Icons.remove_circle_outline,
//                                               color: Colors.black54,
//                                             ),
//                                             padding: EdgeInsets.zero,
//                                             constraints: const BoxConstraints(),
//                                           ),
//                                           const SizedBox(width: 8),
//                                           Text(
//                                             cartItem.quantity.toString(),
//                                             style: const TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                           const SizedBox(width: 8),
//                                           IconButton(
//                                             onPressed: () => widget
//                                                 .onUpdateQuantity(index, 1),
//                                             icon: const Icon(
//                                               Icons.add_circle_outline,
//                                               color: Colors.black54,
//                                             ),
//                                             padding: EdgeInsets.zero,
//                                             constraints: const BoxConstraints(),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Column(
//                                   children: [
//                                     IconButton(
//                                       onPressed: () => widget.onRemove(index),
//                                       icon: const Icon(
//                                         Icons.delete_outline,
//                                         color: Colors.redAccent,
//                                       ),
//                                       padding: EdgeInsets.zero,
//                                     ),
//                                     const SizedBox(height: 8),
//                                     Text(
//                                       '₹ ${cartItem.totalPrice.toStringAsFixed(0)}',
//                                       style: const TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black87,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//           ),

//           // Total & Checkout
//           if (widget.cartItems.isNotEmpty)
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.08),
//                     blurRadius: 10,
//                     offset: const Offset(0, -2),
//                   ),
//                 ],
//               ),
//               child: SafeArea(
//                 child: Padding(
//                   padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             'Total',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           Text(
//                             '₹ ${_totalPrice.toStringAsFixed(0)}',
//                             style: const TextStyle(
//                               fontSize: 22,
//                               fontWeight: FontWeight.bold,
//                               color: Color(0xFFE53935),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 16),
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFFE53935),
//                             padding: const EdgeInsets.symmetric(vertical: 14),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (_) => CheckoutScreen(
//                                   cartItems: widget.cartItems,
//                                   totalPrice: _totalPrice,
//                                   onClearCart: widget.onClearCart,
//                                 ),
//                               ),
//                             );
//                           },
//                           child: const Text(
//                             'Proceed to Checkout',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// // ProfileScreen moved to profile_view.dart
