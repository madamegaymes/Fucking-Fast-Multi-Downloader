# Import necessary library
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
<a href="https://fuckingfast.co/angjzffndnmc#Cities_-_Skylines_II_--_fitgirl-repacks.site_--_.part59.rar" target="_blank" rel="noopener nofollow">Cities_-_Skylines_II_–_fitgirl-repacks.site_–_.part59.rar</a><br>
<a href="https://fuckingfast.co/4hqijxvn7z87#Cities_-_Skylines_II_--_fitgirl-repacks.site_--_.part60.rar" target="_blank" rel="noopener nofollow">Cities_-_Skylines_II_–_fitgirl-repacks.site_–_.part60.rar</a><br>
<a href="https://fuckingfast.co/069kog2yktba#Cities_-_Skylines_II_--_fitgirl-repacks.site_--_.part61.rar" target="_blank" rel="noopener nofollow">Cities_-_Skylines_II_–_fitgirl-repacks.site_–_.part61.rar</a><br>
<a href="https://fuckingfast.co/70v1iuovqvon#Cities_-_Skylines_II_--_fitgirl-repacks.site_--_.part62.rar" target="_blank" rel="noopener nofollow">Cities_-_Skylines_II_–_fitgirl-repacks.site_–_.part62.rar</a><br>
<a href="https://fuckingfast.co/vw0ok4hpddu9#Cities_-_Skylines_II_--_fitgirl-repacks.site_--_.part63.rar" target="_blank" rel="noopener nofollow">Cities_-_Skylines_II_–_fitgirl-repacks.site_–_.part63.rar</a><br>
<a href="https://fuckingfast.co/kraej7pqh6j8#Cities_-_Skylines_II_--_fitgirl-repacks.site_--_.part64.rar" target="_blank" rel="noopener nofollow">Cities_-_Skylines_II_–_fitgirl-repacks.site_–_.part64.rar</a><br>
<a href="https://fuckingfast.co/m49vjww5j5gs#Cities_-_Skylines_II_--_fitgirl-repacks.site_--_.part65.rar" target="_blank" rel="noopener nofollow">Cities_-_Skylines_II_–_fitgirl-repacks.site_–_.part65.rar</a><br>
<a href="https://fuckingfast.co/hrz6x5h1zowv#Cities_-_Skylines_II_--_fitgirl-repacks.site_--_.part66.rar" target="_blank" rel="noopener nofollow">Cities_-_Skylines_II_–_fitgirl-repacks.site_–_.part66.rar</a><br>
<a href="https://fuckingfast.co/4cw093flf9kd#Cities_-_Skylines_II_--_fitgirl-repacks.site_--_.part67.rar" target="_blank" rel="noopener nofollow">Cities_-_Skylines_II_–_fitgirl-repacks.site_–_.part67.rar</a><br>
<a href="https://fuckingfast.co/1ylrlg7cu6nn#fg-optional-bonus-soundtracks.bin" target="_blank" rel="noopener nofollow">fg-optional-bonus-soundtracks.bin</a><br>
    """
    
    extracted_links = extract_links(html_block)
    write_links_to_file(extracted_links, "output.txt")
    print(f"Extracted links have been written to output.txt")
