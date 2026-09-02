const numbersExtractRegex = r'\d+';

const numberSanitizeRegex = r'\D';

/// Email Regex - A predefined type for handling email matching
const emailRegex = r'\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b';

/// URL Regex - A predefined type for handling URL matching
///
/// Matches any host behind an explicit scheme or a `www.` prefix, and a bare host only when it
/// ends in a known top-level domain.
///
/// The TLD list is what keeps ordinary text from being linkified: without it any dotted pair
/// reads as a host, so `string.digits`, `random.choice`, `report.pdf` and - the common one -
/// `here.Then`, a full stop with the space missing after it, all rendered as links (WT-1168).
/// Every entry is a delegated TLD; `[a-z]{2}` covers the ccTLDs, which is why `main.rs` and
/// `user.id` still read as links, the same way they do in other messengers.
///
/// The leading lookbehind is load-bearing, not cosmetic: without it the host part is re-scanned
/// from every offset inside a long run of word characters, so a message that is one unbroken
/// token costs O(n^2) on the UI thread - ~7 s for 19 k characters, which is an ANR on Android
/// and a scene-update watchdog kill on iOS (WT-1812). It also rejects `@`, keeping an email
/// address from being scraped as a link. The {1,63} bound is the DNS label limit.
///
/// The TLD list is lowercase, so every call site must match case-insensitively - `RegexOptions`
/// defaults `caseSensitive` to true, which would otherwise drop `EXAMPLE.COM` on the render path.
const linkRegex =
    r'(?<![\w@-])(?:'
    r'(?:https?|ftp):\/\/[\w_-]{1,63}(?:\.[\w_-]{1,63}){0,10}'
    r'|www\.[\w_-]{1,63}(?:\.[\w_-]{1,63}){0,10}'
    r'|[\w_-]{1,63}(?:\.[\w_-]{1,63}){0,10}\.'
    r'(?:com|org|net|edu|gov|mil|int|info|biz|name|pro|mobi|asia|travel|jobs|aero|coop'
    r'|museum|cat|post|tel|online|site|shop|store|blog|cloud|tech|space|website|xyz|club|live|life'
    r'|world|today|news|media|agency|company|group|team|digital|studio|design|solutions|services'
    r'|support|systems|network|center|zone|host|press|app|dev|page|link|email|date|top|new|wiki'
    r'|art|bar|fun|run|one|ltd|inc|llc|chat|video|games|photo|photos|tools|works|expert|global'
    r'|business|best|guru|cool|buzz|[a-z]{2})\b'
    r')(?:[\w.,@?^=%&:/~+#-]*[\w@?^=%&/~+#-])?';
