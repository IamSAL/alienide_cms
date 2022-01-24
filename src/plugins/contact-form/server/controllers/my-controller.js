'use strict';

module.exports = {
  index(ctx) {
    ctx.body = strapi
      .plugin('contact-form')
      .service('myService')
      .getWelcomeMessage();
  },
};
