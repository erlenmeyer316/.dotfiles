impor os
import re
import subprocess
from bs4 import BeautifulSoup

import rules

def replacer(url, html):
    new = html
    reload(rules)
    for pattern in rules.replace:
        if pattern in url:
            for replacement in rules.replace[pattern]:
                new = re.sub(replacement[0], replacement[1], new)
    return new

def modifier(url, html):
    soup = BeautifulSoup(html, 'html.parser')
    soup.select
    reload(rules)
    for pattern in rules.modify:
        if pattern in url:
            for selector in rules.modify[pattern]:
                [selector[1](e, soup) for e in soup.select(selector[0])]
    return str(soup)

def edit_rules():
    subprocess.call(['nvim', os.environ['HOME'] + '/.elinks/rules.py'])
