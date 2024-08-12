from selenium import webdriver
from weasyprint import HTML
import time

driver = webdriver.Chrome()
options.headless = True
driver.get("https://sitereport.netcraft.com/?url=https://")
time.sleep(12)
with open("a.pdf", "w") as f:
    f.write(driver.page_source)
    
lines = [line for line in open("a.pdf").readlines() if "webbug_graph" and "href=\"#" not in line]
for i in range(len(lines)-1, 12, -1):
    if "Not Present" in lines[i] or "Unknown" in lines[i] or "unknown" in lines[i]:
        for j in range(i, 0, -1):
            if "<tr" in lines[j]:
                del lines[j]
                i -= j
                break
            del lines[j]
assets = [i for i, line in enumerate(lines) if "assets" in line][0]
background_table_section = [i for i, line in enumerate(lines) if "background_table_section" in line][0]
ip_geolocation_section = [i for i, line in enumerate(lines) if "ip_geolocation_section" in line][0]
ssl_table_section = [i for i, line in enumerate(lines) if "ssl_table_section" in line][0]

with open("a.pdf", "w") as f:
    f.writelines(lines[assets:assets+4] + lines[background_table_section:ip_geolocation_section] + lines[ssl_table_section:-85])

HTML(filename="a.pdf").write_pdf("a.pdf")

driver.quit()
