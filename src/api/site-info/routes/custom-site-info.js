module.exports = {
  routes: [
    {
      // Path defined with a URL parameter
      method: "GET",
      path: "/site-info/loader",
      handler: "site-info.getLoaderImg",
      config: {
        auth: false,
      },
    },
  ],
};
