(function (window, angular) {
  "use strict";

  // Application module
  angular
    .module("app", ["ui.router", "app.common", "app.language", "app.form"])

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
          .state("profile", {
            url: "/profile",
            templateUrl: "./html/profile.html",
            controller: "profileController",
          })
          .state("cart", {
            url: "/cart",
            templateUrl: "./html/cart.html",
            controller: "cartController",
          });

        $urlRouterProvider.otherwise("/");
      },
    ])

    // Cart handle factory
    /*
    .factory('cartHandle', [
      '$rootScope',
      '$timeout',
      'util',
      ($rootScope, $timeout, util) => {
        let orders = [];
        let order = {
          id: 15,
          name: "Nokia",
          price: 12323
        };
        order.quantity = 1;


        let service = {
          add: (order) => {
            service.get().add(order);
          },
          remove: () => {
            service.add();
          },
          get: () => {
            return order;
          } 
        }

        return service;
      }
    ])
    */

    // User factory
    .factory("user", [
      "$rootScope",
      "$timeout",
      "util",
      ($rootScope, $timeout, util) => {
        // Set user default properties
        let user = {
          base: {
            id: null,
            type: null,
            prefix_name: null,
            first_name: null,
            middle_name: null,
            last_name: null,
            suffix_name: null,
            nick_name: null,
            gender: null,
            img: null,
            img_type: null,
            email: null,
          },
          rest: {
            born: null,
            country: null,
            country_code: null,
            phone: null,
            city: null,
            postcode: null,
            address: null,
          },
        };

        // Set service
        let service = {
          // Initialize
          init: () => {
            service.set(
              util.objMerge(
                user.base,
                {
                  email: window.localStorage.getItem(
                    $rootScope.app.id + "_user_email"
                  ),
                },
                true
              ),
              false
            );
          },

          // Set
          set: (data, isSave = true) => {
            $rootScope.user = util.objMerge(user.base, data, true);
            if (util.isBoolean(isSave) && isSave) service.save();
            $timeout(() => {
              $rootScope.$applyAsync();
            });
          },

          // Get
          get: (filter = null) => {
            if (util.isArray(filter))
              return Object.keys($rootScope.user)
                .filter((k) => !filter.includes(k))
                .reduce((o, k) => {
                  return Object.assign(o, { [k]: $rootScope.user[k] });
                }, {});
            else return $rootScope.user;
          },

          // Default
          def: (filter = null, key = null) => {
            let prop = util.isObjectHasKey(user, key)
              ? user[key]
              : util.objMerge(user.base, user.rest);
            if (util.isArray(filter))
              return Object.keys(prop)
                .filter((k) => !filter.includes(k))
                .reduce((o, k) => {
                  return Object.assign(o, { [k]: prop[k] });
                }, {});
            else return prop;
          },

          // Reset
          reset: () => {
            return new Promise((resolve) => {
              Object.keys(user.base).forEach((k) => {
                if (k !== "email") $rootScope.user[k] = null;
              });
              $timeout(() => {
                $rootScope.$applyAsync();
                resolve();
              });
            });
          },

          // Save
          save: () => {
            window.localStorage.setItem(
              $rootScope.app.id + "_user_email",
              $rootScope.user.email
            );
          },
        };

        // Return service
        return service;
      },
    ])

    // Application run
    .run([
      "$state",
      "$rootScope",
      "$timeout",
      "trans",
      "lang",
      "user",
      function ($state, $rootScope, $timeout, trans, lang, user) {
        console.log("Run...");

        // Transaction events
        trans.events("home,services,webshop,contact");

        // Initialize language
        lang.init();
        console.log("lang: " + $rootScope.lang.available[lang.index]);
        // Initialize user
        user.init();
        console.log("user.id " + $rootScope.user.id);
        // Get current date
        $rootScope.currentDay = new Date();

        

        // Logout
        $rootScope.logout = () => {
          // Confirm
          if (confirm("Biztosan kijelentkezik?")) {
            // Reset user
            user.reset().then(() => {
              // Go to login
              $state.go("login");
            });
          }
        };
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
      "$rootScope",
      "util",
      "user",
      "http",
      "$state",
      function ($scope, $rootScope, util, user, http, $state) {
        
        // handling modal windows
        $rootScope.loginModal = new bootstrap.Modal(
          document.getElementById("loginModal"),
          {
            keyboard: false,
            backdrop: "static",
          }
        );
        

        $scope.inputType = "password";

        $scope.showHide = () => {
          $scope.inputType =
            $scope.showHidePassword == true ? "password" : "text";
          $scope.$applyAsync();
        };

        // Set model
        $scope.model = {
          email: $rootScope.user.email,
          password: null,
        };

        // Get required input elements, accept button, and modal properties
        let inputs = document.querySelectorAll("input[required]"),
          acceptBtn = document.getElementById("accept");
        console.log(
          "inputs: " + $scope.model.email + "acceptBTN: " + acceptBtn
        );

        // Add event listener accept button.
        $scope.accept = () => {
          // Get only necessary properties
          let data = {
            email: $scope.model.email,
            password: $scope.model.password,
          };
          // Http request
          http
            .request({
              url: "./php/login.php",
              method: "GET",
              data: data,
            })
            .then((response) => {
              console.log(response);
              response.email = $scope.model.email;
              user.set(response);
              console.log("user.id " + $rootScope.user.id);
              // Go to previouse page
              $scope.$applyAsync();
              window.history.back();
            });
        };

        /* // Add event listener cancel button.
        $scope.cancel = () => {
        }; */

        // Input changed
        $scope.changed = () => {
          let isDisabled = false;

          inputs.forEach((element) => {
            // Get element identifier, value, belonging to it check mark, and set variable is valid to false
            let key = element.id,
              value = $scope.model[key],
              checkMark = element
                .closest(".input-group")
                .querySelector(".check-mark"),
              isValid = true;

            // Switch input identifier
            switch (key) {
              case "email":
                isValid = util.isEmail(value);
                break;
              case "password":
                isValid = util.isPassword(value);
                break;
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
        console.log("register");

        // handling modal windows
        let registerModal = new bootstrap.Modal(
          document.getElementById("registerModal"),
          {
            keyboard: false,
            backdrop: "static",
          }
        );

        registerModal.show();
      },
    ])

    // Profile controller
    .controller("profileController", [
      "$scope",
      function ($scope) {
        console.log("profile controller...");
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
