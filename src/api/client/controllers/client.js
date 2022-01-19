"use strict";

/**
 *  client controller
 */
const {
  resolveImagePaths,
} = require("../../../utils/functions/resolveImagePaths");
const { imageResource } = require("../../../utils/resources/image.resource");
const { createCoreController } = require("@strapi/strapi").factories;

module.exports = createCoreController("api::client.client");
