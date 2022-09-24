#!/bin/bash


cat >tailwind.config.js <<EOL 
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./src/**/*.{vue, vuex, html, js}"],
  theme: {
    extend: {},
  },
  plugins: [],
}
EOL


cat >./src/input.css <<EOL 
@tailwind base;
@tailwind components;
@tailwind utilities;
EOL

tailwindcss -i ./src/input.css -o ./dist/output.css

cat >./public/index.html <<EOL
<!DOCTYPE html>
<html lang="">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <link rel="icon" href="<%= BASE_URL %>favicon.ico">
    <title><%= htmlWebpackPlugin.options.title %></title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="/dist/output.css" rel="stylesheet">
  </head>
  <body>
    <noscript>
      <strong>We're sorry but <%= htmlWebpackPlugin.options.title %> doesn't work properly without JavaScript enabled. Please enable it to continue.</strong>
    </noscript>
    <div id="app"></div>
    <!-- built files will be auto injected -->
  </body>
</html>
EOL