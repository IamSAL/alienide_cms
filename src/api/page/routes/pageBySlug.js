module.exports = {
  routes: [
    {
      method: "GET",
      path: "/pages/single/:slug",
      handler: "page.findBySlug",
      config: {
        auth: false,
      },
    },
  ],
};
