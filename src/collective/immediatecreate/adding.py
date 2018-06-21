# -*- coding: utf-8 -*-
from interfaces import IFolderish
from plone import api
from plone.protect.utils import addTokenToUrl
from Products.CMFCore.interfaces import ITypesTool
from Products.Five.browser import BrowserView
from zope.component import adapter
from zope.component import getUtility
from zope.interface import implementer
from zope.interface import Interface
from zope.location.interfaces import LocationError
from zope.traversing.interfaces import ITraversable


class ImmediateAddView(BrowserView):
    def __init__(self, context, request, fti):
        super(ImmediateAddView, self).__init__(context, request)
        self.fti = fti

    def __call__(self):
        # construct content
        newcontent = api.content.create(
            container=self.context,
            type=self.fti,
            id="immediate-{0:s}".format(self.fti.getId()),
            safe_id=True,
            collective_immediatecreate="initial",
        )
        url = newcontent.absolute_url() + "/immediate-edit"
        url = newcontent.absolute_url() + "/edit"
        url = addTokenToUrl(url)
        self.request.response.redirect(url)


@adapter(IFolderish, Interface)
@implementer(ITraversable)
class ImmediateAddViewTraverser(object):

    """Immediate add view traverser.
    """

    def __init__(self, context, request):
        self.context = context
        self.request = request

    def traverse(self, name, ignored):
        ttool = getUtility(ITypesTool)
        fti = ttool.getTypeInfo(name)
        if fti is None:
            raise LocationError(self.context, name)
        return ImmediateAddView(self.context, self.request, fti)
