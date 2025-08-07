# -*- coding: utf-8 -*-

def remove(e, soup):
    e.decompose()

# list items are always rendered on new-lines in ELinks...
def to_span(e, soup):
    span = soup.new_tag('span')
    span.contents = e.contents
    span.insert(0, soup.new_string(' • '.decode('utf-8')))
    e.replaceWith(span)

def add_border(e, soup):
    e['border'] = 1
    e['frame'] = 'box'

def add_padding(e, soup):
    level = int(e['width']) / 40
    td = soup.new_tag('td')
    td['colspan'] = level
    e.parent.insert(0, td)

modify = {
    'news.ycombinator.com' : [
        ('img[src="y18.gif"]', remove),
        ('table.itemlist, table.comment-tree', add_border),
        ('table.comment-tree > tr td img', add_padding),
    ],

    'tolkiengateway.net' : [
        # pattern is CSS selector
        ('label[for=searchInput]', remove),
        ('input#searchGoButton', remove),
        # you can also use lambdas:
        ('div.magnify', lambda e, soup: e.decompose()),
        ('.pBody > ul > li', to_span),
    ],

    'docs.python.org' : [
        ('div[role=navigation] > ul > li', to_span),
    ]
}

# regex substitutions
replace = {
    'tolkiengateway.net' : [
        ('<table border="0"', '<table border="1"'),
    ]
}
