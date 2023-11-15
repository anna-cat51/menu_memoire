const colors = require("tailwindcss/colors");

module.exports = {
  content: [
    "../myapp/app/views/**/*.html.erb",
    "../myapp/app/helpers/**/*.rb",
    "../myapp/app/assets/stylesheets/**/*.css",
    "../myapp/app/javascript/**/*.js",
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
    },
  },
};
