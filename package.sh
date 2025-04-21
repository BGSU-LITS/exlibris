#!/usr/bin/env bash

# Define complete Primo VE codename from institution and view codes.
CODE=${INST:-01OHIOLINK_BGSU}-${VIEW:-BGSU}

# Move to CSS directory to control paths in sourcemap.
cd primo/$CODE/css

# Combine and compress CSS files into a single file with source map.
npx cleancss --source-map -o custom1.css src/custom1.css

# Rename source map with extension allowed by Primo VE and update reference.
mv custom1.css.map custom1.map.css
sed -i -e 's/custom1.css.map/custom1.map.css/g' custom1.css

# Move to primo directory to properly structure zip file.
cd ../..

# Create zip file and place in public primo folder.
npx bestzip ../public/primo/$CODE.zip $CODE
