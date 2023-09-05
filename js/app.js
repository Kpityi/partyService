(function (window, angular) {
  "use strict";

  // Application module
  angular
    .module("app", ["ui.router", "app.common"])

    // Application config
    .config([
      "$stateProvider",
      "$urlRouterProvider",
      function ($stateProvider, $urlRouterProvider) {
        $stateProvider
          .state("home", {
            url: "/",
            templateUrl: "./html/home.html",
            controller: "homeController",
          })
          .state("services", {
            url: "/services",
            templateUrl: "./html/services.html",
            controller: "servicesController",
          })
          .state("webshop", {
            url: "/webshop",
            templateUrl: "./html/webshop.html",
            controller: "webshopController",
          })
          .state("contact", {
            url: "/contact",
            templateUrl: "./html/contact.html",
            controller: "contactController",
          })
          .state("login", {
            url: "/login",
            templateUrl: "./html/login.html",
            controller: "loginController",
          })
          .state("register", {
            url: "/register",
            templateUrl: "./html/register.html",
            controller: "registerController",
          })
          .state("cart", {
            url: "/cart",
            templateUrl: "./html/cart.html",
            controller: "cartController",
          });

        $urlRouterProvider.otherwise("/");
      },
    ])

    // Application run
    .run([
      "$rootScope",
      "util",
      "trans",
      function ($rootScope, util, trans) {
        console.log("Run...");
      },
    ])

    // Home controller
    .controller("homeController", [
      "$scope",
      function ($scope) {
        console.log("Home controller...");
      },
    ])

      // Services controller
      .controller("servicesController", [
        "$scope",
        function ($scope) {
          console.log("Service controller...");
        },
      ])

    // webshop controller
    .controller("webshopController", [
      "$scope",
      function ($scope) {
        console.log("webshop controller...");
      },
    ])

    // Contact controller
    .controller("contactController", [
      "$scope",
      function ($scope) {
        console.log("contact controller...");
      },
    ])

    // Login controller
    .controller("loginController", [
      "$scope",
      "util",
      function ($scope, util) {
        // Set model
        $scope.model = {
          email: "djksdjksdjk@dsdsd.dd",
          password: "12234Aa",
        };

        // Get required input elements, accept button, and modal properties
        let inputs = document.querySelectorAll("input[required]"),
          showHide = document.getElementById("show-password"),
          acceptBtn = document.getElementById("accept"),
          passwords = document.querySelectorAll(".input-password");

        // Add event listener for each required input(s).
        //inputs.forEach(element => {
        //  element.addEventListener('input', changed);
        //});

        // Add event listener to show-hide password.
        showHide.addEventListener("change", () => {
          passwords.forEach((element) => {
            if (showHide.checked) element.type = "text";
            else element.type = "password";
          });
        });

        // Add event listener accept button.
        $scope.accept = () => {
          //// Crete message
          //let msg = ``;
          //
          //// Each input elements
          //inputs.forEach((element) => {
          //
          //  // Add to message element identifier, and value
          //  msg += `${element.id.toUpperCase()}: ${element.value}\n`;
          //});

          // Show message
          alert(
            `Email: ${$scope.model.email}\nPassword: ${$scope.model.password}`
          );
        };

        // Input changed
        $scope.changed = () => {
          // Set auxiliary variable
          let isDisabled = false;

          // Each required input(s)
          //Object.keys($scope.model).forEach(key => {
          inputs.forEach((element) => {
            // Get element identifier, value, belonging to it check mark, and set variable is valid to false
            let key = element.id,
              value = $scope.model[key],
              checkMark = element
                .closest(".input-row")
                .querySelector(".check-mark"),
              isValid = true;

            // Switch input identifier
            switch (key) {
              case "email":
                isValid = util.isEmail(value);
                break;
              case "password":
                isValid = util.isPassword(value);
            }

            // Check mark
            if (isValid) checkMark.classList.add("show");
            else checkMark.classList.remove("show");

            // Check is disabled
            isDisabled = isDisabled || !isValid;
          });

          // Set accept button
          acceptBtn.disabled = isDisabled;
        };

        // Input changed
        $scope.changed();
      },
    ])

    // Register controller
    .controller("registerController", [
      "$scope",
      function ($scope) {
        console.log("Register controller...");
      },
    ])

    // cart controller
    .controller("cartController", [
      "$scope",
      function ($scope) {
        console.log("cart controller...");
      },
    ]);
})(window, angular);


  function changeLanguageImage() {
    console.log("change language image");
    let language = document.documentElement.lang;
    let languageImageContainer = document.querySelector(".dropdown-toggle");
    let img = document.createElement("img");
    let languageFlag = `./img/${language}.png`;
    img.src = languageFlag;
    img.style = "width: 40px";
    languageImageContainer.innerHTML = "";
    languageImageContainer.append(img);
  }
  changeLanguageImage();

