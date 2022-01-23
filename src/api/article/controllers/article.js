"use strict";

/**
 *  article controller
 */
const { imageResource } = require("../../../utils/resources/image.resource");
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

  async findByFilter(ctx) {
    const { filter, value } = ctx.params;
    const articles = await strapi.db.query("api::article.article").findMany({
      populate: true,
    });
    if (!articles) {
      return ctx.response.notFound("Article not found");
    }
    let filteredArticles = [];
    switch (filter) {
      case "category":
        filteredArticles = articles.filter((a) =>
          a.categories.some((c) => c.slug == value)
        );
        break;
      case "author":
        filteredArticles = articles.filter((a) => (a.createdBy.id = 1));
        break;
      default:
        break;
    }
    return filteredArticles.map((a) => sanitizeArticleData(a, ["content"]));
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
