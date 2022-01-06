'use strict';

/**
 * site-info service.
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::site-info.site-info');
