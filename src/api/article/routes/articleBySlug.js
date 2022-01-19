module.exports = {
  routes: [
    {
      method: "GET",
      path: "/articles/single/:slug",
      handler: "article.findBySlug",
      config: {
        auth: false,
      },
    },
  ],
};
