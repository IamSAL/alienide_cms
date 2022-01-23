"use strict";

/**
 *  blog-category controller
 */
const { imageResource } = require("../../../utils/resources/image.resource");
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
              image: imageResource,
            },
      };
      const categories = await super.find(ctx);
      return categories;
    },
  })
);
