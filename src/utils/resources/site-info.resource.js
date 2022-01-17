const { menuItemResource } = require("./menu-item.resource");
const { imageResource } = require("./image.resource");
const { contactInfoResource } = require("./contact_info.resource");
const siteInfoResource = {
  site_logo: {
    populate: {
      normal: imageResource,
      dark: imageResource,
      light: imageResource,
      loader: imageResource,
    },
  },
  menus: {
    populate: {
      primary_menu: menuItemResource,
      footer_menu_left: menuItemResource,
      footer_menu_right: menuItemResource,
    },
  },
  contact_info: contactInfoResource,
};

module.exports = { siteInfoResource };
