// Week3.dart - Library Desk Assistant
// Name: Fahim Azam   REg no: 04072312039

final List<Map<String, dynamic>> books = [
  {
    'title': 'Dart in Action',
    'author': 'Ahsan',
    'year': 2021,
    'copies': 3,
    'tags': ['dart', 'programming'],
  },
  {
    'title': 'Flutter Basics',
    'author': 'Ali',
    'year': 2023,
    'copies': 0,
    'tags': ['flutter', 'mobile'],
  },
  {
    'title': 'Clean Code',
    'author': 'Salman',
    'year': 2008,
    'copies': 2,
    'tags': ['programming', 'design'],
  },
  {
    'title': 'Algorithms',
    'author': 'Azam',
    'year': 1968,
    'copies': 1,
    'tags': ['programming', 'math'],
  },
  {
    'title': 'UI Design',
    'author': 'Aftab',
    'year': 2019,
    'copies': 4,
    'tags': ['design', 'mobile'],
  },
];

// ---------------------------------------------------------------------------
// Part 1: Functions & Parameters
// ---------------------------------------------------------------------------

double lateFee(int daysLate, double ratePerDay) => daysLate * ratePerDay;

String formatTitle(String title, [String? author]) {
  if (author == null) return title;
  return '$title by $author';
}

Map<String, dynamic> makeBook({
  required String title,
  required String author,
  int year = 2024,
  int copies = 1,
}) {
  return {'title': title, 'author': author, 'year': year, 'copies': copies};
}

bool isClassic(int year) => year < 2000;

// ---------------------------------------------------------------------------
// Part 2: Closures, Higher-Order Functions & Recursion
// ---------------------------------------------------------------------------

List<String> transformAll(List<String> items, String Function(String) fn) {
  return items.map(fn).toList();
}

int Function() makeCounter() {
  int count = 0;
  return () {
    count++;
    return count;
  };
}

double Function(int) makeFeeCalculator(double rate) {
  return (int days) => days * rate;
}

int sumDigits(int n) {
  if (n < 10) return n; // base case
  return (n % 10) + sumDigits(n ~/ 10);
}

// ---------------------------------------------------------------------------
// Part 3: Collections
// ---------------------------------------------------------------------------

Map<String, int> buildStock() {
  return {for (final b in books) (b['title'] as String): (b['copies'] as int)};
}

// ---------------------------------------------------------------------------
// Part 4: Generics
// ---------------------------------------------------------------------------

class Box<T> {
  T value;
  Box(this.value);
}

T firstOr<T>(List<T> items, T fallback) {
  return items.isEmpty ? fallback : items.first;
}

class Pair<A, B> {
  final A first;
  final B second;
  Pair(this.first, this.second);

  @override
  String toString() => '($first, $second)';
}

// ---------------------------------------------------------------------------
// Part 5: Error handling
// ---------------------------------------------------------------------------

class BookNotFoundException implements Exception {
  final String title;
  BookNotFoundException(this.title);
}

class BookNotAvailableException implements Exception {
  final String title;
  BookNotAvailableException(this.title);
}

void checkOut(Map<String, int> stock, String title) {
  if (!stock.containsKey(title)) {
    throw BookNotFoundException(title);
  }
  if (stock[title]! <= 0) {
    // key is proven to exist above, so ! is safe here
    throw BookNotAvailableException(title);
  }
  stock[title] = stock[title]! - 1;
}

Map<String, dynamic> findBook(String title) {
  return books.firstWhere((b) => b['title'] == title); // throws StateError
}

// ---------------------------------------------------------------------------
// Part 6: Future & async/await
// ---------------------------------------------------------------------------

Future<String> fetchBookOfTheDay() async {
  await Future.delayed(Duration(seconds: 1));
  return 'Dart in Action';
}

Future<String> fetchBroken() async {
  await Future.delayed(Duration(milliseconds: 500));
  throw Exception('Server down');
}

// ---------------------------------------------------------------------------
// Bonus
// ---------------------------------------------------------------------------

// B1: group titles by tag
Map<String, List<String>> groupByTag() {
  final result = <String, List<String>>{};
  for (final b in books) {
    for (final tag in b['tags'] as List<String>) {
      result.putIfAbsent(tag, () => []).add(b['title'] as String);
    }
  }
  return result;
}

// B2: generic filter
List<T> filterBy<T>(List<T> items, bool Function(T) test) {
  final out = <T>[];
  for (final item in items) {
    if (test(item)) out.add(item);
  }
  return out;
}

void main() async {
  part1();
  part2();
  part3();
  part4();
  part5();
  await part6();
  await bonus();
}

void part1() {
  print('--- Part 1 ---');
  print('Late fee: ${lateFee(5, 0.5)}');
  print(formatTitle('Dart in Action'));
  print(formatTitle('Dart in Action', 'Ada'));
  print(makeBook(title: 'Clean Code', author: 'Martin'));
  print(makeBook(title: 'Algorithms', author: 'Knuth', year: 1968));
  print(isClassic(1968));
  print(isClassic(2021));
}

void part2() {
  print('--- Part 2 ---');
  final names = ['Dart in Action', 'Clean Code'];

  // anonymous function
  print(
    transformAll(names, (String s) {
      return s.toUpperCase();
    }),
  );
  // arrow function
  print(transformAll(names, (s) => '$s!'));

  final desk1 = makeCounter();
  final desk2 = makeCounter();
  print(desk1());
  print(desk1());
  print(desk1());
  print(desk2());

  final studentFee = makeFeeCalculator(0.25);
  final staffFee = makeFeeCalculator(0.10);
  print('Student fee: ${studentFee(4)}');
  print('Staff fee: ${staffFee(4)}');

  print('Sum of digits: ${sumDigits(2024)}');
}

void part3() {
  print('--- Part 3 ---');

  // 3.1 map and where
  final titles = books.map((b) => b['title'] as String).toList();
  print('Titles: $titles');
  final available = books
      .where((b) => (b['copies'] as int) > 0)
      .map((b) => b['title'] as String)
      .toList();
  print('Available: $available');

  // 3.2 fold and reduce
  final totalCopies = books.fold(0, (sum, b) => sum + (b['copies'] as int));
  print('Total copies: $totalCopies');
  final years = books.map((b) => b['year'] as int).toList();
  final oldest = years.reduce((x, y) => x < y ? x : y);
  print('Oldest year: $oldest');

  // 3.3 sort a copy, original stays untouched
  final sorted = List.of(books);
  sorted.sort((x, y) => (x['year'] as int).compareTo(y['year'] as int));
  print('By year: ${sorted.map((b) => b['title']).toList()}');

  // 3.4 Map
  final stock = buildStock();
  print('Stock: $stock');
  stock.forEach((title, copies) {
    if (copies == 0) print('Out of stock: $title');
  });
  print('Copies of Unknown: ${stock['Unknown'] ?? 0}');

  // 3.5 Set
  final Set<String> allTags = {
    for (final b in books) ...(b['tags'] as List<String>),
  };
  print('All tags: $allTags');

  var a = {'Dart in Action', 'Clean Code', 'Flutter Basics'};
  var b = {'Clean Code', 'Flutter Basics', 'Algorithms'};
  print('Union: ${a.union(b)}');
  print('Common: ${a.intersection(b)}');
  print('Only in A: ${a.difference(b)}');
}

void part4() {
  print('--- Part 4 ---');
  final intBox = Box<int>(5);
  final strBox = Box<String>('dart');
  print('Box<int>: ${intBox.value}');
  print('Box<String>: ${strBox.value}');
  // intBox.value = 'hello'; // compile error: String can't be assigned to int

  print(firstOr(['Dart in Action', 'Clean Code'], 'none'));
  print(firstOr<String>([], 'z'));
  print(Pair('Dart in Action', 3));
}

void part5() {
  print('--- Part 5 ---');
  var stock = buildStock();

  for (final title in ['Dart in Action', 'Flutter Basics', 'Unknown Book']) {
    try {
      checkOut(stock, title);
      print('Checked out: $title');
    } on BookNotAvailableException catch (e) {
      print('Sorry: "${e.title}" has no copies left');
    } on BookNotFoundException catch (e) {
      print('Not found: "${e.title}"');
    } finally {
      print('Transaction logged.');
    }
  }
  print('Copies left of Dart in Action: ${stock['Dart in Action']}');

  try {
    findBook('Missing');
  } on StateError {
    print('Search failed: no such book');
  }
}

Future<void> part6() async {
  print('--- Part 6 ---');
  print('Fetching...');
  final book = await fetchBookOfTheDay();
  print('Book of the day: $book');

  // Task 6.2 (without await it prints "Instance of '_Future<String>'"):
  // print(fetchBookOfTheDay());

  try {
    await fetchBroken();
  } catch (e) {
    print('Fetch failed: $e');
  }
}

// Bonus challenges (printed after Part 6; remove the call in main() if you
// want the console output to match the Expected output exactly).
Future<void> bonus() async {
  print('--- Bonus ---');
  print('B1: ${groupByTag()}');

  final availableTitles = filterBy<Map<String, dynamic>>(
    books,
    (b) => (b['copies'] as int) > 0,
  ).map((b) => b['title']).toList();
  print('B2: $availableTitles');

  final watch = Stopwatch()..start();
  final results = await Future.wait([fetchBookOfTheDay(), fetchBookOfTheDay()]);
  watch.stop();
  print('B3: $results in about ${(watch.elapsedMilliseconds / 1000).round()}s');
}
