const emailRegex = r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}';

const linkRegex =
    r'((http|ftp|https):\/\/)?([\w_-]+(?:(?:\.[\w_-]*[a-zA-Z_][\w_-]*)+))([\w.,@?^=%&:/~+#-]*[\w@?^=%&/~+#-])';

const linkWoFilesRegex =
    r'((http|ftp|https):\/\/)?([\w_-]+(?:(?:\.[\w_-]*[a-zA-Z_][\w_-]*)+))([\w.,@?^=%&:/~+#-]*[\w@?^=%&/~+#-])?[^\.\s]';

/// Matches any symbols except letters, digits, spaces, and Cyrillic characters
const symbolsRegex = r'[^a-zA-Z\d\s\u0400-\u04FF]+';

const numbersExtractRegex = r'\d+';

const numberSanitizeRegex = r'\D';
