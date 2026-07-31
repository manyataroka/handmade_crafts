// import 'package:flutter_test/flutter_test.dart';
// import 'package:handmade_crafts/features/chatbot/data/chatbot_service.dart';

// void main() {
//   group('ChatbotService Tests', () {
//     test('greeting returns welcome message with no products', () {
//       final response = ChatbotService.getResponse('hello');

//       expect(response.message, contains('Welcome'));
//       expect(response.products, isEmpty);
//     });

//     test('greeting with namaste returns welcome message', () {
//       final response = ChatbotService.getResponse('Namaste');

//       expect(response.message, contains('Welcome'));
//       expect(response.products, isEmpty);
//     });

//     test('price query under ₹600 returns filtered products', () {
//       final response = ChatbotService.getResponse('under ₹600');

//       expect(response.message, contains('under'));
//       expect(response.products, isNotEmpty);
//       // All returned products should be 600 or below
//       for (final product in response.products) {
//         expect(product.price, lessThanOrEqualTo(600));
//       }
//     });

//     test('price query for earrings under budget returns filtered results', () {
//       final response = ChatbotService.getResponse(
//         'show me earrings under ₹600',
//       );

//       expect(response.message, contains('Earrings'));
//       expect(response.products, isNotEmpty);
//       for (final product in response.products) {
//         expect(product.category, 'earring');
//         expect(product.price, lessThanOrEqualTo(600));
//       }
//     });

//     test('category query for earrings returns earring products', () {
//       final response = ChatbotService.getResponse('show me handmade earrings');

//       expect(
//         response.message,
//         anyOf(contains('Earrings'), contains('earring')),
//       );
//       expect(response.products, isNotEmpty);
//       for (final product in response.products) {
//         expect(product.category, 'earring');
//       }
//     });

//     test('category query for necklaces returns necklace products', () {
//       final response = ChatbotService.getResponse('Show me necklaces');

//       expect(
//         response.message,
//         anyOf(contains('Necklaces'), contains('necklace')),
//       );
//       expect(response.products, isNotEmpty);
//       for (final product in response.products) {
//         expect(product.category, 'necklace');
//       }
//     });

//     test('birthday gift query returns recommendations with products', () {
//       final response = ChatbotService.getResponse(
//         'What gift is suitable for a birthday?',
//       );

//       expect(response.message, contains('Birthday'));
//       expect(response.products, isNotEmpty);
//     });

//     test('black dress outfit query returns matching recommendations', () {
//       final response = ChatbotService.getResponse('jewellery for black dress');

//       expect(response.message, contains('Black'));
//       expect(response.products, isNotEmpty);
//     });

//     test(
//       'anniversary query returns anniversary recommendations with products',
//       () {
//         final response = ChatbotService.getResponse('gift for anniversary');

//         expect(response.message, contains('Anniversary'));
//         expect(response.products, isNotEmpty);
//       },
//     );

//     test('fallback response for unknown query returns helpful suggestions', () {
//       final response = ChatbotService.getResponse('xyz123 unknown query');

//       expect(response.message, contains('not sure'));
//       expect(response.message, contains('Try'));
//     });

//     test('show all query returns complete catalog', () {
//       final response = ChatbotService.getResponse('Show all products');

//       expect(response.message, contains('Complete Collection'));
//       expect(response.products, isNotEmpty);
//       expect(response.products.length, greaterThan(5));
//     });

//     test('what can you do query returns help info', () {
//       final response = ChatbotService.getResponse('what can you do');

//       expect(response.message, contains('Hi'));
//       expect(response.message, contains('help'));
//     });

//     test('wedding query returns bridal recommendations', () {
//       final response = ChatbotService.getResponse('wedding gift');

//       expect(response.message, anyOf(contains('Wedding'), contains('Bridal')));
//       expect(response.products, isNotEmpty);
//     });

//     test('diwali festival query returns festive collection', () {
//       final response = ChatbotService.getResponse('Diwali festival gift');

//       expect(response.message, anyOf(contains('Festive'), contains('festive')));
//       expect(response.products, isNotEmpty);
//     });
//   });
// }
