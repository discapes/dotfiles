#include <CoreGraphics/CoreGraphics.h>
#include <codecvt>
#include <thread>

// further reading:
// https://github.com/pqrs-org/Karabiner-archived/issues/91
// https://apple.stackexchange.com/questions/288536/is-it-possible-to-keystroke-special-characters-in-applescript/289046#289046

/* clang-format off
/usr/bin/clang++ -framework ApplicationServices -o executable_typechar typechar.cpp && c apply ~/.local/bin/typechar
*/
int main(int argc, const char *argv[]) {
  std::wstring_convert<std::codecvt_utf8_utf16<char16_t>, char16_t> convert;
  std::u16string utf16 = convert.from_bytes({argv[1][0], argv[1][1]});
  UniChar c = utf16[0];
  auto e = CGEventCreateKeyboardEvent(0, 0, true);
  CGEventKeyboardSetUnicodeString(e, 1, &c);
  CGEventPost(kCGHIDEventTap, e);
  // is it faster with this? or not? don't know.
  // CGEventSetType(e, kCGEventKeyUp);
  // CGEventPost(kCGHIDEventTap, e);
  CFRelease(e);
  std::this_thread::sleep_for(std::chrono::milliseconds(4));
}
