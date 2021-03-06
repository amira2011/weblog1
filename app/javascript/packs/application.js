// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import "bootstrap"
import "chartkick/chart.js"

import "controllers"
require("sb/bootstrap.bundle.min")
require("sb/sb-admin-2.min")


require("sb/jquery.easing.min")


import flatpickr from "flatpickr";
require("flatpickr/dist/flatpickr.css")


document.addEventListener("turbolinks:load", () =>{
flatpickr("[data-behavior='flatpickr']",{

enableTime: true,
dateFormat: "Y-m-d H:i",

})
});


$(document).ready( function () {
    $('#dataTable').DataTable();
} );
