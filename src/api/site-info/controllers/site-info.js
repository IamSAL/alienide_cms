"use strict";
var fs = require("fs");
var path = require("path");
const mime = require("mime-types");
const {
  siteInfoResource,
} = require("./../../../utils/resources/site-info.resource");
const {
  removeAuthorFields,
} = require("./../../../utils/functions/removeAuthorFields");
const {
  resolveImagePaths,
  prefixAbsoluteURL,
} = require("../../../utils/functions/resolveImagePaths");
/**
 *  site-info controller
 */

const { createCoreController } = require("@strapi/strapi").factories;

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

      return removeAuthorFields(resolveImagePaths(siteInfo));
    },

    async getLoaderImg(ctx) {
      const res = await strapi.entityService.findOne(
        "api::site-info.site-info",
        1,
        {
          populate: ["site_logo", "site_logo.loader"],
        }
      );

      const imgpath = strapi.dirs.public + res.site_logo?.loader?.url;
      ctx.response.set("content-type", mime.lookup(path.basename(imgpath)));
      const src = fs.createReadStream(imgpath);
      ctx.body = src;
    },
  })
);
