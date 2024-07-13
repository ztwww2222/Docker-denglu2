from playwright.sync_api import Playwright, sync_playwright
import random
import time
import sys
import json
import os

try:
    from sendNotify import send
except ImportError:
    def send(*args):
        print("未找到通知文件sendNotify.py不启用通知！")

List = []

def save_cookies(page, filename):
    cookies = page.context.cookies()
    with open(filename, 'w') as f:
        f.write(json.dumps(cookies))

def load_cookies(page, filename):
    if os.path.exists(filename):
        with open(filename, 'r') as f:
            cookies = json.load(f)
            page.context.add_cookies(cookies)

def check_url_status(page, url):
    try:
        page.goto(url)
        try:
            page.get_by_test_id("wakeup").click()
            print(f"{url} - stop , will restart")
            sys.stdout.flush()
            List.append(f"{url} - streamlit is stopped, will restart!")
        except Exception:
            print(f"{url} - app is running")
            sys.stdout.flush()
            List.append(f"{url} - streamlit is running!")
    except Exception as e:
        print(f"Error accessing {url}: {str(e)}")
        sys.stdout.flush()
        List.append(f"Error accessing {url}: {str(e)}")

def run(playwright: Playwright) -> None:
    browser = None
    context = None
    try:
        browser = playwright.firefox.launch(headless=True)
        context = browser.new_context()
        page = context.new_page()

        accounts = os.getenv('ST_URL', '')
        if not accounts:
            raise ValueError("Environment variable ST_URL is not set")

        urls = accounts.split(';')
        for url in urls:
            if url.strip():
                check_url_status(page, url.strip())

        tt = '\n'.join(List)
        send('=====<streamlit保活信息>=====', tt)
    
    except Exception as e:
        print(f"Error: {str(e)}")
        sys.stdout.flush()
    finally:
        if page:
            page.close()
        if context:
            context.close()
        if browser:
            browser.close()

with sync_playwright() as playwright:
    run(playwright)

