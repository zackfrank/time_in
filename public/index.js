/* global Vue, VueRouter, axios */

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
      bookings: null,
      tab: "history"
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
    }
  },
  computed: {}
};

var Booking = {
  template: "#booking",
  data: function() {
    return {
      attendanceRecords: [],
      weekend: false,
      weekday: true,
      accountId: null,
      day: "Sunday",
      time: null,
      date: null,
      formattedDate: null,
      students: null,
      student: { first_name: "Blank" },
      bookingResponse: null,
      errors: null,
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
    setTimeDateGcal: function(time, date, gcal) {
      this.time = time;
      this.date = date;
      this.gcalDate = gcal;
    },
    bookSession: function() {
      var params = {
        time: this.time,
        date: this.date,
        student_id: this.student.id
      };
      console.log(params);
      axios
        .post("v1/bookings", params)
        .then(
          function(response) {
            this.bookingResponse = response;
            console.log(response);
          }.bind(this)
        )
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    },
    setDay: function(day) {
      this.day = day;
      console.log(this.day);
      if (day !== "Saturday" && day !== "Sunday" && day !== "Friday") {
        this.weekend = false;
        this.weekday = true;
      } else if (day === "Saturday" || day === "Sunday") {
        this.weekend = true;
        this.weekday = false;
      } else {
        this.weekend = false;
        this.weekday = false;
      }
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

var AuthPage = {
  template: "#auth-page",
  data: function() {
    return {
      firstName: "",
      lastName: "",
      loginEmail: "",
      signupEmail: "",
      // account: "",
      relationship: "",
      phoneNumber: "",
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
        relationship: this.relationship,
        phone_number: this.phoneNumber,
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
          console.log(localStorage.getItem("account_id"));
          router.push("/book");
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
  }
};

var AdminPage = {
  template: "#admin",
  data: function() {
    return {
      attendanceRecords: [],
      tab: "view",
      weekOffset: 0
    };
  },
  created: function() {
    axios.get("/v1/attendance_records").then(
      function(response) {
        this.attendanceRecords = response.data;
        console.log(this.attendanceRecords);
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

var router = new VueRouter({
  routes: [
    { path: "/", component: HomePage },
    { path: "/book", component: Booking },
    { path: "/schedule", component: Schedule },
    { path: "/profile", component: Profile },
    { path: "/auth", component: AuthPage },
    { path: "/logout", component: LogoutPage },
    { path: "/admin", component: AdminPage }
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
      page: localStorage.getItem("page") || "home",
      admin: true
    };
  },
  created: function() {
    var jwt = localStorage.getItem("jwt");
    if (jwt) {
      axios.defaults.headers.common["Authorization"] = jwt;
    }
  },
  methods: {
    setPage: function(page) {
      localStorage.setItem("page", page);
      this.page = localStorage.getItem("page");
    },
    bookingButton: function() {}
  }
  // computed: {
  //   pageSet: function() {
  //     localStorage.setItem("page", window.location.hash);
  //   }
  // }
});
