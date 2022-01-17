const { imageResource } = require("./image.resource");

const contactInfoResource = {
  populate: {
    socials: {
      populate: {
        icon: imageResource,
      },
    },
  },
};

module.exports = { contactInfoResource };
