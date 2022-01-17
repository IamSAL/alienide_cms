"use strict";
const {
  siteInfoResource,
} = require("./../../../utils/resources/site-info.resource");
const {
  removeAuthorFields,
} = require("./../../../utils/functions/removeAuthorFields");
/**
 *  site-info controller
 */

const { createCoreController } = require("@strapi/strapi").factories;
const {
  resolveImagePaths,
  prefixAbsoluteURL,
} = require("../../../utils/functions/resolveImagePaths");

module.exports = createCoreController(
  "api::site-info.site-info",
  ({ strapi }) => ({
    async find(ctx) {
      const siteInfo = await strapi.entityService.findOne(
        "api::site-info.site-info",
        1,
        {
          populate: siteInfoResource,
        }
      );

      const server_root = ctx.request.secure
        ? "https://" + ctx.request.host
        : "http://" + ctx.request.host;

      return removeAuthorFields(resolveImagePaths(server_root, siteInfo));
    },

    async getLoaderImg(ctx) {
      const res = await strapi.entityService.findOne(
        "api::site-info.site-info",
        1,
        {
          populate: ["site_logo", "site_logo.loader"],
        }
      );

      const server_root = ctx.request.secure
        ? "https://" + ctx.request.host
        : "http://" + ctx.request.host;

      return prefixAbsoluteURL(server_root, res.site_logo?.loader?.url || "");
    },
  })
);
