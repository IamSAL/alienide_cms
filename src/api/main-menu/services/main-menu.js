'use strict';

/**
 * main-menu service.
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::main-menu.main-menu');
