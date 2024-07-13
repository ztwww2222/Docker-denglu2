from playwright.sync_api import Playwright, sync_playwright, expect
import random
import time
import sys
import json
import os
import re
from urllib.parse import urlparse
try:
    from sendNotify import send
except:
    def send(*args):
        print("未找到通知文件sendNotify.py不启用通知！")
List = []
url_components = []

# Modify URLs based on environment variables...
if 'SPACE_HOST' in os.environ:
    url_components.append(f"https://{os.environ['SPACE_HOST']}")

if 'RENDER_EXTERNAL_URL' in os.environ:
    url_components.append(os.environ['RENDER_EXTERNAL_URL'])

if 'KOYEB_PUBLIC_DOMAIN' in os.environ:
    url_components.append(f"https://{os.environ['KOYEB_PUBLIC_DOMAIN']}")

if 'WORKSPACE_DEV_DOMAIN' in os.environ:
    url_components.append(f"https://{os.environ['WORKSPACE_DEV_DOMAIN']}")

if 'CSB_BASE_PREVIEW_HOST' in os.environ:
    url_components.append(f"https://{os.environ['CSB_SANDBOX_ID']}-{os.environ['PORT']}.{os.environ['CSB_BASE_PREVIEW_HOST']}")

# Add the original BAOHUO_URL at the end
if 'BAOHUO_URL' in os.environ:
    url_components.append(os.environ['BAOHUO_URL'])

# Join all components into a single URL
url_str = ';'.join(url_components)

# Strip leading/trailing whitespace and split into a list
urls = [url.strip() for url in url_str.split(";")]

wait_time = random.randint(30, 90)
sleep_time = random.randint(5, 15)
def save_cookies(page, filename):
    cookies = page.context.cookies()
    with open(filename, 'w') as f:
        f.write(json.dumps(cookies))

def load_cookies(page, filename):
    if os.path.exists(filename):
        with open(filename, 'r') as f:
            cookies = json.load(f)
            page.context.add_cookies(cookies)
            
def is_valid_url(url):
    try:
        result = urlparse(url)
        return all([result.scheme, result.netloc])
    except ValueError:
        return False

def run(playwright: Playwright) -> None:
    browser = playwright.firefox.launch(headless=True)
    context = browser.new_context()
    bet_pw = os.environ.get('GOORM_PW')
    if bet_pw:
      print("开始goorm保活")
      sys.stdout.flush()
      List.append(f"开始goorm保活")
      page = context.new_page()
      page.set_default_timeout(30000)
      load_cookies(page, 'cookies.json')
      page.goto("https://accounts.goorm.io/login?keep_login=true")
      time.sleep(5)
      page.wait_for_load_state('domcontentloaded')
      page_content = page.content()
      if 'Sign in' in page_content:
        print("login goorm with PW")
        List.append(f"login goorm with PW")
        sys.stdout.flush()
        username, password = bet_pw.split(';')
        page.get_by_placeholder("Email").click()
        page.get_by_placeholder("Email").fill(username)
        page.get_by_placeholder("Password").click()
        page.get_by_placeholder("Password").fill(password)
        page.get_by_label("Keep me logged in").check()
        page.get_by_role("button", name="Login").click()
        time.sleep(5)
      else:
        print("Using saved cookies for login")
        sys.stdout.flush()
        List.append(f"Using saved cookies for login")
        time.sleep(5)
      page.goto("https://ide.goorm.io/my/dashboard")  
      time.sleep(5)  
      page.wait_for_load_state('domcontentloaded')
      page_content = page.content()
      if 'containers' in page_content:
        print("login goorm sucessful")
        sys.stdout.flush()
        List.append(f"login goorm sucessful")
        time.sleep(5) 
        page.wait_for_load_state('domcontentloaded')
        page_content = page.content()
        if 'Stop' in page_content:
          print("goorm is running")
          sys.stdout.flush()
          List.append(f"goorm is running")
          with page.expect_popup() as page1_info:
               page.get_by_role("button", name="Run").click()
          page1 = page1_info.value
          time.sleep(30)
        else:
          print("goorm is stop ,will restart")
          sys.stdout.flush()
          List.append(f"goorm is stop ,will restart")
          with page.expect_popup() as page1_info:
               page.get_by_role("button", name="Run").click()
          page1 = page1_info.value
          time.sleep(30)
          page.bring_to_front()
          page.goto("https://ide.goorm.io/my/dashboard") 
          page.wait_for_load_state('domcontentloaded')
          page_content = page.content()
          if 'Stop' in page_content:
            print("goorm is running")
            sys.stdout.flush()
            List.append(f"goorm is running")
          else:
            with page.expect_popup() as page1_info:
               page.get_by_role("button", name="Run").click()
            page1 = page1_info.value
            time.sleep(30)
      else:
        print("login goorm fail")
        sys.stdout.flush()
        List.append(f"login goorm fail")
        pass
       
    else:
      pass
    save_cookies(page, 'cookies.json') 
    tt = '\n'.join(List)
    send(f'=====<保活信息>=====', tt)
    print("开始网址保活")
    sys.stdout.flush()
    page2 = context.new_page()
    for count in range(1, 2):

          page2.bring_to_front()
          for i, url in enumerate(urls):
              url = url.strip()
              if is_valid_url(url):
                  try:
                      print(f"Going to {url}")
                      sys.stdout.flush()
                      page2.goto(url)
                      time.sleep(sleep_time)
                  except Exception as e:
                      print(f"Error visiting {url}: {str(e)}")
                      sys.stdout.flush()
              else:
                  print(f"Invalid URL: {url}")
                  sys.stdout.flush()

    try:
      page2.close()
    except Exception:
      pass
    try:
      page.close()
    except Exception:
      pass
    try:
      page1.close()
    except Exception:
      pass
    context.close()
    browser.close()
with sync_playwright() as playwright:
    run(playwright)

