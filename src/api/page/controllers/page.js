"use strict";

/**
 *  page controller
 */
const {
  getFullPopulateObject,
} = require("./../../../utils/functions/getFullPopulateObject");
const { createCoreController } = require("@strapi/strapi").factories;

module.exports = createCoreController("api::page.page", ({ strapi }) => ({
  async findBySlug(ctx) {
    const { slug } = ctx.params;

    const page = await strapi.db.query("api::page.page").findOne({
      ...getFullPopulateObject("api::page.page"),
      where: {
        slug: slug,
      },
    });
    if (!page) {
      return ctx.response.notFound("Page not found");
    }
    return page;
  },
}));
