/// Represents a product in our catalog
class ChatbotProduct {
  final String name;
  final double price;
  final String imagePath;
  final String category;

  const ChatbotProduct({
    required this.name,
    required this.price,
    required this.imagePath,
    required this.category,
  });
}

/// Represents a chatbot response
class ChatbotResponse {
  final String message;
  final List<ChatbotProduct> products;

  const ChatbotResponse({required this.message, this.products = const []});
}

/// Smart rule-based chatbot engine for jewelry queries
class ChatbotService {
  // ── Complete Product Catalog (mirrors app's items) ──
  static const List<ChatbotProduct> _catalog = [
    ChatbotProduct(
      name: 'Pearl Beads Bracelet',
      price: 699,
      imagePath: 'assets/images/img5.jpg',
      category: 'bracelet',
    ),
    ChatbotProduct(
      name: 'Adjustable Bracelet',
      price: 499,
      imagePath: 'assets/images/img6.jpg',
      category: 'bracelet',
    ),
    ChatbotProduct(
      name: 'Silver Ring',
      price: 999,
      imagePath: 'assets/images/img7.jpg',
      category: 'ring',
    ),
    ChatbotProduct(
      name: 'Panchadhatu Ring',
      price: 1099,
      imagePath: 'assets/images/img8.jpg',
      category: 'ring',
    ),
    ChatbotProduct(
      name: 'Adjustable Silver Ring',
      price: 999,
      imagePath: 'assets/images/img9.jpg',
      category: 'ring',
    ),
    ChatbotProduct(
      name: 'Pearl Bracelet',
      price: 599,
      imagePath: 'assets/images/img10.jpg',
      category: 'bracelet',
    ),
    ChatbotProduct(
      name: 'Pearl Neck Piece',
      price: 649,
      imagePath: 'assets/images/img2.jpg',
      category: 'necklace',
    ),
    ChatbotProduct(
      name: 'Gemstone Anklet',
      price: 1199,
      imagePath: 'assets/images/img12.jpg',
      category: 'anklet',
    ),
    ChatbotProduct(
      name: 'Laliguras Necklace Set',
      price: 3099,
      imagePath: 'assets/images/img13.jpg',
      category: 'necklace',
    ),
    ChatbotProduct(
      name: 'Silver NecklaceSet',
      price: 2099,
      imagePath: 'assets/images/img14.jpg',
      category: 'necklace',
    ),
    ChatbotProduct(
      name: 'Flower Necklace Set',
      price: 1099,
      imagePath: 'assets/images/img15.jpg',
      category: 'necklace',
    ),
    ChatbotProduct(
      name: 'Flower earring',
      price: 499,
      imagePath: 'assets/images/img17.jpg',
      category: 'earring',
    ),
    ChatbotProduct(
      name: 'Artisan earring',
      price: 899,
      imagePath: 'assets/images/img16.jpg',
      category: 'earring',
    ),
    ChatbotProduct(
      name: 'Dropdown Earring',
      price: 799,
      imagePath: 'assets/images/img18.jpg',
      category: 'earring',
    ),
  ];

  /// Category display names
  static const Map<String, String> _categoryLabels = {
    'necklace': 'Necklaces',
    'bracelet': 'Bracelets',
    'earring': 'Earrings',
    'ring': 'Rings',
    'anklet': 'Anklets',
  };

  // ── Quick Suggestion Chips ──
  static const List<String> quickSuggestions = [
    'Show me handmade earrings',
    'What gift is suitable for a birthday?',
    'Which jewellery matches a black dress?',
    "What's under ₹600?",
    'Show me necklaces',
    'Show me bracelets',
    'Best rings under ₹1000',
    'Gift for anniversary',
  ];

  /// Main entry: process a user message and return a response
  static ChatbotResponse getResponse(String message) {
    final query = message.toLowerCase().trim();

    // 1. Greeting
    if (_isGreeting(query)) {
      return ChatbotResponse(
        message:
            '👋 Hi there! Welcome to Handmade Crafts.\n\n'
            'I can help you find the perfect jewellery. Try asking:\n'
            '• "Show me earrings"\n'
            '• "What\'s under ₹600?"\n'
            '• "Gift for birthday"\n'
            '• "Matches a black dress"',
      );
    }

    // 2. Price-based queries
    if (_hasPriceQuery(query)) {
      return _handlePriceQuery(query);
    }

    // 3. Category-based queries
    if (_hasCategoryQuery(query)) {
      return _handleCategoryQuery(query);
    }

    // 4. Occasion / Gift queries
    if (_isOccasionQuery(query)) {
      return _handleOccasionQuery(query);
    }

    // 5. Outfit / Color matching queries
    if (_isOutfitQuery(query)) {
      return _handleOutfitQuery(query);
    }

    // 6. General info queries
    if (_isGeneralQuery(query)) {
      return _handleGeneralQuery(query);
    }

    // 7. Fallback
    return ChatbotResponse(
      message:
          '🤔 I\'m not sure I understand. Try these examples:\n\n'
          '• "Show me handmade earrings"\n'
          '• "What\'s under ₹600?"\n'
          '• "What gift is suitable for a birthday?"\n'
          '• "Which jewellery matches a black dress?"\n'
          '• "Show me all rings"',
    );
  }

  // ── Intent Detection Helpers ──

  static bool _isGreeting(String q) {
    final greetings = [
      'hi',
      'hello',
      'hey',
      'namaste',
      'hii',
      'heyy',
      'good morning',
      'good evening',
    ];
    return greetings.any((g) => q.contains(g));
  }

  static bool _hasPriceQuery(String q) {
    return q.contains(
      RegExp(
        r'under\s*₹?|below\s*₹?|less than\s*₹?|upto\s*₹?|up to\s*₹?|\brs\b|\b₹\d+|price\s*range|budget|affordable|cheap|cost',
      ),
    );
  }

  static bool _hasCategoryQuery(String q) {
    final categories = [
      'earring',
      'earrings',
      'necklace',
      'necklaces',
      'bracelet',
      'bracelets',
      'ring',
      'rings',
      'anklet',
      'anklets',
      'pendant',
      'pendants',
      'chain',
      'chains',
      'set',
      'sets',
      'bangle',
      'bangles',
    ];
    return categories.any((c) => q.contains(c));
  }

  static bool _isOccasionQuery(String q) {
    final occasions = [
      'gift',
      'birthday',
      'anniversary',
      'wedding',
      'party',
      'festival',
      'diwali',
      'engagement',
      'reception',
      'valentine',
      'mother\'s day',
      'father\'s day',
      'graduation',
      'present',
      'occasion',
      'celebration',
      'festive',
      'marriage',
      'bridal',
      'blushing bride',
      'event',
    ];
    return occasions.any((o) => q.contains(o));
  }

  static bool _isOutfitQuery(String q) {
    final outfits = [
      'dress',
      'outfit',
      'wear',
      'saree',
      'sari',
      'salwar',
      'lehenga',
      'gown',
      'black dress',
      'red dress',
      'white dress',
      'blue dress',
      'green dress',
      'ethnic',
      'western',
      'formal',
      'casual',
      'traditional',
      'match',
      'matching',
      'goes with',
      'look good with',
      'complement',
      'colour',
      'color',
    ];
    return outfits.any((o) => q.contains(o));
  }

  static bool _isGeneralQuery(String q) {
    final general = [
      'help',
      'what can you do',
      'how',
      'info',
      'information',
      'about',
      'suggest',
      'recommend',
      'show',
      'display',
      'list',
      'all',
      'available',
      'products',
      'items',
      'collection',
      'catalog',
      'catalogue',
      'types',
      'variety',
      'range',
      'offer',
      'sell',
      'buy',
      'shop',
    ];
    return general.any((g) => q.contains(g));
  }

  // ── Price Extraction ──

  static double? _extractMaxPrice(String q) {
    // Look for patterns like "under 600", "under ₹600", "below 1000", "rs 600", "₹500"
    final patterns = [
      RegExp(r'under\s*₹?\s*(\d+)'),
      RegExp(r'below\s*₹?\s*(\d+)'),
      RegExp(r'less than\s*₹?\s*(\d+)'),
      RegExp(r'upto\s*₹?\s*(\d+)'),
      RegExp(r'up to\s*₹?\s*(\d+)'),
      RegExp(r'\brs\s*(\d+)'),
      RegExp(r'₹\s*(\d+)'),
      RegExp(r'under\s+(\d+)'),
      RegExp(r'within\s+(\d+)'),
      RegExp(r'budget\s*(?:of\s*)?₹?\s*(\d+)'),
    ];
    for (final pattern in patterns) {
      final match = pattern.firstMatch(q);
      if (match != null) {
        return double.tryParse(match.group(1)!);
      }
    }
    return null;
  }

  static double? _extractMinPrice(String q) {
    final patterns = [
      RegExp(r'above\s*₹?\s*(\d+)'),
      RegExp(r'over\s*₹?\s*(\d+)'),
      RegExp(r'more than\s*₹?\s*(\d+)'),
      RegExp(r'from\s*₹?\s*(\d+)'),
    ];
    for (final pattern in patterns) {
      final match = pattern.firstMatch(q);
      if (match != null) {
        return double.tryParse(match.group(1)!);
      }
    }
    return null;
  }

  // ── Category Extraction ──

  static String? _extractCategory(String q) {
    if (q.contains(RegExp(r'\bearrings?\b'))) return 'earring';
    if (q.contains(RegExp(r'\bnecklaces?\b'))) return 'necklace';
    if (q.contains(RegExp(r'\bbr?acelets?\b'))) return 'bracelet';
    if (q.contains(RegExp(r'\brings?\b'))) return 'ring';
    if (q.contains(RegExp(r'\banklets?\b'))) return 'anklet';
    if (q.contains(RegExp(r'\bp(?:en|e)n?dants?\b'))) return 'pendant';
    return null;
  }

  // ── Response Handlers ──

  static ChatbotResponse _handlePriceQuery(String q) {
    final maxPrice = _extractMaxPrice(q);
    final category = _extractCategory(q);
    final minPrice = _extractMinPrice(q);

    List<ChatbotProduct> matches = _catalog;

    // Filter by category if specified
    if (category != null) {
      matches = matches.where((p) => p.category == category).toList();
    }

    // Filter by price range
    if (minPrice != null && maxPrice != null) {
      matches = matches
          .where((p) => p.price >= minPrice && p.price <= maxPrice)
          .toList();
    } else if (maxPrice != null) {
      matches = matches.where((p) => p.price <= maxPrice).toList();
    } else if (minPrice != null) {
      matches = matches.where((p) => p.price >= minPrice).toList();
    }

    if (matches.isEmpty) {
      final catLabel = category != null
          ? ' ${_categoryLabels[category] ?? category}'
          : '';
      return ChatbotResponse(
        message:
            '😕 Sorry, I couldn\'t find any$catLabel items in that price range. '
            'Try adjusting your budget or browsing a different category!',
      );
    }

    // Build response message
    final catText = category != null
        ? ' ${_categoryLabels[category] ?? category}'
        : '';
    String priceText;
    if (minPrice != null && maxPrice != null) {
      priceText = 'between ₹${minPrice.toInt()} and ₹${maxPrice.toInt()}';
    } else if (maxPrice != null) {
      priceText = 'under ₹${maxPrice.toInt()}';
    } else if (minPrice != null) {
      priceText = 'over ₹${minPrice.toInt()}';
    } else {
      priceText = 'in your budget';
    }

    final response =
        'Here are$catText items $priceText:\n\n'
        '${matches.take(4).map((p) => '• ${p.name} — ₹${p.price.toInt()}').join('\n')}'
        '${matches.length > 4 ? '\n\n• And ${matches.length - 4} more...' : ''}\n\n'
        'Tap "View Product" below to check details!';

    return ChatbotResponse(message: response, products: matches);
  }

  static ChatbotResponse _handleCategoryQuery(String q) {
    final category = _extractCategory(q);
    if (category == null) {
      return ChatbotResponse(
        message:
            'Here\'s what we offer:\n\n'
            '• 💍 **Rings** — Silver, Panchadhatu & more (₹999+)\n'
            '• 📿 **Necklaces** — Pearl, Flower, Silver sets (₹649+)\n'
            '• 💎 **Earrings** — Flower, Artisan, Dropdown (₹499+)\n'
            '• 📿 **Bracelets** — Pearl, Adjustable (₹499+)\n'
            '• 🦶 **Anklets** — Gemstone (₹1199)\n\n'
            'Which category are you interested in?',
      );
    }

    final matches = _catalog.where((p) => p.category == category).toList();
    final label = _categoryLabels[category] ?? category;

    if (matches.isEmpty) {
      return ChatbotResponse(
        message: '😕 Sorry, I couldn\'t find any $label at the moment.',
      );
    }

    final minPrice = matches
        .map((p) => p.price)
        .reduce((a, b) => a < b ? a : b);
    final maxPrice = matches
        .map((p) => p.price)
        .reduce((a, b) => a > b ? a : b);

    final response =
        '✨ Here are our $label:\n\n'
        '${matches.take(6).map((p) => '• ${p.name} — ₹${p.price.toInt()}').join('\n')}'
        '${matches.length > 6 ? '\n\n• And ${matches.length - 6} more...' : ''}\n\n'
        '💵 Price range: ₹${minPrice.toInt()} – ₹${maxPrice.toInt()}\n\n'
        'Tap "View Product" below to see details!';

    return ChatbotResponse(message: response, products: matches);
  }

  static ChatbotResponse _handleOccasionQuery(String q) {
    // Map occasions to product recommendations
    if (q.contains('birthday')) {
      return _recommendForBirthday(q);
    }
    if (q.contains('anniversary') || q.contains('valentine')) {
      return _recommendForAnniversary(q);
    }
    if (q.contains('wedding') ||
        q.contains('bridal') ||
        q.contains('marriage') ||
        q.contains('engagement')) {
      return _recommendForWedding(q);
    }
    if (q.contains('diwali') ||
        q.contains('festival') ||
        q.contains('festive')) {
      return _recommendForFestival(q);
    }
    if (q.contains('party') ||
        q.contains('event') ||
        q.contains('celebration')) {
      return _recommendForParty(q);
    }
    if (q.contains('mother')) {
      return _recommendForMother(q);
    }
    if (q.contains('graduation')) {
      return _recommendForGraduation(q);
    }

    // General gift recommendation
    return _generalGiftRecommendation();
  }

  static ChatbotResponse _recommendForBirthday(String q) {
    // Check if there's a gender hint or budget
    final isForHim =
        q.contains('him') ||
        q.contains('boy') ||
        q.contains('man') ||
        q.contains('brother') ||
        q.contains('husband') ||
        q.contains('father');
    final maxPrice = _extractMaxPrice(q);

    List<ChatbotProduct> products;
    String advice;

    if (isForHim) {
      // Rings are good for men
      products = _catalog.where((p) => p.category == 'ring').toList();
      advice =
          '🎂 **Birthday Gift for Him** 🎂\n\n'
          'Rings make a great birthday gift! Here are some options:';
    } else {
      // Default / for her: earrings, bracelets, necklaces
      products = _catalog
          .where(
            (p) =>
                p.category == 'earring' ||
                p.category == 'bracelet' ||
                p.category == 'necklace',
          )
          .toList();
      advice =
          '🎂 **Birthday Gift Ideas** 🎂\n\n'
          'Here are some lovely jewellery pieces perfect for a birthday:';
    }

    if (maxPrice != null) {
      products = products.where((p) => p.price <= maxPrice).toList();
      advice += '\n\n✅ All items under ₹${maxPrice.toInt()}:';
    }

    if (products.isEmpty) {
      return ChatbotResponse(
        message:
            '😕 Sorry, no birthday gift options match your criteria. Try a different budget!',
      );
    }

    return ChatbotResponse(
      message:
          '$advice\n\n'
          '${products.take(4).map((p) => '• ${p.name} — ₹${p.price.toInt()}').join('\n')}'
          '${products.length > 4 ? '\n\n• And ${products.length - 4} more...' : ''}',
      products: products,
    );
  }

  static ChatbotResponse _recommendForAnniversary(String q) {
    final maxPrice = _extractMaxPrice(q);
    // Premium picks for anniversary: necklace sets and rings
    var products = _catalog
        .where((p) => p.category == 'necklace' || p.category == 'ring')
        .toList();

    if (maxPrice != null) {
      products = products.where((p) => p.price <= maxPrice).toList();
    }

    if (products.isEmpty) {
      return ChatbotResponse(
        message:
            '😕 No anniversary-appropriate items found in that range. Try increasing your budget for a truly special gift!',
      );
    }

    final response =
        '💕 **Anniversary Gift Ideas** 💕\n\n'
        'Celebrate love with timeless jewellery:\n\n'
        '${products.take(4).map((p) => '• ${p.name} — ₹${p.price.toInt()}').join('\n')}'
        '${products.length > 4 ? '\n\n• And ${products.length - 4} more...' : ''}\n\n'
        'These make perfect anniversary gifts that she\'ll cherish!';

    return ChatbotResponse(message: response, products: products);
  }

  static ChatbotResponse _recommendForWedding(String q) {
    // Wedding: necklace sets, earrings, bridal pieces
    final maxPrice = _extractMaxPrice(q);
    var products = _catalog
        .where((p) => p.category == 'necklace' || p.category == 'earring')
        .toList();

    if (maxPrice != null) {
      products = products.where((p) => p.price <= maxPrice).toList();
    }

    if (products.isEmpty) {
      return ChatbotResponse(
        message:
            '😕 No wedding-appropriate items found in that range. Traditional necklace sets are popular choices!',
      );
    }

    return ChatbotResponse(
      message:
          '👰 **Wedding & Bridal Jewellery** 👰\n\n'
          'Make her special day even more memorable:\n\n'
          '${products.take(4).map((p) => '• ${p.name} — ₹${p.price.toInt()}').join('\n')}'
          '${products.length > 4 ? '\n\n• And ${products.length - 4} more...' : ''}',
      products: products,
    );
  }

  static ChatbotResponse _recommendForFestival(String q) {
    final maxPrice = _extractMaxPrice(q);
    var products = _catalog
        .where((p) => p.category == 'necklace' || p.category == 'earring')
        .toList();

    if (maxPrice != null) {
      products = products.where((p) => p.price <= maxPrice).toList();
    }

    if (products.isEmpty) {
      return ChatbotResponse(
        message:
            '😕 No festive items found in that range. Check our necklace and earring collections for Diwali specials!',
      );
    }

    return ChatbotResponse(
      message:
          '🪔 **Festive Collection** 🪔\n\n'
          'Light up the celebrations with these beautiful pieces:\n\n'
          '${products.take(4).map((p) => '• ${p.name} — ₹${p.price.toInt()}').join('\n')}'
          '${products.length > 4 ? '\n\n• And ${products.length - 4} more...' : ''}',
      products: products,
    );
  }

  static ChatbotResponse _recommendForParty(String q) {
    final maxPrice = _extractMaxPrice(q);
    var products = _catalog
        .where((p) => p.category == 'earring' || p.category == 'bracelet')
        .toList();

    if (maxPrice != null) {
      products = products.where((p) => p.price <= maxPrice).toList();
    }

    if (products.isEmpty) {
      return ChatbotResponse(
        message:
            '😕 No party-wear items in that range. Try earrings or bracelets for party looks!',
      );
    }

    return ChatbotResponse(
      message:
          '🎉 **Party Wear Picks** 🎉\n\n'
          'Stand out at the party with these:\n\n'
          '${products.take(4).map((p) => '• ${p.name} — ₹${p.price.toInt()}').join('\n')}'
          '${products.length > 4 ? '\n\n• And ${products.length - 4} more...' : ''}',
      products: products,
    );
  }

  static ChatbotResponse _recommendForMother(String q) {
    final maxPrice = _extractMaxPrice(q);
    // For mother: elegant, traditional pieces
    var products = _catalog
        .where((p) => p.category == 'necklace' || p.category == 'bracelet')
        .toList();

    if (maxPrice != null) {
      products = products.where((p) => p.price <= maxPrice).toList();
    }

    if (products.isEmpty) {
      return ChatbotResponse(
        message:
            '😕 No items found in that range. Check our necklace and bracelet collections for a thoughtful gift!',
      );
    }

    return ChatbotResponse(
      message:
          '🌷 **Gift for Mother** 🌷\n\n'
          'Show your love with these elegant pieces:\n\n'
          '${products.take(4).map((p) => '• ${p.name} — ₹${p.price.toInt()}').join('\n')}'
          '${products.length > 4 ? '\n\n• And ${products.length - 4} more...' : ''}',
      products: products,
    );
  }

  static ChatbotResponse _recommendForGraduation(String q) {
    final maxPrice = _extractMaxPrice(q);
    var products = _catalog.where((p) => p.price <= 1000).toList();

    if (maxPrice != null) {
      products = products.where((p) => p.price <= maxPrice).toList();
    }

    return ChatbotResponse(
      message:
          '🎓 **Graduation Gift Ideas** 🎓\n\n'
          'Celebrate their achievement with a meaningful piece:\n\n'
          '${products.take(4).map((p) => '• ${p.name} — ₹${p.price.toInt()}').join('\n')}'
          '${products.length > 4 ? '\n\n• And ${products.length - 4} more...' : ''}',
      products: products,
    );
  }

  static ChatbotResponse _generalGiftRecommendation() {
    // Recommend a mix of popular items
    final products = _catalog.take(6).toList();
    return ChatbotResponse(
      message:
          '🎁 **Gift Recommendations** 🎁\n\n'
          'Looking for a gift? Here are some popular choices:\n\n'
          '${products.map((p) => '• ${p.name} — ₹${p.price.toInt()}').join('\n')}\n\n'
          '💡 **Pro tips:**\n'
          '• For **birthdays** → Earrings or Bracelets\n'
          '• For **anniversaries** → Necklace Sets\n'
          '• For **festivals** → Traditional Necklaces\n'
          '• For **weddings** → Bridal Sets\n\n'
          'What\'s the occasion? I can help find the perfect match!',
      products: products,
    );
  }

  // ── Outfit Matching ──

  static ChatbotResponse _handleOutfitQuery(String q) {
    // Detect outfit color/type
    final isBlack = q.contains('black') || q.contains('dark');
    final isWhite = q.contains('white') || q.contains('cream');
    final isRed =
        q.contains('red') || q.contains('maroon') || q.contains('scarlet');
    final isBlue = q.contains('blue') || q.contains('navy');
    final isGreen = q.contains('green') || q.contains('emerald');
    final isPink =
        q.contains('pink') || q.contains('rose') || q.contains('magenta');
    final isEthnic =
        q.contains('saree') ||
        q.contains('sari') ||
        q.contains('salwar') ||
        q.contains('lehenga') ||
        q.contains('ethnic');

    List<ChatbotProduct> products;
    String advice;

    // ── Black dress (most common query) ──
    if (isBlack) {
      if (isEthnic) {
        products = _catalog
            .where((p) => p.category == 'necklace' || p.category == 'earring')
            .toList();
        advice =
            '🖤 **With a Black Saree/Ethnic Wear** 🖤\n\n'
            'Black is a blank canvas! Here\'s what works beautifully:\n\n'
            '💎 **Recommended:** Silver or Pearl jewellery creates stunning contrast.\n'
            '✨ Gold-toned pieces add warmth and elegance.';
      } else {
        products = _catalog
            .where(
              (p) =>
                  p.category == 'necklace' ||
                  p.category == 'earring' ||
                  p.category == 'bracelet',
            )
            .toList();
        advice =
            '🖤 **Black Dress — Perfect Matches** 🖤\n\n'
            'Black goes with everything! Here are top picks:\n\n'
            '💎 **Silver/Pearl** → Elegant & modern contrast\n'
            '✨ **Gold-toned** → Warm & glamorous\n'
            '🌸 **Colourful gemstones** → Fun pop of colour';
      }
    } else if (isWhite) {
      products = _catalog
          .where(
            (p) =>
                p.category == 'necklace' ||
                p.category == 'earring' ||
                p.category == 'bracelet',
          )
          .toList();
      advice =
          '🤍 **White Outfit — Pair With** 🤍\n\n'
          'White looks stunning with:\n\n'
          '✨ **Gold jewellery** → Classic & rich\n'
          '🌸 **Rose gold/Pearl** → Soft & romantic\n'
          '💎 **Colourful gemstones** → Bold statement';
    } else if (isRed) {
      products = _catalog
          .where((p) => p.category == 'earring' || p.category == 'bracelet')
          .toList();
      advice =
          '❤️ **Red Outfit — Best Choices** ❤️\n\n'
          'Red is bold! Complement it with:\n\n'
          '✨ **Gold jewellery** → Traditional & regal\n'
          '💎 **Pearl/Silver** → Elegant contrast\n'
          'Avoid over-matching — let the red shine!';
    } else if (isBlue) {
      products = _catalog
          .where((p) => p.category == 'necklace' || p.category == 'earring')
          .toList();
      advice =
          '💙 **Blue Outfit — Stunning Combinations** 💙\n\n'
          'Blue loves:\n\n'
          '✨ **Gold/Silver** → Both work beautifully\n'
          '💎 **Pearl white** → Fresh & classy\n'
          '🌸 **Rose gold** → Trendy modern look';
    } else if (isGreen) {
      products = _catalog
          .where((p) => p.category == 'necklace' || p.category == 'earring')
          .toList();
      advice =
          '💚 **Green Outfit — Perfect Pairings** 💚\n\n'
          'Green looks amazing with:\n\n'
          '✨ **Gold jewellery** → Rich, earthy elegance\n'
          '💎 **Pearl** → Sophisticated & fresh\n'
          '🌸 **Rose gold** → Modern & chic';
    } else if (isPink) {
      products = _catalog
          .where((p) => p.category == 'earring' || p.category == 'bracelet')
          .toList();
      advice =
          '💗 **Pink Outfit — Style Tips** 💗\n\n'
          'Pink is playful! Pair with:\n\n'
          '✨ **Silver/White gold** → Modern & fresh\n'
          '💎 **Rose gold** → Monochromatic chic\n'
          '🌸 **Pearl** → Soft & romantic';
    } else if (isEthnic) {
      products = _catalog
          .where((p) => p.category == 'necklace' || p.category == 'earring')
          .toList();
      advice =
          '🥻 **Ethnic Wear — Jewellery Guide** 🥻\n\n'
          'Complete your traditional look:\n\n'
          '📿 **Necklace sets** — The centrepiece of ethnic wear\n'
          '💎 **Earrings** — Essential for every outfit\n'
          '✨ **Gold/Silver** — Both complement Indian wear';
    } else {
      // General outfit advice
      products = _catalog.take(6).toList();
      advice =
          '👗 **Outfit Matching Guide** 👗\n\n'
          'Here are some general tips:\n\n'
          '🖤 **Black dress** → Silver or Pearl\n'
          '🤍 **White outfit** → Gold or colourful gemstones\n'
          '❤️ **Red saree** → Gold jewellery\n'
          '💙 **Blue gown** → Silver or Pearl\n\n'
          '**What colour is your outfit?** I\'ll give you specific recommendations!';
    }

    return ChatbotResponse(message: advice, products: products);
  }

  static ChatbotResponse _handleGeneralQuery(String q) {
    if (q.contains('all') ||
        q.contains('show') ||
        q.contains('list') ||
        q.contains('available') ||
        q.contains('products') ||
        q.contains('items')) {
      // Show all products grouped by category
      final byCategory = <String, List<ChatbotProduct>>{};
      for (final p in _catalog) {
        byCategory.putIfAbsent(p.category, () => []).add(p);
      }

      final response =
          '📋 **Our Complete Collection** 📋\n\n'
          '${byCategory.entries.map((entry) {
            final label = _categoryLabels[entry.key] ?? entry.key;
            final items = entry.value.map((p) => '  • ${p.name} — ₹${p.price.toInt()}').join('\n');
            return '✨ **$label**\n$items';
          }).join('\n\n')}\n\n'
          '💵 **Price range:** ₹${_catalog.map((p) => p.price).reduce((a, b) => a < b ? a : b).toInt()} – ₹${_catalog.map((p) => p.price).reduce((a, b) => a > b ? a : b).toInt()}\n\n'
          'Which category interests you?';

      return ChatbotResponse(message: response, products: _catalog);
    }

    if (q.contains('help') || q.contains('what can you do')) {
      return ChatbotResponse(
        message:
            '🤖 **Hi! I\'m your Handmade Crafts Assistant**\n\n'
            'Here\'s what I can help with:\n\n'
            '🔍 **Browse products** — "Show me earrings"\n'
            '💰 **Price check** — "Under ₹600"\n'
            '🎁 **Gift ideas** — "Birthday gift"\n'
            '👗 **Outfit matching** — "Matches a black dress"\n'
            '📋 **Full catalog** — "Show all"\n\n'
            'Just type your question! 😊',
      );
    }

    // Fallback: show some popular items
    return ChatbotResponse(
      message:
          '🛍️ **Here\'s what\'s popular right now:**\n\n'
          '${_catalog.take(4).map((p) => '• ${p.name} — ₹${p.price.toInt()}').join('\n')}\n\n'
          'Want to explore more? Try:\n'
          '• "Show me all necklaces"\n'
          '• "What\'s under ₹600?"\n'
          '• "Gift for birthday"\n'
          '• "Matches a black dress"',
      products: _catalog.take(4).toList(),
    );
  }
}
