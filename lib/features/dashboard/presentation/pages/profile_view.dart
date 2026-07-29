// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:handmade_crafts/features/auth/presentation/pages/login_view.dart';
// import 'settings_view.dart';
// import 'orders_view.dart' show OrdersScreen;
// import 'dashboard_view.dart';

// class ProfileScreen extends StatefulWidget {
//   final Future<void> Function(JewelryItem item, int quantity)? onAddToCart;

//   const ProfileScreen({super.key, this.onAddToCart});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   bool _loading = true;
//   List<String> _favoritesList = [];
//   String? _imagePath;
//   String _name = '';
//   String _email = '';
//   bool _showFavorites = false;
//   bool _obscurePassword = true;

//   late TextEditingController _nameController;
//   late TextEditingController _usernameController;
//   late TextEditingController _emailController;
//   late TextEditingController _passwordController;

//   final ImagePicker _picker = ImagePicker();

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

//   List<JewelryItem> get _favoriteItems {
//     return _allItems
//         .where((item) => _favoritesList.contains(item.name))
//         .toList();
//   }

//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController();
//     _usernameController = TextEditingController();
//     _emailController = TextEditingController();
//     _passwordController = TextEditingController();
//     _loadProfile();
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _usernameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   Future<void> _loadProfile() async {
//     final prefs = await SharedPreferences.getInstance();
//     final name =
//         prefs.getString('user_full_name') ??
//         prefs.getString('user_username') ??
//         prefs.getString('username') ??
//         '';
//     final username =
//         prefs.getString('user_username') ?? prefs.getString('username') ?? '';
//     final email =
//         prefs.getString('user_email') ?? prefs.getString('email') ?? '';
//     final favs = prefs.getStringList('favorites') ?? [];
//     final img =
//         prefs.getString('user_profile_picture') ??
//         prefs.getString('profile_image_path');

//     if (!mounted) return;
//     setState(() {
//       _name = name;
//       _email = email;
//       _favoritesList = favs;
//       _imagePath = img;
//       _nameController.text = name;
//       _usernameController.text = username;
//       _emailController.text = email;
//       _loading = false;
//     });
//   }

//   Future<void> _saveProfile() async {
//     final prefs = await SharedPreferences.getInstance();
//     final newName = _nameController.text.trim();
//     final newUsername = _usernameController.text.trim();
//     final newEmail = _emailController.text.trim();
//     final newPassword = _passwordController.text.trim();

//     if (newName.isNotEmpty) {
//       await prefs.setString('user_full_name', newName);
//     }
//     if (newUsername.isNotEmpty) {
//       await prefs.setString('user_username', newUsername);
//       await prefs.setString('username', newUsername);
//     }
//     if (newEmail.isNotEmpty) {
//       await prefs.setString('user_email', newEmail);
//       await prefs.setString('email', newEmail);
//     }
//     if (newPassword.isNotEmpty) {
//       await prefs.setString('password', newPassword);
//     }

//     if (!mounted) return;
//     setState(() {
//       _name = newName.isNotEmpty ? newName : _name;
//       _email = newEmail.isNotEmpty ? newEmail : _email;
//       _passwordController.clear();
//     });
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Profile updated successfully'),
//         backgroundColor: Colors.green,
//       ),
//     );
//   }

//   Future<void> _toggleFavorite(JewelryItem item) async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       if (_favoritesList.contains(item.name)) {
//         _favoritesList.remove(item.name);
//       } else {
//         _favoritesList.add(item.name);
//       }
//     });
//     await prefs.setStringList('favorites', _favoritesList);
//   }

//   Future<void> _pickImage() async {
//     try {
//       final XFile? picked = await _picker.pickImage(
//         source: ImageSource.gallery,
//         maxWidth: 800,
//         maxHeight: 800,
//         imageQuality: 85,
//       );
//       if (picked == null) return;

//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString('profile_image_path', picked.path);
//       await prefs.setString('user_profile_picture', picked.path);

//       if (!mounted) return;
//       setState(() => _imagePath = picked.path);
//     } catch (_) {
//       if (!mounted) return;
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('Failed to pick image')));
//     }
//   }

//   Future<void> _removeImage() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('profile_image_path');
//     await prefs.remove('user_profile_picture');
//     if (!mounted) return;
//     setState(() => _imagePath = null);
//   }

//   Future<void> _logout() async {
//     final confirm = await showDialog<bool>(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         title: const Text('Logout'),
//         content: const Text('Are you sure you want to logout?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(ctx, false),
//             child: const Text(
//               'Cancel',
//               style: TextStyle(color: Colors.black54),
//             ),
//           ),
//           TextButton(
//             onPressed: () => Navigator.pop(ctx, true),
//             child: const Text(
//               'Logout',
//               style: TextStyle(color: Colors.redAccent),
//             ),
//           ),
//         ],
//       ),
//     );

//     if (confirm != true || !mounted) return;

//     final prefs = await SharedPreferences.getInstance();
//     await prefs.clear();
//     if (!mounted) return;
//     Navigator.of(context).pushAndRemoveUntil(
//       MaterialPageRoute(builder: (_) => const LoginView()),
//       (route) => false,
//     );
//   }

//   String _initialsFromName(String name) {
//     final parts = name.trim().split(RegExp(r'\s+'));
//     if (parts.isEmpty || parts[0].isEmpty) return '?';
//     if (parts.length == 1) return parts[0][0].toUpperCase();
//     return (parts[0][0] + parts[1][0]).toUpperCase();
//   }

//   void _showProductSheet(BuildContext context, JewelryItem item) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (ctx) {
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
//                                   color: Colors.black45,
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
//                                     color: Colors.redAccent,
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
//                             backgroundColor: Colors.redAccent,
//                           ),
//                           onPressed: () async {
//                             if (widget.onAddToCart != null) {
//                               await widget.onAddToCart!(item, qty);
//                             }
//                             if (ctx.mounted) {
//                               Navigator.of(ctx).pop();
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
//     return Scaffold(
//       backgroundColor: const Color(0xFFFCEEEE),
//       body: SafeArea(
//         child: _loading
//             ? const Center(child: CircularProgressIndicator())
//             : SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Row(
//                       children: [
//                         Icon(Icons.person, color: Colors.redAccent, size: 28),
//                         SizedBox(width: 12),
//                         Text(
//                           'Profile',
//                           style: TextStyle(
//                             fontSize: 22,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black87,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 24),

//                     // ── Centered Profile Picture ──
//                     Center(
//                       child: GestureDetector(
//                         onTap: _pickImage,
//                         child: Stack(
//                           children: [
//                             CircleAvatar(
//                               radius: 60,
//                               backgroundColor: const Color(0xFFF5F0EB),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(60),
//                                 child:
//                                     _imagePath != null &&
//                                         File(_imagePath!).existsSync()
//                                     ? Image.file(
//                                         File(_imagePath!),
//                                         width: 120,
//                                         height: 120,
//                                         fit: BoxFit.cover,
//                                       )
//                                     : Text(
//                                         _initialsFromName(_name),
//                                         style: const TextStyle(
//                                           fontSize: 32,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.black54,
//                                         ),
//                                       ),
//                               ),
//                             ),
//                             Positioned(
//                               bottom: 4,
//                               right: 4,
//                               child: Container(
//                                 padding: const EdgeInsets.all(6),
//                                 decoration: const BoxDecoration(
//                                   color: Colors.redAccent,
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child: const Icon(
//                                   Icons.camera_alt,
//                                   size: 18,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 12),

//                     // ── Change Photo Button ──
//                     Center(
//                       child: Wrap(
//                         spacing: 4,
//                         alignment: WrapAlignment.center,
//                         children: [
//                           TextButton.icon(
//                             onPressed: _pickImage,
//                             icon: const Icon(
//                               Icons.photo_camera_outlined,
//                               size: 18,
//                             ),
//                             label: const Text('Change Photo'),
//                             style: TextButton.styleFrom(
//                               foregroundColor: Colors.redAccent,
//                             ),
//                           ),
//                           if (_imagePath != null)
//                             TextButton(
//                               onPressed: _removeImage,
//                               child: const Text('Remove'),
//                               style: TextButton.styleFrom(
//                                 foregroundColor: Colors.black45,
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 24),

//                     // ── Always-Editable Profile Fields ──
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.04),
//                             blurRadius: 8,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       padding: const EdgeInsets.all(16),
//                       child: Column(
//                         children: [
//                           TextField(
//                             controller: _nameController,
//                             decoration: InputDecoration(
//                               labelText: 'First Name',
//                               prefixIcon: const Icon(Icons.person_outline),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 12),
//                           TextField(
//                             controller: _usernameController,
//                             decoration: InputDecoration(
//                               labelText: 'Username',
//                               prefixIcon: const Icon(
//                                 Icons.account_circle_outlined,
//                               ),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 12),
//                           TextField(
//                             controller: _emailController,
//                             decoration: InputDecoration(
//                               labelText: 'Email',
//                               prefixIcon: const Icon(Icons.email_outlined),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                             keyboardType: TextInputType.emailAddress,
//                           ),
//                           const SizedBox(height: 12),
//                           TextField(
//                             controller: _passwordController,
//                             obscureText: _obscurePassword,
//                             decoration: InputDecoration(
//                               labelText: 'Password',
//                               prefixIcon: const Icon(Icons.lock_outline),
//                               suffixIcon: IconButton(
//                                 icon: Icon(
//                                   _obscurePassword
//                                       ? Icons.visibility_off
//                                       : Icons.visibility,
//                                   color: Colors.black54,
//                                 ),
//                                 onPressed: () {
//                                   setState(
//                                     () => _obscurePassword = !_obscurePassword,
//                                   );
//                                 },
//                               ),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 16),
//                           SizedBox(
//                             width: double.infinity,
//                             child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.redAccent,
//                                 foregroundColor: Colors.white,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 padding: const EdgeInsets.symmetric(
//                                   vertical: 14,
//                                 ),
//                               ),
//                               onPressed: _saveProfile,
//                               child: const Text(
//                                 'Save Changes',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 24),

//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.04),
//                             blurRadius: 8,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         children: [
//                           ListTile(
//                             leading: const Icon(
//                               Icons.favorite,
//                               color: Colors.redAccent,
//                             ),
//                             title: const Text('Favorites'),
//                             subtitle: Text('${_favoritesList.length} items'),
//                             trailing: Icon(
//                               _showFavorites
//                                   ? Icons.expand_less
//                                   : Icons.expand_more,
//                               color: Colors.black45,
//                             ),
//                             onTap: () {
//                               setState(() => _showFavorites = !_showFavorites);
//                             },
//                           ),
//                           if (_showFavorites)
//                             _favoritesList.isEmpty
//                                 ? const Padding(
//                                     padding: EdgeInsets.all(20),
//                                     child: Text(
//                                       'No favorite items yet',
//                                       style: TextStyle(color: Colors.black54),
//                                     ),
//                                   )
//                                 : Padding(
//                                     padding: const EdgeInsets.fromLTRB(
//                                       16,
//                                       0,
//                                       16,
//                                       16,
//                                     ),
//                                     child: GridView.builder(
//                                       physics:
//                                           const NeverScrollableScrollPhysics(),
//                                       shrinkWrap: true,
//                                       gridDelegate:
//                                           const SliverGridDelegateWithFixedCrossAxisCount(
//                                             crossAxisCount: 2,
//                                             mainAxisSpacing: 12,
//                                             crossAxisSpacing: 12,
//                                             childAspectRatio: 0.7,
//                                           ),
//                                       itemCount: _favoriteItems.length,
//                                       itemBuilder: (context, index) {
//                                         final item = _favoriteItems[index];
//                                         return GestureDetector(
//                                           onTap: () =>
//                                               _showProductSheet(context, item),
//                                           child: Container(
//                                             decoration: BoxDecoration(
//                                               color: const Color(0xFFF5F0EB),
//                                               borderRadius:
//                                                   BorderRadius.circular(12),
//                                             ),
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.center,
//                                               children: [
//                                                 ClipRRect(
//                                                   borderRadius:
//                                                       const BorderRadius.vertical(
//                                                         top: Radius.circular(
//                                                           12,
//                                                         ),
//                                                       ),
//                                                   child: Image.asset(
//                                                     item.imagePath,
//                                                     width: double.infinity,
//                                                     height: 100,
//                                                     fit: BoxFit.cover,
//                                                     errorBuilder: (c, e, s) =>
//                                                         Container(
//                                                           color: const Color(
//                                                             0xFFF5F0EB,
//                                                           ),
//                                                           height: 100,
//                                                           child: const Icon(
//                                                             Icons
//                                                                 .image_not_supported_outlined,
//                                                             color:
//                                                                 Colors.black45,
//                                                           ),
//                                                         ),
//                                                   ),
//                                                 ),
//                                                 Padding(
//                                                   padding: const EdgeInsets.all(
//                                                     8.0,
//                                                   ),
//                                                   child: Column(
//                                                     children: [
//                                                       Text(
//                                                         item.name,
//                                                         textAlign:
//                                                             TextAlign.center,
//                                                         maxLines: 2,
//                                                         overflow: TextOverflow
//                                                             .ellipsis,
//                                                         style: const TextStyle(
//                                                           fontSize: 12,
//                                                           fontWeight:
//                                                               FontWeight.bold,
//                                                         ),
//                                                       ),
//                                                       const SizedBox(height: 4),
//                                                       Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .spaceBetween,
//                                                         children: [
//                                                           Text(
//                                                             '₹ ${item.price.toStringAsFixed(0)}',
//                                                             style:
//                                                                 const TextStyle(
//                                                                   fontSize: 12,
//                                                                   color: Colors
//                                                                       .redAccent,
//                                                                 ),
//                                                           ),
//                                                           GestureDetector(
//                                                             onTap: () =>
//                                                                 _toggleFavorite(
//                                                                   item,
//                                                                 ),
//                                                             child: const Icon(
//                                                               Icons
//                                                                   .favorite_rounded,
//                                                               color: Colors
//                                                                   .redAccent,
//                                                               size: 18,
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         );
//                                       },
//                                     ),
//                                   ),
//                           const Divider(height: 0, indent: 16, endIndent: 16),
//                           ListTile(
//                             leading: const Icon(
//                               Icons.shopping_bag_outlined,
//                               color: Colors.black54,
//                             ),
//                             title: const Text('Orders'),
//                             subtitle: const Text('View past orders'),
//                             trailing: const Icon(
//                               Icons.chevron_right,
//                               color: Colors.black45,
//                             ),
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (_) => const OrdersScreen(),
//                                 ),
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 20),

//                     // ── App Settings Navigate Tile ──
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.04),
//                             blurRadius: 8,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         children: [
//                           ListTile(
//                             leading: const Icon(
//                               Icons.settings,
//                               color: Colors.redAccent,
//                             ),
//                             title: const Text(
//                               'App Settings',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                             trailing: const Icon(
//                               Icons.chevron_right,
//                               color: Colors.black45,
//                             ),
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (_) => const SettingsScreen(),
//                                 ),
//                               );
//                             },
//                           ),
//                           const Divider(height: 0, indent: 16, endIndent: 16),
//                           ListTile(
//                             leading: const Icon(
//                               Icons.description_outlined,
//                               color: Colors.black54,
//                             ),
//                             title: const Text(
//                               'Policies',
//                               style: TextStyle(color: Colors.black87),
//                             ),
//                             trailing: const Icon(
//                               Icons.chevron_right,
//                               color: Colors.black45,
//                             ),
//                             onTap: () {
//                               showDialog(
//                                 context: context,
//                                 builder: (ctx) => AlertDialog(
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(16),
//                                   ),
//                                   title: const Text('Policies'),
//                                   content: const SingleChildScrollView(
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           '1. Return & Refund Policy',
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         SizedBox(height: 4),
//                                         Text(
//                                           'Items can be returned within 7 days of delivery in original condition. Refunds will be processed within 5-7 business days.',
//                                           style: TextStyle(
//                                             color: Colors.black54,
//                                           ),
//                                         ),
//                                         SizedBox(height: 16),
//                                         Text(
//                                           '2. Shipping Policy',
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         SizedBox(height: 4),
//                                         Text(
//                                           'Free shipping on orders above ₹500. Standard delivery takes 3-7 business days.',
//                                           style: TextStyle(
//                                             color: Colors.black54,
//                                           ),
//                                         ),
//                                         SizedBox(height: 16),
//                                         Text(
//                                           '3. Privacy Policy',
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         SizedBox(height: 4),
//                                         Text(
//                                           'Your personal information is kept secure and never shared with third parties without your consent.',
//                                           style: TextStyle(
//                                             color: Colors.black54,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   actions: [
//                                     TextButton(
//                                       onPressed: () => Navigator.pop(ctx),
//                                       child: const Text(
//                                         'Close',
//                                         style: TextStyle(
//                                           color: Colors.redAccent,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                           ),
//                           const Divider(height: 0, indent: 16, endIndent: 16),
//                           ListTile(
//                             leading: const Icon(
//                               Icons.help_outline,
//                               color: Colors.black54,
//                             ),
//                             title: const Text(
//                               'Help & Support',
//                               style: TextStyle(color: Colors.black87),
//                             ),
//                             trailing: const Icon(
//                               Icons.chevron_right,
//                               color: Colors.black45,
//                             ),
//                             onTap: () {
//                               showDialog(
//                                 context: context,
//                                 builder: (ctx) => AlertDialog(
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(16),
//                                   ),
//                                   title: const Text('Help & Support'),
//                                   content: const Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         'FAQs',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       SizedBox(height: 8),
//                                       Text(
//                                         '• How to place an order?\nBrowse products, add to cart, and proceed to checkout.',
//                                         style: TextStyle(color: Colors.black54),
//                                       ),
//                                       SizedBox(height: 8),
//                                       Text(
//                                         '• How to track my order?\nGo to Orders section in your profile to view status.',
//                                         style: TextStyle(color: Colors.black54),
//                                       ),
//                                       SizedBox(height: 8),
//                                       Text(
//                                         '• How to cancel an order?\nContact our support team within 24 hours of placing the order.',
//                                         style: TextStyle(color: Colors.black54),
//                                       ),
//                                     ],
//                                   ),
//                                   actions: [
//                                     TextButton(
//                                       onPressed: () => Navigator.pop(ctx),
//                                       child: const Text(
//                                         'Close',
//                                         style: TextStyle(
//                                           color: Colors.redAccent,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                           ),
//                           const Divider(height: 0, indent: 16, endIndent: 16),
//                           ListTile(
//                             leading: const Icon(
//                               Icons.info_outline,
//                               color: Colors.black54,
//                             ),
//                             title: const Text(
//                               'About Us',
//                               style: TextStyle(color: Colors.black87),
//                             ),
//                             trailing: const Icon(
//                               Icons.chevron_right,
//                               color: Colors.black45,
//                             ),
//                             onTap: () {
//                               showDialog(
//                                 context: context,
//                                 builder: (ctx) => AlertDialog(
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(16),
//                                   ),
//                                   title: const Text('About Us'),
//                                   content: const Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         'Handmade Crafts',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 18,
//                                         ),
//                                       ),
//                                       SizedBox(height: 12),
//                                       Text(
//                                         'We are a passionate team dedicated to bringing you the finest handmade jewelry and crafts. Each piece is carefully curated to ensure quality and uniqueness.',
//                                         style: TextStyle(color: Colors.black54),
//                                       ),
//                                       SizedBox(height: 12),
//                                       Text(
//                                         'Our mission is to support local artisans and provide customers with authentic, handcrafted products that tell a story.',
//                                         style: TextStyle(color: Colors.black54),
//                                       ),
//                                       SizedBox(height: 12),
//                                       Text(
//                                         'Version: 1.0.0',
//                                         style: TextStyle(color: Colors.black45),
//                                       ),
//                                     ],
//                                   ),
//                                   actions: [
//                                     TextButton(
//                                       onPressed: () => Navigator.pop(ctx),
//                                       child: const Text(
//                                         'Close',
//                                         style: TextStyle(
//                                           color: Colors.redAccent,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                           ),
//                           const Divider(height: 0, indent: 16, endIndent: 16),
//                           ListTile(
//                             leading: const Icon(
//                               Icons.phone_outlined,
//                               color: Colors.black54,
//                             ),
//                             title: const Text(
//                               'Call Us',
//                               style: TextStyle(color: Colors.black87),
//                             ),
//                             subtitle: const Text(
//                               '+977-9812345678',
//                               style: TextStyle(color: Colors.black54),
//                             ),
//                             trailing: const Icon(
//                               Icons.chevron_right,
//                               color: Colors.black45,
//                             ),
//                             onTap: () {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                   content: Text('Calling +977-9812345678...'),
//                                   backgroundColor: Colors.redAccent,
//                                 ),
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 24),

//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton.icon(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.redAccent,
//                           foregroundColor: Colors.white,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           elevation: 0,
//                         ),
//                         onPressed: _logout,
//                         icon: const Icon(Icons.logout, size: 18),
//                         label: const Padding(
//                           padding: EdgeInsets.symmetric(vertical: 12),
//                           child: Text(
//                             'Log out',
//                             style: TextStyle(fontSize: 15),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//       ),
//     );
//   }
// }
