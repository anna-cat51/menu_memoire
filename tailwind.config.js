const colors = require('tailwindcss/colors');

module.exports = {
  content: [
    "./app/views/**/*.html.erb",
    "./app/helpers/**/*.rb",
    "./app/assets/stylesheets/**/*.css",
    "./app/javascript/**/*.js",
  ],
  plugins: [require("daisyui")],
  theme: {
    colors: {
      transparent: "transparent",
      current: "currentColor",
      black: colors.black,
      white: colors.white,
      indigo: colors.indigo,
      red: colors.rose,
      yellow: colors.amber,
      body: {
        light: "#FFFCF8",
        dark: "#FFF8EF",
        main: "#F39800",
        word: "#333333",
      },
      customOrange: "#F39800", // 押す前の色
      customOrangeHover: "#cc7a00", // カーソルを合わせた後の色（暗めに設定）
    },
    extend: {
      animation: {
        slideRightToLeft: "slideRightToLeft 10s infinite"
      },
      keyframes: {
        "bg-pan-right": {
          "0%": {
              "background-position": "0% 50%"
          },
          to: {
              "background-position": "100% 50%"
          }
        }
      }
    }
  }
}

