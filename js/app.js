(function (window, angular) {
  'use strict';

  // Application module
  angular
    .module('app', ['ui.router', 'app.common', 'app.language', 'app.form'])

    //file model
    .directive('fileModel', [
      '$parse',
      function ($parse) {
        return {
          restrict: 'A',
          link: function (scope, element, attrs) {
            const model = $parse(attrs.fileModel);
            const modelSetter = model.assign;

            element.bind('change', function () {
              scope.$apply(function () {
                modelSetter(scope, element[0].files[0]);
              });
            });
          },
        };
      },
    ])

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
          .state('order', {
            url: '/order',
            templateUrl: './html/order.html',
            controller: 'orderController',
          });

        $urlRouterProvider.otherwise('/');
      },
    ])

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
      'trans',
      'lang',
      'user',
      function ($state, $rootScope, trans, lang, user) {
        console.log('Run...');
        $rootScope.showCart = false;
        $rootScope.cart = [];

        // Transaction events
        trans.events('home,services,webshop,contact');

        // Initialize language
        lang.init();

        // Initialize user
        user.init();

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
      '$rootScope',
      'lang',
      function ($scope, http, $timeout, $rootScope, lang) {
        console.log('Home controller...');

        // Set carousel element
        const myCarouselElement = document.querySelector('#homeCarousel');
        const carousel = new bootstrap.Carousel(myCarouselElement, {
          interval: 4000,
        });
        carousel.to(1);

        // initialize necessary variable
        $scope.images = [];
        $scope.ratings = [];
        $scope.rating = null;
        $scope.ratingData = {
          rating: null,
          ratingText: '',
        };

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
            $timeout(() => alert(lang.translate(e, true)));
          });

        // Http request
        http
          .request('./php/ratings.php')
          .then((response) => {
            $scope.ratings = response;
          })
          .catch((e) => {
            // Resolve completed, and show error

            $timeout(() => alert(lang.translate(e, true)));
          });

        // Send Rating
        $scope.clicked = (event) => {
          $scope.ratingData.rating = event.currentTarget.dataset.rating;
        };

        $scope.send = () => {
          $scope.rating_data = {
            user_id: $rootScope.user.id,
            rating: $scope.ratingData.rating,
            rating_text: $scope.ratingData.ratingText,
          };
          http
            .request({
              url: './php/send_rating.php',
              method: 'POST',
              data: $scope.rating_data,
            })
            .then((response) => {})
            .catch((e) => {

              // Resolve completed, and show error
              $timeout(() => alert(lang.translate(e, true)));
            });
          console.log($scope.rating_data);
        };
      },
    ])

    // Services controller
    .controller('servicesController', [
      '$scope',
      '$rootScope',
      'http',
      '$timeout',
      'lang',
      function ($scope, $rootScope, http, $timeout, lang) {
        console.log('Service controller...');

        // Menues tab

        //carouusel
        const myCarouselElement = document.querySelector('#menuCarousel');
        const carousel = new bootstrap.Carousel(myCarouselElement, {
          interval: 2000,
          ride: 'carousel',
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

        //save the empty reservation data
        $scope.originalReservationData = angular.copy($scope.reservationData);

        $scope.menus = [];
        $scope.eventMenus = [];
        $scope.drinkPackages = [];
        $scope.eventsData = [];
        $scope.images = [];

        // Http request menus
        http
          .request('./php/menus.php')
          .then((response) => {
            $scope.menus = response;
            $scope.eventMenus = response.slice(0, -3);
            $scope.eventMenus.push({ menu_name: 'none', id: null });
            $scope.drinkPackages = response.slice(-3);
            $scope.drinkPackages.push({ menu_name: 'none', id: null });
          })
          .catch((e) => {

            // Resolve completed, and show error
            $timeout(() => alert(lang.translate(e, true)));
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
            $timeout(() => alert(lang.translate(e, true)));
          });

        // reservation tab

        // Http request event types & event places
        http
          .request('./php/services.php')
          .then((response) => {
            $scope.eventsData = response;
          })
          .catch((e) => {

            // Resolve completed, and show error
            $timeout(() => alert(lang.translate(e, true)));
          });

        //set min & max data
        $scope.reservDate = {
          max: moment().add(2, 'years').format('YYYY-MM-DD'),
          min: moment().add(1, 'days').format('YYYY-MM-DD'),
          placeholder: moment().add(1, 'days').format('YYYY-MM-DD'),
        };

        //check reserved day and set to inactive
        $scope.checkDays = () => {
          // Http request check available days
          http
            .request({
              url: './php/check_days.php',
              method: 'POST',
              data: { id: $scope.reservationData.event_place.id },
            })
            .then((response) => {
              const disabledDates = response
                ? response.map((date) => date.date)
                : [];
              $('#date').datepicker('destroy');
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
              $timeout(() => alert(lang.translate(e, true)));
            });
        };

        $scope.dayReservation = () => {
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
                let { id, type } = $rootScope.lang;
                http
                .request({
                  url: './php/reservation_email.php',
                  method: 'POST',
                  data: {
                    email: $rootScope.user.email,
                    userName: $rootScope.user.first_name,
                    lang: { id, type },
                  },
                })
                .then((response) => {
                  alert(lang.translate("succesful_reservation", true));
                })
                .catch((error) => {
                  $timeout(() => alert(lang.translate(error, true)), 50);
                });
                alert(`Reservation succesfull,  ${response.lastInsertId}`);
                $scope.reservationData = angular.copy(
                  $scope.originalReservationData
                  );
                } else alert(lang.translate('Reservation unsuccesfull!', true));
              })
              .catch((error) => {
                $timeout(() => alert(lang.translate(error, true)), 50);
              });
            };
          },
        ])
        
    // webshop controller
    .controller('webshopController', [
      '$scope',
      '$rootScope',
      'http',
      '$timeout',
      'lang',
      function ($scope, $rootScope, http, $timeout, lang) {
        console.log('webshop controller...');

        $scope.products = [];

        // Http request products
        http
          .request('./php/products.php')
          .then((response) => {
            $scope.products = response;
            $scope.$applyAsync();
            })
          .catch((error) => {
            $timeout(() => alert(lang.translate(error, true)), 50);
          });

          //Add to cart event
        $scope.addToCart = (product) => {
          let index = $rootScope.cart.findIndex((x) => x.id == product.id);
          if (index == -1) {
            let order = {
              id: product.id,
              img: product.image,
              name: product.product_name,
              price: product.price,
              quantity: 1,
            };
            $rootScope.cart.push(order);
          } else {
            $rootScope.cart[index].quantity++;
          }
        };
      },
    ])

    // Contact controller
    .controller('contactController', [
      '$scope',
      'http',
      'lang',
      '$rootScope',
      function ($scope, http, lang, $rootScope) {
        console.log('contact controller...');

        // Set model
        $scope.model = {
          email: $rootScope.user.email ? $rootScope.user.email : null,
          message: null,
        };

        // Message sending button.
        $scope.send = () => {
          // Get only necessary properties
          let data = {
            lang: {
              id: $rootScope.lang.id,
              type: $rootScope.lang.type,
            },
            email: $scope.model.email,
            message: $scope.model.message,
          };
          // Http request
          http
            .request({
              url: './php/contact_email_sending.php',
              method: 'POST',
              data: data,
            })
            .then((response) => {
              alert(lang.translate(response, true));
            })
            .catch((e) => {
              alert(lang.translate(e, true));
            });
        };
      },
    ])

    // Login controller
    .controller('loginController', [
      '$scope',
      '$rootScope',
      'user',
      'http',
      '$state',
      'lang',
      function ($scope, $rootScope, user, http, $state, lang) {
       
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
          email: null, 
          password: null
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
              if ($state.current.name == 'order') {
                $state.reload();
              }
            })
            .catch((e) => {
              alert(lang.translate(e, true));
              $scope.model = {
                email: null, 
                password: null
              };
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
      '$timeout',
      'lang',
      function ($scope, $rootScope, util, http, $timeout, lang) {
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
            $scope.$applyAsync();
          })
          .catch((e) => {
            // Resolve completed, reset asynchronous, and show error
            countries.promise.resolve();
            $timeout(() => alert(lang.translate(e,true)), 50);
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
                $scope.$applyAsync();
                alert(lang.translate('Registration_succesfull', true))
              } else alert(lang.translate('registration_failed', true));
            })
            .catch((error) => {
              $timeout(() => alert(lang.translate(error,true)), 50);
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
      'lang',
      function ($scope, $rootScope, util, http, user, $timeout, $state, lang) {
        console.log('profile controller...');

        //check user
        if (!$rootScope.user.id) {
          $state.go('home');
          return;
        }

        //Profile tab
        // Form initial values
        $scope.values = {
          lastName: $rootScope.user.last_name,
          firstName: $rootScope.user.first_name,
          img: $rootScope.user.img,
          newImage: null,
          img_type: $rootScope.user.img_type,
          dateOfBirth: null,
          gender: $rootScope.user.gender == 1 ? 'male' : 'female',
          country: null,
          country_code: null,
          phone: '',
          postcode: '',
          city: '',
          address: '',
        };

        //set helper variables
        $scope.helper = {
          isEdit: true,
          maxBorn: moment().subtract(18, 'years').format('YYYY-MM-DD'),
          minBorn: moment().subtract(120, 'years').format('YYYY-MM-DD'),
          image: $scope.values.img_type
            ? `url(data:${$scope.values.img_type};base64,${$scope.values.img})`
            : `url(${$rootScope.app.commonPath}media/image/blank/${
                $rootScope.user.gender === 2 ? 'fe' : ''
              }male-blank.webp)`,
        };

        //save original user data
        $scope.UserData = {};

        // Http request
        http
          .request($rootScope.app.commonPath + `data/countries.json`)
          .then((response) => {
            $scope.helper.countries = response;
            $scope.$applyAsync();
          })
          .catch((e) => {
            // Resolve completed, reset asynchronous, and show error
            countries.promise.resolve();
            $timeout(() => alert(lang.translate(e,true)), 50);
          });

        $scope.handleCountryChange = (country) => {
          $scope.values.country_code = country.code?.[0] || null;
        };

        //Http request user data
        http
          .request({
            url: './php/get_profile.php',
            method: 'POST',
            data: { id: $rootScope.user.id },
          })
          .then((response) => {
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
              let codeIndex = $scope.helper.countries[index].code.indexOf(response.country_code);
              $scope.values.country = $scope.helper.countries[index];
              $scope.values.country_code = $scope.helper.countries[index].code[codeIndex];
            }
            $scope.userData = angular.copy($scope.values);
            $scope.$applyAsync();
          })
          .catch((error) => {
            $timeout(() => alert(lang.translate(error, true)), 50);
          });

        $scope.$watch('newImage', (newValue, oldValue) => {
          console.log('newValue: ', newValue);
          if (newValue !== oldValue) {
            if (newValue.size <= 64 * 1024) {
              const reader = new FileReader();
              reader.onload = (event) => {
                console.log('event: ', event.target.result);
                $scope.values.img = event.target.result;
                $scope.values.newImage = `url(${event.target.result})`;
                $scope.values.img_type = newValue.type;
                $scope.$applyAsync();
              };
              reader.readAsDataURL(newValue);
            } else {
              alert('Max 64KB');
            }
          }
        });

        $scope.accept = () => {
          $scope.helper.isEdit = true;
          $scope.values.img = $scope.values.img.replace(
            'data:image/jpeg;base64,',
            ''
          );
          let data = {
            id: $rootScope.user.id,
            lastName: $scope.values.lastName,
            firstName: $scope.values.firstName,
            img: $scope.values.img,
            img_type: $scope.values.img_type,
            dateOfBirth: $scope.values.dateOfBirth,
            gender: $scope.values.gender == 'male' ? 1 : 2,
            country: $scope.values.country.country,
            country_code: $scope.values.country_code,
            phone: $scope.values.phone,
            postcode: $scope.values.postcode,
            city: $scope.values.city,
            address: $scope.values.address,
          };

          // Http request
          http
            .request({
              url: `./php/profile.php`,
              method: 'POST',
              data: data,
            })
            .then((response) => {
              if (response.affectedRows) {
                user.set(data, false);
              } else alert('Modify data failed!');
            })
            // Error
            .catch((e) => {
              // Reset asynchronous, and show error
              $timeout(() => alert(lang.translate(e, true)), 50);
            });
        };

        $scope.cancel = () => {
          $scope.values = angular.copy($scope.UserData);
          $scope.helper.isEdit = true;
          $state.reload();
        };

        //Reservation tab
        $scope.reservations = {};

        // Http request
        http
          .request({
            url: `./php/get_reservation.php`,
            method: 'Get',
            data: { id: $rootScope.user.id },
          })
          .then((response) => {
            $scope.reservations = response;
          })
          // Error
          .catch((e) => {
            // Reset asynchronous, and show error
            $timeout(() => alert(lang.translate(e, true)), 50);
          });

        //Orders tab
        $scope.orders = {};

        // Http request
        http
          .request({
            url: `./php/get_orders.php`,
            method: 'Get',
            data: { id: $rootScope.user.id },
          })
          .then((response) => {
            $scope.orders = response;
          })
          // Error
          .catch((e) => {
            // Reset asynchronous, and show error
            $timeout(() => alert(lang.translate(e, true)), 50);
          });
      },
    ])

    // cart controller
    .controller('cartController', [
      '$scope',
      '$rootScope',
      function ($scope, $rootScope) {
        console.log('cart controller...');

        // calculate total price
        $scope.getTotalPrice = () => {
          let sum = 0;
          $rootScope.cart.forEach((x) => {
            sum += x.price * x.quantity;
          });
          return sum;
        };

        // remove product from cart
        $scope.removeFromCart = (product) => {
          let index = $rootScope.cart.findIndex((x) => x.id == product.id);
          $rootScope.cart.splice(index, 1);
        };
      },
    ])

    // order controller
    .controller('orderController', [
      '$scope',
      '$rootScope',
      'util',
      'http',
      'lang',
      function ($scope, $rootScope, util, http, lang) {
        console.log('order controller...');

        $scope.shipping = 1250;
        let { id, type } = $rootScope.lang;
        let lang = { id, type };

        // calculate total price
        $scope.getTotalPrice = () => {
          let sum = 0;
          $rootScope.cart.forEach((x) => {
            sum += x.price * x.quantity;
          });
          return sum;
        };

         // increase product quantity
        $scope.increase = (id) => {
          let index = $rootScope.cart.findIndex((x) => x.id == id);
          $rootScope.cart[index].quantity++;
        };

        //decrease pruduct quantity
        $scope.decrease = (id) => {
          let index = $rootScope.cart.findIndex((x) => x.id == id);
          $rootScope.cart[index].quantity--;
          
          // if product quantity equal 0 remove from cart
          if ($rootScope.cart[index].quantity === 0)
            $rootScope.cart.splice(index, 1);
        };

        // remove product from cart
        $scope.removeFromCart = (product) => {
          let index = $rootScope.cart.findIndex((x) => x.id == product.id);
          $rootScope.cart.splice(index, 1);
        };

        if ($rootScope.user.id) {
          http
            .request({
              url: './php/get_profile_order.php',
              method: 'Get',
              data: {
                userId: $rootScope.user.id,
              },
            })
            .then((response) => {
              $scope.values = response;
            })
            .catch((error) => {
              alert(lang.translate(error, true));
            });
        }

        $scope.order = () => {
          let args = util.arrayObjFilterByKeys(
            $rootScope.cart,
            'id,quantity,name,price'
          );
          let { id, type } = $rootScope.lang;
          http
            .request({
              url: './php/set_order.php',
              method: 'POST',
              data: {
                userId: $rootScope.user.id,
                email: $rootScope.user.email,
                cart: args,
                shipping: $scope.shipping,
                total: $scope.getTotalPrice() + $scope.shipping,
                lang: { id, type },
                userName: $rootScope.user.first_name,
              },
            })
            .then((response) => {
              if(response=="email_sent_succesfull")
              {
                alert(lang.translate("succesful_order", true));
                $rootScope.cart=[];
                $state.go('webshop');
              }

            })
            .catch((error) => {
              console.log(lang.translate(error, true));
            });
        };
      },
    ]);
})(window, angular);
