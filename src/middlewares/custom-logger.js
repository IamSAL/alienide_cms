module.exports = (config, { strapi }) => {
  return (context, next) => {
    console.log("global middlware");
    next();
  };
};
