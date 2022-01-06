/*
 *
 * HomePage
 *
 */
import { useStrapiApp, useNotification } from "@strapi/helper-plugin";
import React, { memo, useEffect } from "react";
import { Link } from "@strapi/design-system/Link";
// import PropTypes from 'prop-types';
import pluginId from "../../pluginId";
import { useLibrary } from "@strapi/helper-plugin";

import { Box } from "@strapi/design-system/Box";
import { Button } from "@strapi/design-system/Button";
import { BaseHeaderLayout, HeaderLayout } from "@strapi/design-system/Layout";
import { ArrowLeft, Plus, Pencil } from "@strapi/icons";
const HomePage = () => {
  return (
    <Box background="neutral100">
      <BaseHeaderLayout
        primaryAction={<Button startIcon={<Plus />}>Add a menu</Button>}
        title="Menus"
        subtitle="3 menus found"
        as="h2"
      />
    </Box>
  );
};

export default memo(HomePage);
