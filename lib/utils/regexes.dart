const numbersExtractRegex = r'\d+';

const numberSanitizeRegex = r'\D';

/// Email Regex - A predefined type for handling email matching
const emailRegex = r'\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b';

/// URL Regex - A predefined type for handling URL matching
///
/// The leading lookbehind is load-bearing, not cosmetic: without it the unbounded host part is
/// re-scanned from every offset inside a long run of word characters, so a message that is one
/// unbroken token (no space, no dot) costs O(n^2) on the UI thread - ~7 s for 19 k characters,
/// which is an ANR on Android and a scene-update watchdog kill on iOS (WT-1812).
/// The {1,63} / {0,62} bounds are the DNS label limit.
const linkRegex =
    r'(?<![\w_-])((http|ftp|https):\/\/)?'
    r'([\w_-]{1,63}(?:(?:\.[\w_-]{0,62}[a-zA-Z_][\w_-]{0,62})+))'
    r'([\w.,@?^=%&:/~+#-]*[\w@?^=%&/~+#-])';
