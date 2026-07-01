// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   bool _loading = true;
//   int _favoritesCount = 0;
//   String? _imagePath;
//   String _name = '';
//   String _email = '';

//   final ImagePicker _picker = ImagePicker();

//   @override
//   void initState() {
//     super.initState();
//     _loadProfile();
//   }

//   // ── Load saved profile data using login keys ──
//   Future<void> _loadProfile() async {
//     final prefs = await SharedPreferences.getInstance();
//     final name = prefs.getString('username') ?? '';
//     final email = prefs.getString('email') ?? '';
//     final favs = prefs.getStringList('favorites') ?? [];
//     final img = prefs.getString('profile_image_path');

//     if (!mounted) return;
//     setState(() {
//       _name = name;
//       _email = email;
//       _favoritesCount = favs.length;
//       _imagePath = img;
//       _loading = false;
//     });
//   }

//   // ── Pick image from gallery ──
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

//       if (!mounted) return;
//       setState(() => _imagePath = picked.path);
//     } catch (_) {
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Failed to pick image')),
//       );
//     }
//   }

//   // ── Remove profile image ──
//   Future<void> _removeImage() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('profile_image_path');
//     if (!mounted) return;
//     setState(() => _imagePath = null);
//   }

//   // ── Logout — clears all data and navigates to login ──
//   Future<void> _logout() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.clear();
//     if (!mounted) return;
//     Navigator.of(context).pushNamedAndRemoveUntil(
//       '/login',
//       (route) => false, // clears entire stack so user can't press back
//     );
//   }

//   // ── Initials from name ──
//   String _initialsFromName(String name) {
//     final parts = name.trim().split(RegExp(r'\s+'));
//     if (parts.isEmpty || parts[0].isEmpty) return '?';
//     if (parts.length == 1) return parts[0][0].toUpperCase();
//     return (parts[0][0] + parts[1][0]).toUpperCase();
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

//                     // ── Header ──
//                     const Row(
//                       children: [
//                         Icon(Icons.person, color: Color(0xFFE53935), size: 28),
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

//                     // ── Avatar + name/email ──
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         // Avatar — tap to pick image
//                         GestureDetector(
//                           onTap: _pickImage,
//                           child: Stack(
//                             children: [
//                               CircleAvatar(
//                                 radius: 40,
//                                 backgroundColor: const Color(0xFFF5F0EB),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(40),
//                                   child: _imagePath != null &&
//                                           File(_imagePath!).existsSync()
//                                       ? Image.file(
//                                           File(_imagePath!),
//                                           width: 80,
//                                           height: 80,
//                                           fit: BoxFit.cover,
//                                         )
//                                       : Text(
//                                           _initialsFromName(_name),
//                                           style: const TextStyle(
//                                             fontSize: 22,
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.black54,
//                                           ),
//                                         ),
//                                 ),
//                               ),
//                               // Camera badge
//                               Positioned(
//                                 bottom: 0,
//                                 right: 0,
//                                 child: Container(
//                                   padding: const EdgeInsets.all(4),
//                                   decoration: const BoxDecoration(
//                                     color: Color(0xFFE53935),
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: const Icon(
//                                     Icons.camera_alt,
//                                     size: 14,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(width: 16),

//                         // Name & email
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 _name.isNotEmpty ? _name : '—',
//                                 style: const TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.black87,
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               Text(
//                                 _email.isNotEmpty ? _email : '—',
//                                 style: const TextStyle(
//                                   color: Colors.black54,
//                                   fontSize: 13,
//                                 ),
//                               ),
//                               const SizedBox(height: 8),
//                               // Change / Remove photo
//                               Wrap(
//                                 spacing: 4,
//                                 children: [
//                                   TextButton.icon(
//                                     style: TextButton.styleFrom(
//                                       padding: EdgeInsets.zero,
//                                       minimumSize: Size.zero,
//                                       tapTargetSize:
//                                           MaterialTapTargetSize.shrinkWrap,
//                                     ),
//                                     onPressed: _pickImage,
//                                     icon: const Icon(
//                                         Icons.photo_camera_outlined,
//                                         size: 16),
//                                     label: const Text('Change photo',
//                                         style: TextStyle(fontSize: 12)),
//                                   ),
//                                   if (_imagePath != null)
//                                     TextButton(
//                                       style: TextButton.styleFrom(
//                                         padding: EdgeInsets.zero,
//                                         minimumSize: Size.zero,
//                                         tapTargetSize:
//                                             MaterialTapTargetSize.shrinkWrap,
//                                         foregroundColor: Colors.black45,
//                                       ),
//                                       onPressed: _removeImage,
//                                       child: const Text('Remove',
//                                           style: TextStyle(fontSize: 12)),
//                                     ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 24),

//                     // ── Quick actions ──
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
//                             leading: const Icon(Icons.favorite,
//                                 color: Color(0xFFE53935)),
//                             title: const Text('Favorites'),
//                             subtitle: Text('$_favoritesCount items'),
//                             trailing: const Icon(Icons.chevron_right,
//                                 color: Colors.black26),
//                             onTap: () {},
//                           ),
//                           const Divider(height: 0, indent: 16, endIndent: 16),
//                           ListTile(
//                             leading: const Icon(Icons.shopping_bag_outlined,
//                                 color: Colors.black54),
//                             title: const Text('Orders'),
//                             subtitle: const Text('View past orders'),
//                             trailing: const Icon(Icons.chevron_right,
//                                 color: Colors.black26),
//                             onTap: () {},
//                           ),
//                           const Divider(height: 0, indent: 16, endIndent: 16),
//                           ListTile(
//                             leading: const Icon(Icons.settings_outlined,
//                                 color: Colors.black54),
//                             title: const Text('App Settings'),
//                             trailing: const Icon(Icons.chevron_right,
//                                 color: Colors.black26),
//                             onTap: () {},
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 24),

//                     // ── Logout — solid red button ──
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton.icon(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFFE53935),
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