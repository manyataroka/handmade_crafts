// import 'package:flutter/material.dart';

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

// // ==================== MODEL ====================

// class JewelryItem {
//   final String name;
//   final double price;
//   final String imagePath;
//   bool isFavorited;

//   JewelryItem({
//     required this.name,
//     required this.price,
//     required this.imagePath,
//     this.isFavorited = false,
//   });
// }

// // ==================== DASHBOARD SCREEN ====================

// class DashboardScreenView extends StatefulWidget {
//   const DashboardScreenView({super.key});

//   @override
//   State<DashboardScreenView> createState() => _DashboardScreenViewState();
// }

// class _DashboardScreenViewState extends State<DashboardScreenView> {
//   int _selectedIndex = 0;

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFCEEEE),
//       body: IndexedStack(
//         index: _selectedIndex,
//         children: const [
//           HomeScreen(),
//           MenuScreen(),
//           CartScreen(),
//           ProfileScreen(),
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
//               _NavItem(
//                 icon: Icons.shopping_cart_outlined,
//                 filledIcon: Icons.shopping_cart,
//                 index: 2,
//                 selectedIndex: _selectedIndex,
//                 onTap: _onItemTapped,
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

// // ==================== HOME SCREEN ====================

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedFilter = 0;
//   final List<String> _filters = ['Trending Now', 'All', 'Now'];

//   final List<JewelryItem> _items = [
//     JewelryItem(
//       name: 'Beads Necklace',
//       price: 400,
//       imagePath: 'assets/images/img2.png',
//     ),
//     JewelryItem(
//       name: 'Round Chain',
//       price: 325,
//       imagePath: 'assets/images/img3.png',
//     ),
//     JewelryItem(
//       name: 'Beads Pearl Bracelet',
//       price: 450,
//       imagePath: 'assets/images/img4.png',
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: CustomScrollView(
//         slivers: [
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Grid menu icon
//                   const Icon(
//                     Icons.grid_view_rounded,
//                     color: Color(0xFFE53935),
//                     size: 28,
//                   ),
//                   const SizedBox(height: 20),

//                   // Title
//                   const Text(
//                     'Match Your Style',
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   const SizedBox(height: 16),

//                   // Search bar
//                   _SearchBar(),
//                   const SizedBox(height: 18),

//                   // Filter chips
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

//           // 2-column product grid (first 2 items)
//           SliverPadding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             sliver: SliverGrid(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 16,
//                 crossAxisSpacing: 12,
//                 childAspectRatio: 0.75,
//               ),
//               delegate: SliverChildBuilderDelegate(
//                 (context, index) {
//                   return _ProductCard(
//                     item: _items[index],
//                     onFavoriteToggle: () {
//                       setState(() {
//                         _items[index].isFavorited = !_items[index].isFavorited;
//                       });
//                     },
//                   );
//                 },
//                 childCount: 2, // only first 2 in grid
//               ),
//             ),
//           ),

//           // Full-width card (3rd item)
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
//               child: _WideProductCard(
//                 item: _items[2],
//                 onFavoriteToggle: () {
//                   setState(() {
//                     _items[2].isFavorited = !_items[2].isFavorited;
//                   });
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ==================== SEARCH BAR ====================

// class _SearchBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 48,
//       decoration: BoxDecoration(
//         color: const Color(0xFFEEEEEE),
//         borderRadius: BorderRadius.circular(30),
//       ),
//       child: const Row(
//         children: [
//           SizedBox(width: 14),
//           Icon(Icons.search, color: Colors.black54, size: 22),
//           SizedBox(width: 8),
//           Text('Search', style: TextStyle(color: Colors.black45, fontSize: 16)),
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
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           // Image area
//           Expanded(
//             child: Stack(
//               fit: StackFit.expand,
//               children: [
//                 ClipRRect(
//                   borderRadius: const BorderRadius.vertical(
//                     top: Radius.circular(16),
//                   ),
//                   child: Image.asset(
//                     item.imagePath,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) => Container(
//                       color: const Color(0xFFF5F0EB),
//                       child: const Center(
//                         child: Icon(
//                           Icons.image_not_supported_outlined,
//                           size: 40,
//                           color: Colors.black26,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 // Heart icon
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

//           // Name & Price
//           Padding(
//             padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
//             child: Column(
//               children: [
//                 Text(
//                   item.name,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 13.5,
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

// // ==================== WIDE PRODUCT CARD ====================

// class _WideProductCard extends StatelessWidget {
//   final JewelryItem item;
//   final VoidCallback onFavoriteToggle;

//   const _WideProductCard({required this.item, required this.onFavoriteToggle});

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
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           // Image area
//           Stack(
//             children: [
//               ClipRRect(
//                 borderRadius: const BorderRadius.vertical(
//                   top: Radius.circular(16),
//                 ),
//                 child: SizedBox(
//                   width: double.infinity,
//                   height: 220,
//                   child: Image.asset(
//                     item.imagePath,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) => Container(
//                       color: const Color(0xFFF5F0EB),
//                       child: const Center(
//                         child: Icon(
//                           Icons.image_not_supported_outlined,
//                           size: 56,
//                           color: Colors.black26,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               // Heart icon
//               Positioned(
//                 top: 10,
//                 right: 10,
//                 child: GestureDetector(
//                   onTap: onFavoriteToggle,
//                   child: Container(
//                     padding: const EdgeInsets.all(4),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.85),
//                       shape: BoxShape.circle,
//                     ),
//                     child: Icon(
//                       item.isFavorited ? Icons.favorite : Icons.favorite_border,
//                       color: const Color(0xFFE53935),
//                       size: 22,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           // Name & Price
//           Padding(
//             padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
//             child: Column(
//               children: [
//                 Text(
//                   item.name,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 15,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   '₹ ${item.price.toStringAsFixed(0)}',
//                   style: const TextStyle(
//                     color: Color(0xFFE53935),
//                     fontWeight: FontWeight.w600,
//                     fontSize: 14,
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

// // ==================== OTHER SCREENS ====================

// class MenuScreen extends StatelessWidget {
//   const MenuScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const SafeArea(
//       child: Center(
//         child: Text(
//           'Menu',
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
// }

// class CartScreen extends StatelessWidget {
//   const CartScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const SafeArea(
//       child: Center(
//         child: Text(
//           'Cart',
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
// }

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const SafeArea(
//       child: Center(
//         child: Text(
//           'Profile',
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
// }
