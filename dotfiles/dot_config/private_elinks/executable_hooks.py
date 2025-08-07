import elinks
import hooks
import devtools

def pre_format_html_hook(url, html):
    reload(devtools)
    html = devtools.modifier(url, html)
    html = devtools.replacer(url, html)
    return html
