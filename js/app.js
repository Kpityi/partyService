(function (window, angular) {
  'use strict';

  // Application module
  angular
    .module('app', ['ui.router', 'app.common', 'app.language', 'app.form'])

    // Application config
    .config([
      '$stateProvider',
      '$urlRouterProvider',
      function ($stateProvider, $urlRouterProvider) {
        $stateProvider
          .state('home', {
            url: '/',
            templateUrl: './html/home.html',
            controller: 'homeController',
          })
          .state('services', {
            url: '/services',
            templateUrl: './html/services.html',
            controller: 'servicesController',
          })
          .state('webshop', {
            url: '/webshop',
            templateUrl: './html/webshop.html',
            controller: 'webshopController',
          })
          .state('reating', {
            url: '/reating',
            templateUrl: './html/reating.html',
            controller: 'reatingController',
          })
          .state('contact', {
            url: '/contact',
            templateUrl: './html/contact.html',
            controller: 'contactController',
          })
          .state('profile', {
            url: '/profile',
            templateUrl: './html/profile.html',
            controller: 'profileController',
          })
          .state('cart', {
            url: '/cart',
            templateUrl: './html/cart.html',
            controller: 'cartController',
          });

        $urlRouterProvider.otherwise('/');
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
    .factory('user', [
      '$rootScope',
      '$timeout',
      'util',
      ($rootScope, $timeout, util) => {
        // Set user default properties
        let user = {
          base: {
            id: null,
            type: null,
            first_name: null,
            last_name: null,
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
                    $rootScope.app.id + '_user_email'
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
                if (k !== 'email') $rootScope.user[k] = null;
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
              $rootScope.app.id + '_user_email',
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
      '$state',
      '$rootScope',
      '$timeout',
      'trans',
      'lang',
      'user',

      function ($state, $rootScope, $timeout, trans, lang, user) {
        console.log('Run...');

        // Transaction events
        trans.events('home,services,webshop,contact');

        // Initialize language
        lang.init();

        // Initialize user
        user.init();
        console.log('user.id ' + $rootScope.user.id);
        // Get current date
        $rootScope.currentDay = new Date();

        // Logout
        $rootScope.logout = () => {
          // Confirmf
          if (confirm('Biztosan kijelentkezik?')) {
            // Reset user
            user.reset().then(() => {
              // Go to login
              $state.go('home');
            });
          }
        };
      },
    ])

    // Home controller
    .controller('homeController', [
      '$scope',
      'http',
      '$timeout',
      '$state',
      function ($scope, http, $timeout, $state) {
        console.log('Home controller...');

        const myCarouselElement = document.querySelector('#homeCarousel');
        const carousel = new bootstrap.Carousel(myCarouselElement, {
          interval: 4000,
        });
        carousel.to(1);

        $scope.images = [];
        $scope.ratings = [];

        // Http request
        http
          .request('./php/carousel.php')
          .then((response) => {
            $scope.data = response;
            $scope.data.forEach((image) => {
              image = image.replace('../', './');
              $scope.images.push(image);
            });
          })
          .catch((e) => {
            // Resolve completed, and show error

            $timeout(() => alert(e));
          });

        // Http request
        http
          .request('./php/ratings.php')
          .then((response) => {
            $scope.ratings = response;
            console.log(response);
          })
          .catch((e) => {
            // Resolve completed, and show error

            $timeout(() => alert(e));
          });
      },
    ])

    // Services controller
    .controller('servicesController', [
      '$scope',
      '$rootScope',
      'http',
      '$timeout',
      function ($scope, $rootScope, http, $timeout) {
        console.log('Service controller...');

        // Menues tab

        //carouusel
        const myCarouselElement = document.querySelector('#menuCarousel');
        const carousel = new bootstrap.Carousel(myCarouselElement, {
          interval: 2000,
        });
        carousel.to(1);

        $scope.reservationData = {
          userId: null,
          date: null,
          eventPlaceId: null,
          eventTypeId: null,
          menuId: null,
          drinkPackage: null,
          guests: null,
        };
        $scope.originalReservationData = angular.copy($scope.reservationData);

        $scope.menus = [];
        $scope.eventMenus = [];
        $scope.drinkPackages = [];
        $scope.eventsData = [];
        $scope.images = [];

        // Http request menus
        http
          .request('./php/menus2.php')
          .then((response) => {
            $scope.menus = response;
            $scope.eventMenus = response.slice(0, -3);
            $scope.eventMenus.push({ menu_name: 'none', id: null });
            $scope.drinkPackages = response.slice(-3);
            $scope.drinkPackages.push({ menu_name: 'none', id: null });
          })
          .catch((e) => {
            // Resolve completed, and show error

            $timeout(() => alert(e));
          });

        // Http request carousel food pictures
        http
          .request('./php/carousel_foods.php')
          .then((response) => {
            $scope.data = response;
            $scope.data.forEach((image) => {
              image = image.replace('../', './');
              $scope.images.push(image);
            });
          })
          .catch((e) => {
            // Resolve completed, and show error

            $timeout(() => alert(e));
          });

        // reservation tab

        // Http request event types & event places
        http
          .request('./php/services.php')
          .then((response) => {
            $scope.eventsData = response;
            console.log($scope.eventsData);
          })
          .catch((e) => {
            // Resolve completed, and show error

            $timeout(() => alert(e));
          });

        //set min & max data
        $scope.reservDate = {
          max: moment().add(2, 'years').format('YYYY-MM-DD'),
          min: moment().add(1, 'days').format('YYYY-MM-DD'),
          placeholder: moment().add(1, 'days').format('YYYY-MM-DD'),
        };
        console.log($scope.reservDate);

        $scope.checkDays = () => {
          // Http request check available days
          http
            .request({
              url: './php/check_days.php',
              method: 'POST',
              data: { id: $scope.reservationData.event_place.id },
            })
            .then((response) => {
              if (response) {
                const disabledDates = response.map((date) => date.date);
              }

              $('#date').datepicker({
                changeMonth: true,
                changeYear: true,
                minDate: new Date($scope.reservDate.min),
                maxDate: new Date($scope.reservDate.max),
                firstDay: 1,
                dayNamesMin:
                  $rootScope.lang.id === 'hu'
                    ? ['V', 'H', 'K', 'Sze', 'Cs', 'P', 'Szo']
                    : $rootScope.lang.id === 'en'
                    ? ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa']
                    : ['So', 'Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa'],
                dateFormat: 'yy-mm-dd',
                beforeShowDay: function (date) {
                  const dateString = jQuery.datepicker.formatDate(
                    'yy-mm-dd',
                    date
                  );
                  return [disabledDates.indexOf(dateString) === -1];
                },
              });
            })
            .catch((e) => {
              // Resolve completed, and show error

              $timeout(() => alert(e));
            });
        };

        $scope.dayReservation = () => {
          alert('sikeres foglalás');
          $scope.reservation = {
            userId: $rootScope.user.id,
            date: moment($scope.reservationData.date).format('YYYY-MM-DD'),
            eventPlaceId: $scope.reservationData.event_place.id,
            eventTypeId: $scope.reservationData.event.id,
            menuId: $scope.reservationData.event_menu.id,
            drinkPackageId: $scope.reservationData.drink_package.id,
            guests: $scope.reservationData.guests,
          };

          // Http request reservation
          http
            .request({
              url: './php/reservation.php',
              method: 'POST',
              data: $scope.reservation,
            })
            .then((response) => {
              // Check success
              if (response.affectedRows) {
                console.log(response.lastInsertId);
                $scope.$applyAsync();
                alert(`Reservation succesfull,  ${response.lastInsertId}`);
                $scope.reservationData = angular.copy(
                  $scope.originalReservationData
                );
              } else alert(`Reservation unsuccesfull!  ${response}`);
            })
            .catch((error) => {
              $timeout(() => alert(error), 50);
            });
        };
      },
    ])

    // webshop controller
    .controller('webshopController', [
      '$scope',
      function ($scope) {
        console.log('webshop controller...');
      },
    ])

    // Contact controller
    .controller('contactController', [
      '$scope',
      function ($scope) {
        console.log('contact controller...');
      },
    ])

    // Login controller
    .controller('loginController', [
      '$scope',
      '$rootScope',
      'util',
      'user',
      'http',
      '$state',
      function ($scope, $rootScope, util, user, http, $state) {
        // handling modal windows
        $rootScope.loginModal = new bootstrap.Modal(
          document.getElementById('loginModal'),
          {
            keyboard: false,
            backdrop: 'static',
          }
        );

        $scope.inputType = 'password';

        $scope.showHide = () => {
          $scope.inputType =
            $scope.showHidePassword == true ? 'password' : 'text';
          $scope.$applyAsync();
        };

        // Set model
        $scope.model = {
          email: 'kertesz.istvan-e2022@keri.mako.hu',
          password: '1234Aa',
        };

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
              url: './php/login.php',
              method: 'GET',
              data: data,
            })
            .then((response) => {
              console.log(response);
              $scope.model.email = response.email;
              user.set(response);
              $scope.$applyAsync();
            });
        };
      },
    ])

    // Register controller
    .controller('registerController', [
      '$scope',
      '$rootScope',
      'util',
      'http',
      'user',
      '$timeout',
      function ($scope, $rootScope, util, http, user, $timeout) {
        // handling modal windows
        $rootScope.registerModal = new bootstrap.Modal(
          document.getElementById('registerModal'),
          {
            keyboard: false,
            backdrop: 'static',
          }
        );

        // Form initial values
        $scope.values = {
          lastName: '',
          firstName: '',
          dateOfBirth: null,
          gender: null,
          country: null,
          countryCode: null,
          phone: '',
          postcode: '',
          city: '',
          address: '',
          email: '',
          emailConfirm: '',
          password: '',
          passwordConfirm: '',
          testcode: '',
        };

        $scope.handleCountryChange = (country) => {
          $scope.values.countryCode = country.code?.[0] || null;
        };

        $scope.validateEmailConfirm = () => {
          const { email, emailConfirm } = $scope.values;
          $scope.registerForm.emailConfirm.$setValidity(
            'emailMismatch',
            email === emailConfirm
          );
        };

        $scope.validatePasswordConfirm = () => {
          const { password, passwordConfirm } = $scope.values;
          $scope.registerForm.passwordConfirm.$setValidity(
            'passwordMismatch',
            password === passwordConfirm
          );
        };

        $scope.validateTestcode = () => {
          const { testcode } = $scope.values;
          $scope.registerForm.testcode.$setValidity(
            'testcodeMismatch',
            testcode === $scope.code
          );
        };

        //set ppasword type and password visibility
        $scope.inputType = 'password';

        $scope.showHide = () => {
          $scope.inputType =
            $scope.showHidePassword == true ? 'password' : 'text';
          $scope.$applyAsync();
        };

        // Create new deffered objects
        $scope.countries = util.deferredObj();

        //set helper
        $scope.helper = {
          maxBorn: moment().subtract(18, 'years').format('YYYY-MM-DD'),
          minBorn: moment().subtract(120, 'years').format('YYYY-MM-DD'),
        };

        $scope.code = util.getTestCode();
        $scope.testcode = null;

        // Http request
        http
          .request($rootScope.app.commonPath + `data/countries.json`)
          .then((response) => {
            $scope.helper.countries = response;
            $scope.countries.promise.resolve();
          })
          .catch((e) => {
            // Resolve completed, reset asynchronous, and show error
            countries.promise.resolve();
            $timeout(() => alert(e), 50);
          });

        // Initialize testcode
        $scope.testcodeInit = (event) => {
          if (
            event.ctrlKey &&
            event.altKey &&
            event.key.toUpperCase() === 'T'
          ) {
            $scope.testcode = $scope.code;
            event.currentTarget.parentElement
              .querySelector('.clear-icon')
              .classList.add('show');
            $scope.$applyAsync();
          }
        };
        // Refresh testcode
        $scope.testcodeRefresh = (event) => {
          event.preventDefault();
          $scope.code = util.getTestCode();
          $scope.values.testcode = null;
          $scope.$applyAsync();
          event.currentTarget
            .closest('.input-group')
            .querySelector('input')
            .focus();
        };
        $scope.accept = () => {
          // Get user data
          $scope.userData = {
            first_name: $scope.values.firstName,
            last_name: $scope.values.lastName,
            born: moment($scope.values.dateOfBirth).format('YYYY-MM-DD'),
            gender: $scope.values.gender,
            country: $scope.values.country.country.toUpperCase(),
            country_code: $scope.values.countryCode,
            phone: $scope.values.phone,
            city: $scope.values.city,
            postcode: $scope.values.postcode,
            address: $scope.values.address,
            email: $scope.values.email,
            password: $scope.values.password,
          };
          console.log($scope.userData);
          // Http request for registration
          http
            .request({
              url: './php/register.php',
              method: 'POST',
              data: $scope.userData,
            })
            .then((response) => {
              // Check success
              if (response.affectedRows) {
                console.log(response.lastInsertId);
                $scope.$applyAsync();
                alert(
                  `Registration succesfull, new User identifier: ${response.lastInsertId}`
                );
              } else alert(`Registration unsuccesfull!  ${response}`);
            })
            .catch((error) => {
              $timeout(() => alert(error), 50);
            });
        };
      },
    ])

    // Profile controller
    .controller('profileController', [
      '$scope',
      '$rootScope',
      'util',
      'http',
      'user',
      '$timeout',
      '$state',
      function ($scope, $rootScope, util, http, user, $timeout, $state) {
        console.log('profile controller...');

        //set helper variables
        $scope.helper = {
          isEdit: true,
          maxBorn: moment().subtract(18, 'years').format('YYYY-MM-DD'),
          minBorn: moment().subtract(120, 'years').format('YYYY-MM-DD'),
        };

        // Form initial values
        $scope.values = {
          lastName: $rootScope.user.last_name,
          firstName: $rootScope.user.first_name,
          img: $rootScope.user.img,
          img_type: $rootScope.user.img_type,
          dateOfBirth: null,
          gender: $rootScope.user.gender == 1 ? 'male' : 'female',
          country: "hungary",
          country_code: null,
          phone: '',
          postcode: '',
          city: '',
          address: '',
        };

        //save original user data
        $scope.UserData={}

        // Create new deffered objects
        $scope.countries = util.deferredObj();

        // Http request
        http
          .request($rootScope.app.commonPath + `data/countries.json`)
          .then((response) => {
            $scope.helper.countries = response;
            $scope.countries.promise.resolve();
          })
          .catch((e) => {
            // Resolve completed, reset asynchronous, and show error
            countries.promise.resolve();
            $timeout(() => alert(e), 50);
          });

        $scope.handleCountryChange = (country) => {
          $scope.values.country_code = country.code?.[0] || null;
        };

        //Http request user data
        http
            .request({
              url: './php/get_profile.php',
              method: 'POST',
              data: {id: $rootScope.user.id},
            })
            .then((response) => {
              console.log(response)
              $scope.values.dateOfBirth = moment(response.born).toDate();

              $scope.values.phone = response.phone;
              $scope.values.city = response.city;
              $scope.values.postcode = response.postcode;
              $scope.values.address = response.address;
              
              // Get user country index from contries
              let index = util.indexByKeyValue(
                $scope.helper.countries, 
                'country', 
                response.country
              );

              // Check exist
              if (index !== -1) {
                let codeIndex= $scope.helper.countries[index].code.indexOf(response.country_code)
                $scope.values.country        = $scope.helper.countries[index];
                $scope.values.country_code  = $scope.helper.countries[index].code[codeIndex];
              }
              $scope.userData= angular.copy($scope.values);
              $scope.$applyAsync
            })
            .catch((error) => {
              $timeout(() => alert(error), 50);
            });

            $scope.accept= ()=>{
              console.log($scope.values)
              $scope.helper.isEdit=true;
              $state.reload();
            }

            $scope.cancel= ()=>{
              $scope.values=angular.copy($scope.UserData);
              $scope.helper.isEdit=true;
              $state.reload();
            }
      },
    ])

    // cart controller
    .controller('cartController', [
      '$scope',
      function ($scope) {
        console.log('cart controller...');
      },
    ])

    // Reating controller
    .controller('reatingController', [
      '$scope',
      function ($scope) {
        $scope.reating = null;
        $scope.clicked = (event) => {
          $scope.reating = event.currentTarget.dataset.reating;
        };

        $scope.send = () => {
          alert($scope.reating);
        };

        $scope.reset = () => {
          $scope.reating = null;
        };
      },
    ]);
})(window, angular);
