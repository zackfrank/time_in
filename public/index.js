/* global Vue, VueRouter, axios, google */

var HomePage = {
  template: "#home-page",
  data: function() {
    return {};
  },
  created: function() {},
  methods: {},
  computed: {}
};

var Profile = {
  template: "#profile",
  data: function() {
    return {
      account: null,
      userId: localStorage.getItem("id"),
      accountId: localStorage.getItem("account_id"),
      user: null,
      students: null,
      tab: "user"
    };
  },
  created: function() {
    axios.get("/v1/users/" + this.userId).then(
      function(response) {
        this.user = response.data;
        axios.get("v1/accounts/" + this.accountId).then(
          function(response) {
            this.account = response.data;
            axios.get("v1/students/" + this.accountId).then(
              function(response) {
                this.students = response.data;
              }.bind(this)
            );
          }.bind(this)
        );
      }.bind(this)
    );
  },
  methods: {
    setTab: function(tab) {
      this.tab = tab;
    }
  },
  computed: {}
};

var Schedule = {
  template: "#schedule",
  data: function() {
    return {
      bookings: [],
      tab: "history",
      response: "",
      postOptInMessage: ""
    };
  },
  created: function() {
    axios.get("/v1/bookings").then(
      function(response) {
        this.bookings = response.data;
      }.bind(this)
    );
  },
  methods: {
    setTab: function(tab) {
      this.tab = tab;
    },
    pastStatusColor: function(status) {
      if (status !== "Booked") {
        var color = "red";
      } else {
        color = "black";
      }
      return color;
    },
    upcomingStatusColor: function(status) {
      if (status === "Booked") {
        var color = "black";
      } else if (status === "Cancelled") {
        color = "red";
      } else {
        color = "rgba(0, 0, 0, 0.5)";
      }
      return color;
    },
    takeSession: function(id) {
      var params = {
        status: "Booked"
      };
      axios.patch("/v1/bookings/" + id, params).then(
        function(response) {
          this.response = response.data;
          var booking = this.bookings.filter(booking => booking.id === id);
          booking[0].status = "Booked";
          this.postOptInMessage = "Session booked!";
        }.bind(this)
      );
    },
    cancelSession: function(id) {
      var params = {
        status: "Cancelled"
      };
      axios.patch("/v1/bookings/" + id, params).then(
        function(response) {
          this.response = response.data;
          var booking = this.bookings.filter(booking => booking.id === id);
          booking[0].status = "Cancelled";
          this.postOptInMessage = "Session cancelled. Thank you!";
        }.bind(this)
      );
    }
  },
  computed: {}
};

var Booking = {
  template: "#booking",
  data: function() {
    return {
      attendanceRecords: [],
      accountId: null,
      day: "Sunday",
      time: null,
      date: null,
      ar_id: null,
      spaceLeft: "",
      formattedDate: null,
      students: null,
      student: { first_name: "Blank" },
      booking: {},
      errors: [],
      error: "",
      weekOffset: 0,
      gcalDate: null
    };
  },
  created: function() {
    this.accountId = localStorage.getItem("account_id");
    axios.get("v1/students/" + this.accountId).then(
      function(response) {
        this.students = response.data;
        console.log(this.students);
      }.bind(this)
    );
    axios.get("v1/attendance_records").then(
      function(response) {
        this.attendanceRecords = response.data;
        console.log(this.attendanceRecords);
      }.bind(this)
    );
  },
  methods: {
    setDetails: function(time, date, gcal, arId, space) {
      this.time = time;
      this.date = date;
      this.gcalDate = gcal;
      this.ar_id = arId;
      this.spaceLeft = space;
    },
    bookSession: function() {
      this.errors = [];
      var params = {
        time: this.time,
        date: this.date,
        student_id: this.student.id,
        ar_id: this.ar_id
      };
      console.log(params);
      axios
        .post("v1/bookings", params)
        .then(
          function(response) {
            this.booking = response.data;
            if (response.data.error) {
              this.errors.push(response.data.error);
              console.log(this.error);
            }
            console.log(this.booking);
          }.bind(this)
        )
        .catch(
          function(error) {
            this.errors.push(error.response.data.errors);
            console.log(this.errors);
          }.bind(this)
        );
    },
    setDay: function(day) {
      this.day = day;
    },
    setWeekOffset: function(direction) {
      if (direction === "next") {
        this.weekOffset += 1;
        console.log(this.weekOffset);
      } else {
        if (this.weekOffset !== 0) {
          this.weekOffset -= 1;
          console.log(this.weekOffset);
        }
      }
    }
  },
  computed: {
    weeklyAttendanceRecords: function() {
      return this.attendanceRecords.filter(
        function(ar) {
          return ar.week_number === ar.current_week_number + this.weekOffset;
        }.bind(this)
      );
    },
    sunday: function() {
      return this.weeklyAttendanceRecords[0];
    },
    gcalUrl: function() {
      var url =
        "http://www.google.com/calendar/event?action=TEMPLATE&text=" +
        this.student.first_name +
        "%27s%20Mathnasium%20Session&dates=" +
        this.gcalDate +
        "&location=1101%20Chicago%20Ave%2C%20Oak%20Park%2C%20IL";
      return url;
    }
  }
};

var Carpool = {
  template: "#carpool",
  data: function() {
    return {
      booking: {},
      carpools: [],
      carpool: {},
      initialCarpool: {},
      waypoint: "",
      carpoolName: "",
      spots: 3,
      userAddress: "",
      request: "",
      details: "",
      newStart: null,
      students: [],
      start: "Downtown Oak Park",
      updateResponse: "",
      createResponse: "",
      selectedCarpool: ""
    };
  },
  created: function() {
    axios.get("/v1/bookings/" + this.$route.params.id).then(
      function(response) {
        this.booking = response.data;
        this.userAddress = response.data.user_address;
        var params = {
          attendance_record_id: this.booking.attendance_record_id
        };
        axios.get("/v1/carpools", { params: params }).then(
          function(response) {
            this.carpools = response.data;
            console.log("at-created carpools:", this.carpools);
            if (this.booking.carpool) {
              var carpool = this.carpools.filter(
                carpool => carpool.id === this.booking.carpool.id
              );
              this.carpool = carpool[0];
              this.initialCarpool = this.carpool;
              this.selectedCarpool = this.carpool;
            }
            console.log("carpool if booking has c_id:", this.carpool);
          }.bind(this)
        );
      }.bind(this)
    );
  },
  mounted: function() {
    var directionsService = new google.maps.DirectionsService();
    var directionsDisplay = new google.maps.DirectionsRenderer();
    var map = new google.maps.Map(document.getElementById("carpoolmap"), {
      zoom: 14,
      center: { lat: 41.894089, lng: -87.802989 }
    });

    directionsDisplay.setMap(map);

    calculateAndDisplayRoute(directionsService, directionsDisplay);
    function calculateAndDisplayRoute(directionsService, directionsDisplay) {
      var waypts = [];

      directionsService.route({}, function(response, status) {
        if (status === "OK") {
          directionsDisplay.setDirections(response);
          var route = response.routes[0];
        } else {
          window.alert("Directions request failed due to " + status);
        }
      });
    }
  },
  methods: {
    showCarpool: function() {
      console.log(this.carpool);
    },
    fullName: function() {
      return (
        this.selectedCarpool.user.first_name +
        " " +
        this.selectedCarpool.user.last_name
      );
    },
    spotsAvailable: function() {
      if (this.selectedCarpool) {
        return (
          this.selectedCarpool.spots - this.selectedCarpool.bookings.length + 1
        );
      }
    },
    sessionDetails: function() {
      return this.selectedCarpool.date + " at " + this.selectedCarpool.time;
    },
    addMathnasium: function() {
      if (this.details === "Driver to") {
        return true;
      } else if (this.details === "Driver from") {
        return true;
      }
    },
    setStart: function() {
      var start = this.carpool.start;
      var waypoints = this.carpool.waypoints;

      var map = new google.maps.Map(document.getElementById("carpoolmap"), {
        zoom: 14,
        center: { lat: 41.894089, lng: -87.802989 }
      });
      var directionsService = new google.maps.DirectionsService();
      var directionsDisplay = new google.maps.DirectionsRenderer();
      directionsDisplay.setMap(map);

      calculateAndDisplayRoute(directionsService, directionsDisplay);

      function calculateAndDisplayRoute(directionsService, directionsDisplay) {
        var waypts = [];
        if (waypoints) {
          waypoints.forEach(waypoint =>
            waypts.push({
              location: waypoint,
              stopover: true
            })
          );
        }
        directionsService.route(
          {
            origin: start,
            destination: "1101 Chicago Ave 60302",
            waypoints: waypts,
            optimizeWaypoints: true,
            travelMode: "DRIVING"
          },
          function(response, status) {
            if (status === "OK") {
              directionsDisplay.setDirections(response);
              var route = response.routes[0];
              // var summaryPanel = document.getElementById("directions-panel");
              // summaryPanel.innerHTML = "";
              // // For each route, display summary information.
              // for (var i = 0; i < route.legs.length; i++) {
              //   var routeSegment = i + 1;
              //   summaryPanel.innerHTML +=
              //     "<b>Route Segment: " + routeSegment + "</b><br>";
              //   summaryPanel.innerHTML += route.legs[i].start_address + " to ";
              //   summaryPanel.innerHTML += route.legs[i].end_address + "<br>";
              //   summaryPanel.innerHTML +=
              //     route.legs[i].distance.text + "<br><br>";
              // }
            } else {
              window.alert("Directions request failed due to " + status);
            }
          }
        );
      }
    },
    // ^ end of setAddress()
    addWaypoint: function() {
      var waypoint = this.userAddress;
      var waypoints = this.carpool.waypoints;

      // Don't add duplicate waypoints or add start as waypoint when start is start
      if (!waypoints.includes(waypoint) && this.carpool.start !== waypoint) {
        waypoints.push(waypoint);
      }

      var start = this.carpool.start;

      var map = new google.maps.Map(document.getElementById("carpoolmap"), {
        zoom: 14,
        center: { lat: 41.894089, lng: -87.802989 }
      });
      var directionsService = new google.maps.DirectionsService();
      var directionsDisplay = new google.maps.DirectionsRenderer();
      directionsDisplay.setMap(map);

      calculateAndDisplayRoute(directionsService, directionsDisplay);
      function calculateAndDisplayRoute(directionsService, directionsDisplay) {
        var waypts = [];

        waypoints.forEach(waypoint =>
          waypts.push({
            location: waypoint,
            stopover: true
          })
        );

        directionsService.route(
          {
            origin: start,
            destination: "1101 Chicago Ave 60302",
            waypoints: waypts,
            optimizeWaypoints: true,
            travelMode: "DRIVING"
          },
          function(response, status) {
            if (status === "OK") {
              directionsDisplay.setDirections(response);
              var route = response.routes[0];
            } else {
              window.alert("Directions request failed due to " + status);
            }
          }
        );
      }
    },
    // ^ end of addWaypoint()
    joinCarpool: function() {
      this.addWaypoint();
      var params = {
        waypoint: this.userAddress,
        booking_id: this.$route.params.id
      };
      if (this.newStart) {
        params["start"] = this.newStart;
      }

      console.log("params:", params);
      axios.patch("/v1/carpools/" + this.carpool.id, params).then(
        function(response) {
          var updatedCarpool = this.carpools.filter(
            carpool => carpool.id === this.carpool.id
          );
          updatedCarpool = response.data;
          console.log("updatedCarpool:", updatedCarpool);
          console.log("this.carpools:", this.carpools);
          this.updateResponse = response.data;
          this.selectedCarpool = response.data;
          this.carpool = response.data;
        }.bind(this)
      );
    },
    createCarpool: function() {
      var params = {
        name: this.carpoolName,
        ar_id: this.booking.attendance_record_id,
        start: this.userAddress,
        spots: this.spots,
        booking_id: this.booking.id,
        request: this.request
      };
      axios.post("/v1/carpools", params).then(
        function(response) {
          this.createResponse = response.data;
          this.selectedCarpool = response.data;
          this.carpool = response.data;
          this.carpools.push(this.carpool);
          this.carpoolName = "";
          this.start = this.userAddress;
          this.userAddress = "";
          this.spots = 3;
        }.bind(this)
      );
    },
    setNewStart: function() {
      this.newStart = this.userAddress;
    },
    keepStart: function() {
      this.newStart = null;
    }
  },
  // ^ end of methods
  watch: {
    carpool: function() {
      this.selectedCarpool = this.carpool;
      this.setStart();
    }
  }
};

var AdminPage = {
  template: "#admin",
  data: function() {
    return {
      day: "Sunday",
      attendanceRecords: [],
      accounts: [],
      account: "Select Account...",
      students: [],
      student: [],
      errors: "",
      tab: "view",
      weekOffset: 0,
      arID: null
    };
  },
  created: function() {
    axios.get("/v1/attendance_records").then(
      function(response) {
        this.attendanceRecords = response.data;
        console.log(this.attendanceRecords);
      }.bind(this)
    );
    axios.get("/v1/accounts").then(
      function(response) {
        this.accounts = response.data;
        console.log(this.accounts);
      }.bind(this)
    );
    axios.get("/v1/students").then(
      function(response) {
        this.students = response.data;
        console.log(this.students);
      }.bind(this)
    );
  },
  methods: {
    setTab: function(tab) {
      this.tab = tab;
    },
    setWeekOffset: function(direction) {
      if (direction === "next") {
        this.weekOffset += 1;
        console.log(this.weekOffset);
      } else {
        this.weekOffset -= 1;
        console.log(this.weekOffset);
      }
    },
    printSunday: function() {
      console.log(this.sunday);
    },
    setDay: function(day) {
      this.day = day;
    },
    toggleAdd: function(id) {
      if (this.arID === id) {
        this.arID = null;
      } else {
        this.arID = id;
      }
    },
    addStudent: function(date, time) {
      // getting student ID (because full name was required for value of v-for)
      var firstAndLast = this.student.split(" ");
      var studentId = this.students
        .filter(
          student =>
            student.first_name === firstAndLast[0] &&
            student.last_name === firstAndLast[1]
        )
        .map(student => student.id);
      // booking request
      var params = {
        student_id: studentId[0],
        time: time,
        date: date,
        ar_id: this.arID
      };
      axios.post("/v1/bookings", params).then(
        function(response) {
          this.bookResponse = response.data;
          if (response.data.error) {
            this.errors.push(response.data.error);
          }
          this.student = [];
          axios.get("/v1/attendance_records").then(
            function(response) {
              this.attendanceRecords = response.data;
              console.log(this.attendanceRecords);
            }.bind(this)
          );
        }.bind(this)
      );
    },
    removeStudent: function(id) {
      var params = {
        status: "Cancelled"
      };
      axios.patch("/v1/bookings/" + id, params).then(
        function(response) {
          axios.get("/v1/attendance_records").then(
            function(response) {
              this.attendanceRecords = response.data;
              console.log(this.attendanceRecords);
            }.bind(this)
          );
        }.bind(this)
      );
    },
    book: function(id) {
      var params = {
        status: "Booked"
      };
      axios.patch("/v1/bookings/" + id, params).then(
        function(response) {
          axios.get("/v1/attendance_records").then(
            function(response) {
              this.attendanceRecords = response.data;
            }.bind(this)
          );
        }.bind(this)
      );
    },
    dbDelete: function(id) {
      axios.delete("/v1/bookings/" + id).then(
        function(response) {
          axios.get("v1/attendance_records").then(
            function(response) {
              this.attendanceRecords = response.data;
            }.bind(this)
          );
        }.bind(this)
      );
    },
    standby: function(id) {
      var params = {
        status: "Standby"
      };
      axios.patch("/v1/bookings/" + id, params).then(
        function(response) {
          axios.get("/v1/attendance_records").then(
            function(response) {
              this.attendanceRecords = response.data;
            }.bind(this)
          );
        }.bind(this)
      );
    }
  },
  computed: {
    weeklyAttendanceRecords: function() {
      return this.attendanceRecords.filter(
        function(ar) {
          return ar.week_number === ar.current_week_number + this.weekOffset;
        }.bind(this)
      );
    },
    sunday: function() {
      return this.weeklyAttendanceRecords[0];
    }
  }
};

var AuthPage = {
  template: "#auth-page",
  data: function() {
    return {
      firstName: "",
      lastName: "",
      loginEmail: "",
      signupEmail: "",
      account: "",
      relationship: "",
      phoneNumber: "",
      address: "",
      zip: "",
      loginPassword: "",
      password: "",
      passwordConfirmation: "",
      signupSuccess: "",
      signupErrors: null,
      loginErrors: null
    };
  },
  methods: {
    submitSignup: function() {
      var params = {
        first_name: this.firstName,
        last_name: this.lastName,
        account: this.account,
        relationship: this.relationship,
        phone_number: this.phoneNumber,
        address: this.address,
        zip: this.zip,
        email: this.signupEmail,
        password: this.password,
        password_confirmation: this.passwordConfirmation
      };
      axios
        .post("/v1/users", params)
        .then(
          function(response) {
            this.signupSuccess = response;
            console.log(this.signupSuccess);
            this.loginEmail = this.signupEmail;
            this.loginPassword = this.password;
            this.submitLogin();
            router.push("/profile");
            location.reload();
          }.bind(this)
        )
        .catch(
          function(error) {
            this.signupErrors = error.response.data.errors;
            console.log(this.signupErrors);
          }.bind(this)
        );
      this.firstName = "";
      this.lastName = "";
      this.relationship = "";
      this.phoneNumber = "";
      this.signupEmail = "";
      this.password = "";
      this.passwordConfirmation = "";
      this.loginEmail = "";
      this.loginPassword = "";
    },

    submitLogin: function() {
      var params = {
        auth: { email: this.loginEmail, password: this.loginPassword }
      };
      axios
        .post("/user_token", params)
        .then(function(response) {
          axios.defaults.headers.common["Authorization"] =
            "Bearer " + response.data.jwt;
          localStorage.setItem("jwt", response.data.jwt);
          localStorage.setItem("account_id", response.data.user.account_id);
          localStorage.setItem("id", response.data.user.id);
          localStorage.setItem("name", response.data.user.first_name);
          console.log(localStorage.getItem("account_id"));
          router.push("/book");
          location.reload();
        })
        .catch(
          function(error) {
            this.loginErrors = ["Invalid email or password."];
            this.email = "";
            this.password = "";
          }.bind(this)
        );
      this.email = "";
      this.password = "";
    }
  }
};

var LogoutPage = {
  template: "<h1>Logout</h1>",
  created: function() {
    axios.defaults.headers.common["Authorization"] = undefined;
    localStorage.removeItem("jwt");
    localStorage.removeItem("account_id");
    localStorage.removeItem("id");
    router.push("/");
    location.reload();
  }
};

var router = new VueRouter({
  routes: [
    { path: "/", component: HomePage },
    { path: "/book", component: Booking },
    { path: "/schedule", component: Schedule },
    { path: "/profile", component: Profile },
    { path: "/auth", component: AuthPage },
    { path: "/logout", component: LogoutPage },
    { path: "/admin", component: AdminPage },
    { path: "/carpool/:id", component: Carpool }
  ],
  scrollBehavior: function(to, from, savedPosition) {
    return { x: 0, y: 0 };
  }
});

var app = new Vue({
  el: "#vue-app",
  router: router,
  data: function() {
    return {
      admin: true,
      jwt: "",
      name: localStorage.getItem("name")
    };
  },
  created: function() {
    this.jwt = localStorage.getItem("jwt");
    if (this.jwt) {
      axios.defaults.headers.common["Authorization"] = this.jwt;
    }
  },
  methods: {}
});
