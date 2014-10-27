#!/usr/bin/env python3
import sys
import socket
import itertools

from html5lib import constants as html5
from lxml.cssselect import CSSSelector
from lxml import html

__all__ = ['html5_tags', 'lint']


socket.setdefaulttimeout(2)

# use html5lib to build a set of valid html5 tags
html5_sets = itertools.chain(
    html5.scopingElements, html5.formattingElements, html5.specialElements,
    html5.mathmlTextIntegrationPointElements, html5.tableInsertModeElements,
    html5.headingElements, html5.voidElements, html5.cdataElements,
    html5.rcdataElements, html5.htmlIntegrationPointElements)

html5_tags = set(len(i) == 2 and i[1] or i for i in html5_sets)


def lint(url, levels, level=None):
    warnings = []
    errors = []
    defined_elements = []

    import_sel = CSSSelector('link[rel=import]')
    element_sel = CSSSelector('polymer-element')

    doc = html.parse(url)

    for import_el in import_sel(doc):
        href = import_el.attrib.get('href')
        if not href:
            continue
        try:
            imported_doc = html.parse(href)
        except OSError:
            msg = "Import resource not found: \"{}\"".format(url)
            errors.append((import_el, msg))
        else:
            defined_elements.extend(list(element_sel(imported_doc)))

    for el in doc.iter():
        if el.tag in html5_tags:
            continue
        if el.tag not in [e.tag for e in defined_elements]:
            msg = "Element not defined: \"{}\"".format(el.tag)
            warnings.append((el, msg))

    return warnings, errors, defined_elements


if __name__ == "__main__":
    warnings, errors, elements = lint(sys.argv[1], levels=1)

    for el, error in errors:
        print('ERROR: {}: {}'.format(el.sourceline, error))

    for el, warning in warnings:
        print('WARNING: {}: {}'.format(el.sourceline, warning))
