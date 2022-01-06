'use strict';

module.exports = {
  index(ctx) {
    ctx.body = strapi
      .plugin('menu-manager')
      .service('myService')
      .getWelcomeMessage();
  },
};
