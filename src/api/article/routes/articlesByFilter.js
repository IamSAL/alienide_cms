module.exports = {
  routes: [
    {
      method: "GET",
      path: "/articles/:filter/:value",
      handler: "article.findByFilter",
      config: {
        auth: false,
      },
    },
  ],
};
