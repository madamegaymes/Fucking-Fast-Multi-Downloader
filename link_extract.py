from bs4 import BeautifulSoup

def extract_links(html_content):
    soup = BeautifulSoup(html_content, 'html.parser')
    links = [a['href'] for a in soup.find_all('a', href=True)]
    
    return links

def write_links_to_file(links, filename):
    with open(filename, 'w') as file:
        for link in links:
            file.write(link + '\n')

if __name__ == "__main__":
    html_block = """
<a href="https://fuckingfast.co/angjzxxxxxxGAME--_fitgirl-repacks.site_--_.part59.rar" target="_blank" rel="noopener nofollow">GAME–_fitgirl-repacks.site_–_.part59.rar</a><br>
<a href="https://fuckingfast.co/4hqijxxxxxxx7#GAME--_fitgirl-repacks.site_--_.part60.rar" target="_blank" rel="noopener nofollow">GAME–_fitgirl-repacks.site_–_.part60.rar</a><br>
<a href="https://fuckingfast.co/069koxxxxxx#GAME--_fitgirl-repacks.site_--_.part61.rar" target="_blank" rel="noopener nofollow">GAME–_fitgirl-repacks.site_–_.part61.rar</a><br>
<a href="https://fuckingfast.co/70v1ixxxxxxGAME--_fitgirl-repacks.site_--_.part62.rar" target="_blank" rel="noopener nofollow">GAME–_fitgirl-repacks.site_–_.part62.rar</a><br>
<a href="https://fuckingfast.co/vw0okxxxxxx#GAME--_fitgirl-repacks.site_--_.part63.rar" target="_blank" rel="noopener nofollow">GAME–_fitgirl-repacks.site_–_.part63.rar</a><br>
<a href="https://fuckingfast.co/kraexxxxxxxxxGAME--_fitgirl-repacks.site_--_.part64.rar" target="_blank" rel="noopener nofollow">GAME–_fitgirl-repacks.site_–_.part64.rar</a><br>
<a href="https://fuckingfast.co/m49vxxxxxxx#GAME--_fitgirl-repacks.site_--_.part65.rar" target="_blank" rel="noopener nofollow">GAME–_fitgirl-repacks.site_–_.part65.rar</a><br>
<a href="https://fuckingfast.co/hrzxxxxxxxGAME--_fitgirl-repacks.site_--_.part66.rar" target="_blank" rel="noopener nofollow">GAME–_fitgirl-repacks.site_–_.part66.rar</a><br>
<a href="https://fuckingfast.co/4cw093xxxxxxxGAME--_fitgirl-repacks.site_--_.part67.rar" target="_blank" rel="noopener nofollow">GAME–_fitgirl-repacks.site_–_.part67.rar</a><br>
    """
    
    extracted_links = extract_links(html_block)
    write_links_to_file(extracted_links, "output.txt")
    print(f"Extracted links have been written to output.txt")
