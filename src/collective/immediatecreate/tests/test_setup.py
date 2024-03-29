"""Setup tests for this package."""
from collective.immediatecreate.testing import (
    COLLECTIVE_IMMEDIATECREATE_INTEGRATION_TESTING,
)
from plone import api
from plone.app.testing import setRoles
from plone.app.testing import TEST_USER_ID
from Products.CMFPlone.utils import get_installer

import unittest


class TestSetup(unittest.TestCase):
    """Test that collective.immediatecreate is properly installed."""

    layer = COLLECTIVE_IMMEDIATECREATE_INTEGRATION_TESTING

    def setUp(self):
        """Custom shared utility setup for tests."""
        self.portal = self.layer["portal"]
        self.installer = get_installer(self.portal, self.layer["request"])

    def test_product_installed(self):
        """Test if collective.immediatecreate is installed."""
        self.assertTrue(
            self.installer.is_product_installed("collective.immediatecreate")
        )

    def test_browserlayer(self):
        """Test that ICollectiveImmediatecreateLayer is registered."""
        from collective.immediatecreate.interfaces import (
            ICollectiveImmediatecreateLayer,
        )
        from plone.browserlayer import utils

        self.assertIn(ICollectiveImmediatecreateLayer, utils.registered_layers())


class TestUninstall(unittest.TestCase):

    layer = COLLECTIVE_IMMEDIATECREATE_INTEGRATION_TESTING

    def setUp(self):
        self.portal = self.layer["portal"]
        self.installer = get_installer(self.portal, self.layer["request"])
        roles_before = api.user.get_roles(TEST_USER_ID)
        setRoles(self.portal, TEST_USER_ID, ["Manager"])
        self.installer.uninstall_product("collective.immediatecreate")
        setRoles(self.portal, TEST_USER_ID, roles_before)

    def test_product_uninstalled(self):
        """Test if collective.immediatecreate is cleanly uninstalled."""
        self.assertFalse(
            self.installer.is_product_installed("collective.immediatecreate")
        )

    def test_browserlayer_removed(self):
        """Test that ICollectiveImmediatecreateLayer is removed."""
        from collective.immediatecreate.interfaces import (
            ICollectiveImmediatecreateLayer,
        )
        from plone.browserlayer import utils

        self.assertNotIn(ICollectiveImmediatecreateLayer, utils.registered_layers())
