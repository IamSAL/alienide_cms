"use strict";
const {
  portfoliosResource,
} = require("./../../../utils/resources/portfolios.resource");
const {
  removeAuthorFields,
} = require("./../../../utils/functions/removeAuthorFields");

const {
  resolveImagePaths,
} = require("../../../utils/functions/resolveImagePaths");
/**
 *  portfolio controller
 */

const { createCoreController } = require("@strapi/strapi").factories;
const { imageResource } = require("../../../utils/resources/image.resource");

module.exports = createCoreController(
  "api::portfolio.portfolio",
  ({ strapi }) => ({
    async findOne(ctx) {
      ctx.query.populate = {
        image: imageResource,
        gallery: {
          populate: {
            images: imageResource,
          },
        },
        category: true,
        keywords: true,
      };
      const portfolio = await super.findOne(ctx);

      return portfolio ? resolveImagePaths(portfolio.data) : portfolio;
    },

    async find(ctx) {
      const portfolios = await strapi.entityService.findMany(
        "api::portfolio.portfolio",
        {
          ...ctx.query,
          fields: ["id", "title", "featured", "description"],
          filters: { ...ctx.query.filters, publishedAt: { $notNull: true } },
          populate: portfoliosResource,
        }
      );

      return resolveImagePaths(portfolios.map(removeAuthorFields));
    },
  })
);
