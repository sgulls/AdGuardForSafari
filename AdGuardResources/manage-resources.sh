#!/bin/bash

# build SafariConverterLib
cd node_modules/safari-converter-lib
swift build
cd ../..

# copy ConverterTool to libs
mkdir -p ../libs
cp node_modules/safari-converter-lib/.build/debug/ConverterTool ../libs
chmod +x ../libs/ConverterTool

touch ../libs/ConverterTool.json

LIB_VERSION=$(curl -L "https://api.github.com/repos/AdguardTeam/SafariConverterLib/releases/latest" |
    grep '"tag_name":' |
    sed -E 's/.*"([^"]+)".*/\1/')

echo "{\"version\": \"$LIB_VERSION\"}" > ../libs/ConverterTool.json

# copy scriptlets.js
cp node_modules/scriptlets/dist/scriptlets.js ../AdGuard/AdvancedBlocking

# copy extended-css.js
cp node_modules/extended-css/dist/extended-css.js ../AdGuard/AdvancedBlocking

# copy assistant.embedded.js
cp node_modules/assistant/dist/assistant.embedded.js ../AdGuard/Extension
