#!/bin/sh

pushd $(dirname $0) >/dev/null

echo ">>> Generating the fonts.plist list…"
swiftgen fonts -p "fonts-plist.stencil" -o "fonts.plist" "../Fonts"

echo ">>> Merging it with the Info.plist file…"
/usr/libexec/PlistBuddy -c "Delete UIAppFonts" -c "Add UIAppFonts array" -c "Merge fonts.plist UIAppFonts" "../Info.plist"

popd >/dev/null