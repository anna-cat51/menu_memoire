module.exports = {
  content: [
    '../myapp/app/views/**/*.html.erb',
    '../myapp/app/helpers/**/*.rb',
    '../myapp/app/assets/stylesheets/**/*.css',
    '../myapp/app/javascript/**/*.js'
  ],
  plugins: [require('daisyui')],
}