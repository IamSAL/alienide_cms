const { imageResource } = require("./image.resource");

const menuItemResource = {
  populate: {
    items: {
      populate: {
        hover_image: imageResource,
        page: {
          fields: ["title", "slug"],
          populate: {
            header_image: imageResource,
          },
        },
      },
    },
  },
};

module.exports = { menuItemResource };
