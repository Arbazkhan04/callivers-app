String extractNumbers(String input) {
  // Regular expression to find all numbers in the string
  RegExp regExp = RegExp(r'\d+');

  // Find all matches
  Iterable<RegExpMatch> matches = regExp.allMatches(input);

  // Extract the numbers and concatenate them into a single string
  String result = matches.map((match) => match.group(0)).join();

  return result;
}