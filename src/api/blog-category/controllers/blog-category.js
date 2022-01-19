"use strict";

/**
 *  blog-category controller
 */

const { createCoreController } = require("@strapi/strapi").factories;

module.exports = createCoreController(
  "api::blog-category.blog-category",
  ({ strapi }) => ({
    async find(ctx) {
      ctx.query = {
        ...ctx.query,
        populate: ctx.query.populate
          ? ctx.query.populate
          : {
              articles: {
                fields: ["slug"],
              },
            },
      };
      const categories = await super.find(ctx);
      return categories;
    },
  })
);
