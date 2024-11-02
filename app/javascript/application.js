//= require jquery3
//= require popper
//= require bootstrap
//= require rails-ujs
// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// import "@hotwired/turbo-rails"
import "controllers"
import "trix"
import "@rails/actiontext"
import { Turbo } from "@hotwired/turbo-rails"
Turbo.session.drive = true

console.log('Hello World from application.js');

