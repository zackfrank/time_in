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
      weekend: false,
      weekday: true,
      accountId: "",
      day: "Monday",
      time: "",
      date: "",
      students: null,
      student: "",
      bookingResponse: "",
      errors: ""
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
  },
  methods: {
    bookSession: function() {
      var params = {
        time: this.time,
        date: "2018-4-30",
        student: this.student
      };
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
    }
  },
  computed: {}
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

var router = new VueRouter({
  routes: [
    { path: "/", component: HomePage },
    { path: "/book", component: Booking },
    { path: "/schedule", component: Schedule },
    { path: "/profile", component: Profile },
    { path: "/auth", component: AuthPage },
    { path: "/logout", component: LogoutPage }
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
      page: localStorage.getItem("page") || "home"
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
});
