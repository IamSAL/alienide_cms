module.exports = ({ env }) => ({
  auth: {
    secret: env("ADMIN_JWT_SECRET", "793b7fc11014528ef8c5c7a7d9f64317"),
  },
  url: "/dashboard",
});
