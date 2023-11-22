module.exports = {
  content: [
<<<<<<< HEAD
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
      gray: colors.trueGray,
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
  },
};
=======
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ]
}
>>>>>>> 9108fe7 (Revert "Flash massages")
