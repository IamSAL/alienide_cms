module.exports = ({ env }) => ({
  connection: {
    client: "mysql",
    connection: {
      host: env("DATABASE_HOST", "34.126.126.170"),
      port: env.int("DATABASE_PORT", 3306),
      database: env("DATABASE_NAME", "test"),
      user: env("DATABASE_USERNAME", "root"),
      password: env("DATABASE_PASSWORD", "root"),
      ssl: env.bool("DATABASE_SSL", false),
    },
  },
});
