"use strict";

/**
 *  article controller
 */
const {
  sanitizeArticleData,
} = require("./../../../utils/functions/sanitizeArticleData");
const { createCoreController } = require("@strapi/strapi").factories;

module.exports = createCoreController("api::article.article", ({ strapi }) => ({
  async findBySlug(ctx) {
    const { slug } = ctx.params;
    const article = await strapi.db.query("api::article.article").findOne({
      populate: true,
      where: {
        slug: slug,
      },
    });
    if (!article) {
      return ctx.response.notFound("Article not found");
    }
    return sanitizeArticleData(article);
  },

  async find(ctx) {
    const articles = await strapi.entityService.findMany(
      "api::article.article",
      {
        ...ctx.query,
      }
    );
    return articles.map((article) => sanitizeArticleData(article, ["content"]));
  },
}));
